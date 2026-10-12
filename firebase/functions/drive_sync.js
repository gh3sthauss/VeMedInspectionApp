// Copies a report's photos from Firebase Storage into a shared Google Drive
// folder tree and returns view links for the PDF:
//
//   VeMed Reports/
//     CT - Siemens Somatom - SN 12345/      <- "All photos" link
//       01 Gantry/                          <- per-section links
//       02 Cooling System/
//       ...
//
// Sync is incremental and idempotent: the Drive ids of every folder and every
// uploaded photo are remembered in Firestore (driveSync/{reportKey}), so
// re-exporting a report only uploads photos added since the last export and
// trashes photos that were removed from the record.
//
// Auth: an OAuth refresh token for the Google account whose Drive holds the
// photos (scope drive.file - the app can only see files it created). It lives
// in Secret Manager; see tools/drive_auth.js for the one-time setup.

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const crypto = require("crypto");

const SECRETS = [
  "GDRIVE_CLIENT_ID",
  "GDRIVE_CLIENT_SECRET",
  "GDRIVE_REFRESH_TOKEN",
];
const ROOT_FOLDER_NAME = "VeMed Reports";
const FOLDER_MIME = "application/vnd.google-apps.folder";
const DRIVE = "https://www.googleapis.com/drive/v3";
const UPLOAD = "https://www.googleapis.com/upload/drive/v3";
const UPLOAD_CONCURRENCY = 4;

// ---------------------------------------------------------------------------
// Google Drive REST helpers
// ---------------------------------------------------------------------------

async function getAccessToken() {
  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: new URLSearchParams({
      client_id: process.env.GDRIVE_CLIENT_ID,
      client_secret: process.env.GDRIVE_CLIENT_SECRET,
      refresh_token: process.env.GDRIVE_REFRESH_TOKEN,
      grant_type: "refresh_token",
    }),
  });
  if (!res.ok) {
    throw new Error(`Drive token refresh failed: ${res.status} ${await res.text()}`);
  }
  return (await res.json()).access_token;
}

function driveClient(token) {
  async function call(method, url, body) {
    const res = await fetch(url, {
      method,
      headers: {
        "Authorization": `Bearer ${token}`,
        ...(body ? {"Content-Type": "application/json"} : {}),
      },
      body: body ? JSON.stringify(body) : undefined,
    });
    if (res.status === 404) return null;
    if (!res.ok) {
      throw new Error(`Drive ${method} ${url} failed: ${res.status} ${await res.text()}`);
    }
    return res.status === 204 ? {} : res.json();
  }

  return {
    // Returns the folder id if it still exists and is not in the trash.
    async alive(id) {
      if (!id) return null;
      const f = await call("GET", `${DRIVE}/files/${id}?fields=id,trashed`);
      return f && !f.trashed ? id : null;
    },
    async createFolder(name, parentId) {
      const f = await call("POST", `${DRIVE}/files?fields=id`, {
        name,
        mimeType: FOLDER_MIME,
        ...(parentId ? {parents: [parentId]} : {}),
      });
      return f.id;
    },
    rename(id, name) {
      return call("PATCH", `${DRIVE}/files/${id}`, {name});
    },
    trash(id) {
      return call("PATCH", `${DRIVE}/files/${id}`, {trashed: true});
    },
    // Anyone with the link can view; children inherit it.
    shareWithLink(id) {
      return call("POST", `${DRIVE}/files/${id}/permissions`, {
        role: "reader",
        type: "anyone",
      });
    },
    async upload(name, parentId, contentType, bytes) {
      const boundary = `vemed${crypto.randomBytes(12).toString("hex")}`;
      const meta = JSON.stringify({name, parents: [parentId]});
      const body = Buffer.concat([
        Buffer.from(
          `--${boundary}\r\nContent-Type: application/json; charset=UTF-8\r\n\r\n` +
          `${meta}\r\n--${boundary}\r\nContent-Type: ${contentType}\r\n\r\n`),
        bytes,
        Buffer.from(`\r\n--${boundary}--`),
      ]);
      const res = await fetch(`${UPLOAD}/files?uploadType=multipart&fields=id`, {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${token}`,
          "Content-Type": `multipart/related; boundary=${boundary}`,
        },
        body,
      });
      if (!res.ok) {
        throw new Error(`Drive upload failed: ${res.status} ${await res.text()}`);
      }
      return (await res.json()).id;
    },
  };
}

const folderUrl = (id) => `https://drive.google.com/drive/folders/${id}?usp=sharing`;

// ---------------------------------------------------------------------------
// Firebase Storage helpers
// ---------------------------------------------------------------------------

// Maps a Firebase Storage download URL to an object in this project's bucket.
// Only our own bucket and the app's users/ prefix are accepted, so the
// function cannot be used to copy arbitrary files into Drive.
function storageFileFor(url, bucket) {
  const m = /^https:\/\/firebasestorage\.googleapis\.com\/v0\/b\/([^/]+)\/o\/([^?]+)/
      .exec(String(url || ""));
  if (!m || m[1] !== bucket.name) return null;
  const path = decodeURIComponent(m[2]);
  if (!path.startsWith("users/") || path.includes("..")) return null;
  return bucket.file(path);
}

const urlKey = (url) =>
  crypto.createHash("sha1").update(String(url).split("?")[0]).digest("hex");

const cleanName = (s, max = 120) =>
  String(s || "").replace(/[\\/:*?"<>|\r\n\t]+/g, " ").replace(/\s+/g, " ")
      .trim().slice(0, max);

async function mapLimit(items, limit, fn) {
  let next = 0;
  const workers = Array.from({length: Math.min(limit, items.length)}, async () => {
    while (next < items.length) {
      const i = next++;
      await fn(items[i], i);
    }
  });
  await Promise.all(workers);
}

// ---------------------------------------------------------------------------
// Callable: syncReportPhotos
// data: {
//   reportKey: "CT_<docId>",
//   title: "CT - Siemens Somatom - SN 123",
//   sections: [{name: "Gantry", urls: ["https://firebasestorage..."]}, ...]
// }
// returns: {reportUrl, sections: {"Gantry": url, ...}}
// ---------------------------------------------------------------------------

exports.syncReportPhotos = functions
    .runWith({secrets: SECRETS, timeoutSeconds: 300, memory: "1GB"})
    .https.onCall(async (data, context) => {
      if (!context.auth) {
        throw new functions.https.HttpsError("unauthenticated", "Sign in first.");
      }
      const reportKey = cleanName(data && data.reportKey, 200);
      if (!/^[A-Za-z]+_[A-Za-z0-9]+$/.test(reportKey)) {
        throw new functions.https.HttpsError("invalid-argument", "Bad reportKey.");
      }
      const title = cleanName(data.title) || reportKey;
      const sections = (Array.isArray(data.sections) ? data.sections : [])
          .slice(0, 40)
          .map((s) => ({
            name: cleanName(s && s.name, 80),
            urls: (Array.isArray(s && s.urls) ? s.urls : []).slice(0, 500),
          }))
          .filter((s) => s.name);

      const db = admin.firestore();
      const bucket = admin.storage().bucket();
      const drive = driveClient(await getAccessToken());

      // Shared root folder, created once.
      const configRef = db.doc("driveSync/_config");
      const config = (await configRef.get()).data() || {};
      let rootId = await drive.alive(config.rootFolderId);
      if (!rootId) {
        rootId = await drive.createFolder(ROOT_FOLDER_NAME);
        await configRef.set({rootFolderId: rootId}, {merge: true});
      }

      const stateRef = db.doc(`driveSync/${reportKey}`);
      const state = (await stateRef.get()).data() || {};
      const saved = state.sections || {};

      // Report folder (renamed if the brand/model/SN changed since last time).
      let reportId = await drive.alive(state.folderId);
      let shared = !!state.shared && reportId === state.folderId;
      if (!reportId) {
        reportId = await drive.createFolder(title, rootId);
        shared = false;
      } else if (state.title !== title) {
        await drive.rename(reportId, title);
      }
      if (!shared) {
        await drive.shareWithLink(reportId);
        shared = true;
      }

      const nextSections = {};
      const links = {};
      for (let i = 0; i < sections.length; i++) {
        const {name, urls} = sections[i];
        const folderName = `${String(i + 1).padStart(2, "0")} ${name}`;
        const prev = saved[name] || {};
        let folderId = prev.folderId;
        // A section folder left over from a deleted report folder is gone too.
        folderId = folderId && reportId === state.folderId ?
          await drive.alive(folderId) : null;
        const files = folderId ? {...(prev.files || {})} : {};
        if (!folderId) {
          folderId = await drive.createFolder(folderName, reportId);
        } else if (prev.folderName !== folderName) {
          await drive.rename(folderId, folderName);
        }

        // Upload photos we have not copied yet.
        const wanted = new Map();
        for (const url of urls) {
          const file = storageFileFor(url, bucket);
          if (file) wanted.set(urlKey(url), file);
        }
        const toUpload = [...wanted.entries()].filter(([k]) => !files[k]);
        let counter = prev.counter || 0;
        await mapLimit(toUpload, UPLOAD_CONCURRENCY, async ([key, file]) => {
          try {
            const [bytes] = await file.download();
            const [meta] = await file.getMetadata();
            const contentType = meta.contentType || "image/jpeg";
            const ext = contentType.includes("png") ? "png" : "jpg";
            const n = ++counter;
            const fileName = `${name} ${String(n).padStart(2, "0")}.${ext}`;
            files[key] = await drive.upload(fileName, folderId, contentType, bytes);
          } catch (e) {
            // Missing/deleted storage object: skip it, retry on next export.
            functions.logger.warn(`Skipping photo in ${reportKey}/${name}`, e);
          }
        });

        // Trash photos that were removed from the record.
        for (const key of Object.keys(files)) {
          if (wanted.has(key)) continue;
          try {
            await drive.trash(files[key]);
          } catch (e) {
            functions.logger.warn(`Could not trash ${files[key]}`, e);
          }
          delete files[key];
        }

        nextSections[name] = {folderId, folderName, files, counter};
        links[name] = folderUrl(folderId);
      }

      // Sections no longer exported keep their folders; just carry them over.
      for (const [name, s] of Object.entries(saved)) {
        if (!nextSections[name] && reportId === state.folderId) {
          nextSections[name] = s;
        }
      }

      await stateRef.set({
        folderId: reportId,
        title,
        shared,
        sections: nextSections,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedBy: context.auth.uid,
      });

      return {reportUrl: folderUrl(reportId), sections: links};
    });
