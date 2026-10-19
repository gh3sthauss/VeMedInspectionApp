// Copies a report's photos from Firebase Storage into a shared Google Drive
// folder tree and returns view links for the PDF:
//
//   VeMed Reports/
//     CT - Siemens Somatom - SN 12345/      <- "All photos" link
//       01 Gantry/                          <- per-section links
//       02 Cooling System/
//       ...
//
// Two steps, so a PDF export never waits for the photo copy:
//  1. drivePhotoSync (HTTPS, called on export) makes sure the folders exist,
//     shares the report folder, returns the links and records what belongs
//     in each folder as a job (driveSyncJobs/{reportKey}). Takes seconds.
//  2. drivePhotoUpload (Firestore trigger on that job) copies the photos in
//     the background. It is incremental: the Drive id of every uploaded photo
//     is kept (driveSyncFiles/{reportKey}), so only photos added since the
//     last export upload, and photos removed from the record are trashed. A
//     lease keeps two runs for the same report from uploading twice.
//
// Folder ids live in driveSync/{reportKey}.
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
const UPLOAD_CONCURRENCY = 6;
const LEASE_MS = 10 * 60 * 1000;

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
// drivePhotoSync (POST, header X-Firebase-Auth: <Firebase ID token>)
// body: {data: {
//   reportKey: "CT_<docId>",
//   title: "CT Report #ABC123 - Siemens Somatom - SN 123",
//   sections: [{name: "Gantry", urls: ["https://firebasestorage..."]}, ...]
// }}
// returns: {result: {reportUrl, sections: {"Gantry": url, ...}}}
// ---------------------------------------------------------------------------

class HttpError extends Error {
  constructor(status, message) {
    super(message);
    this.status = status;
  }
}

const REPORT_COLLECTIONS = ["CT", "MRI", "Ultrasound", "CArm", "Fluoroscopy",
  "Mammography", "XRay", "PACS", "DR", "CR", "Angiography"];

// Same access rule as firestore.rules: the report's owner, or someone it is
// shared with (sharedWith holds lower-case emails).
async function assertCanAccess(reportKey, user) {
  const [collection, docId] = reportKey.split("_");
  if (!REPORT_COLLECTIONS.includes(collection)) {
    throw new HttpError(400, "Bad reportKey.");
  }
  const snap = await admin.firestore().doc(`${collection}/${docId}`).get();
  const report = snap.data() || {};
  const email = String(user.email || "").toLowerCase();
  const shared = Array.isArray(report.sharedWith) ? report.sharedWith : [];
  if (report.userID !== user.uid && !(email && shared.includes(email))) {
    throw new HttpError(403, "No access to this report.");
  }
}

async function prepareReport(data, user) {
  const uid = user.uid;
  const reportKey = cleanName(data && data.reportKey, 200);
  if (!/^[A-Za-z]+_[A-Za-z0-9]+$/.test(reportKey)) {
    throw new HttpError(400, "Bad reportKey.");
  }
  await assertCanAccess(reportKey, user);
  const title = cleanName(data.title) || reportKey;
  const sections = (Array.isArray(data.sections) ? data.sections : [])
      .slice(0, 40)
      .map((s) => ({
        name: cleanName(s && s.name, 80),
        urls: (Array.isArray(s && s.urls) ? s.urls : [])
            .slice(0, 500)
            .map(String),
      }))
      .filter((s) => s.name);

  const db = admin.firestore();
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
  // Folders saved by the earlier one-step version live under `sections`.
  const savedFolders = state.folders || state.sections || {};

  // Report folder (renamed if the brand/model/SN changed since last time).
  let reportId = await drive.alive(state.folderId);
  const sameReport = !!reportId && reportId === state.folderId;
  let shared = !!state.shared && sameReport;
  if (!reportId) {
    reportId = await drive.createFolder(title, rootId);
  } else if (state.title !== title) {
    await drive.rename(reportId, title);
  }
  if (!shared) {
    await drive.shareWithLink(reportId);
    shared = true;
  }

  // Section folders, in parallel. One left over from a deleted report folder
  // is gone too, so it's only reused while the report folder is the same.
  const entries = await Promise.all(sections.map(async ({name}, i) => {
    const folderName = `${String(i + 1).padStart(2, "0")} ${name}`;
    const prev = savedFolders[name] || {};
    let folderId = sameReport ? await drive.alive(prev.folderId) : null;
    if (!folderId) {
      folderId = await drive.createFolder(folderName, reportId);
    } else if (prev.folderName !== folderName) {
      await drive.rename(folderId, folderName);
    }
    return [name, {folderId, folderName}];
  }));
  const folders = {
    ...(sameReport ? savedFolders : {}),
    ...Object.fromEntries(entries),
  };

  await stateRef.set({
    folderId: reportId,
    title,
    shared,
    folders,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedBy: uid,
  }, {merge: true});

  // Hand the photo copy to drivePhotoUpload.
  await db.doc(`driveSyncJobs/${reportKey}`).set({
    sections,
    requestedAt: admin.firestore.FieldValue.serverTimestamp(),
    requestedBy: uid,
  });

  return {
    reportUrl: folderUrl(reportId),
    sections: Object.fromEntries(
        entries.map(([name, f]) => [name, folderUrl(f.folderId)])),
  };
}

// Plain HTTPS endpoint rather than onCall: Google's front end rejects a
// Firebase ID token in the Authorization header, so the app sends it in
// X-Firebase-Auth and we verify it here. Request/response bodies use the
// callable shape ({data} in, {result} out).
exports.drivePhotoSync = functions
    .runWith({secrets: SECRETS, timeoutSeconds: 120, memory: "512MB"})
    .https.onRequest(async (req, res) => {
      if (req.method !== "POST") {
        res.status(405).json({error: "POST only."});
        return;
      }
      try {
        const idToken = String(req.get("X-Firebase-Auth") || "");
        let user;
        try {
          user = await admin.auth().verifyIdToken(idToken);
        } catch (_) {
          throw new HttpError(401, "Sign in first.");
        }
        const result =
            await prepareReport((req.body && req.body.data) || {}, user);
        res.json({result});
      } catch (e) {
        if (!(e instanceof HttpError)) functions.logger.error("drivePhotoSync", e);
        res.status(e.status || 500).json({error: e.status ? e.message : "Sync failed."});
      }
    });

// ---------------------------------------------------------------------------
// drivePhotoUpload: copies a report's photos into its folders in the
// background whenever drivePhotoSync records a new job.
// ---------------------------------------------------------------------------

// Takes the report's upload lease. When another run holds it, flags the
// report dirty instead so that run goes round once more with the new job.
async function acquireLease(filesRef) {
  return admin.firestore().runTransaction(async (tx) => {
    const data = (await tx.get(filesRef)).data() || {};
    if (data.leaseUntil && data.leaseUntil > Date.now()) {
      tx.set(filesRef, {dirty: true}, {merge: true});
      return false;
    }
    tx.set(filesRef, {leaseUntil: Date.now() + LEASE_MS, dirty: false},
        {merge: true});
    return true;
  });
}

// Releases the lease, unless a newer job arrived meanwhile (then keeps it
// and returns true so the caller runs again).
async function finishOrContinue(filesRef) {
  return admin.firestore().runTransaction(async (tx) => {
    const data = (await tx.get(filesRef)).data() || {};
    if (data.dirty) {
      tx.set(filesRef,
          {dirty: false, leaseUntil: Date.now() + LEASE_MS}, {merge: true});
      return true;
    }
    tx.set(filesRef, {leaseUntil: 0}, {merge: true});
    return false;
  });
}

async function uploadReportPhotos(reportKey) {
  const db = admin.firestore();
  const bucket = admin.storage().bucket();
  const job = (await db.doc(`driveSyncJobs/${reportKey}`).get()).data() || {};
  const state = (await db.doc(`driveSync/${reportKey}`).get()).data() || {};
  const filesRef = db.doc(`driveSyncFiles/${reportKey}`);
  const filesDoc = (await filesRef.get()).data() || {};
  const folders = state.folders || {};
  // Photos uploaded by the earlier one-step version are listed in
  // driveSync/{reportKey}.sections.
  const legacy = state.sections || {};
  const done = {...(filesDoc.sections || {})};

  const work = [];
  for (const {name, urls} of job.sections || []) {
    const folder = folders[name];
    if (!folder) continue;
    let entry = done[name] || legacy[name];
    // Folder recreated (e.g. deleted in Drive): start that section afresh.
    if (!entry || entry.folderId !== folder.folderId) {
      entry = {folderId: folder.folderId, files: {}, counter: 0};
    }
    entry = {...entry, files: {...(entry.files || {})}};
    done[name] = entry;

    const wanted = new Map();
    for (const url of urls || []) {
      const file = storageFileFor(url, bucket);
      if (file) wanted.set(urlKey(url), file);
    }
    for (const [key, file] of wanted) {
      if (!entry.files[key]) work.push({name, entry, key, file});
    }
    for (const key of Object.keys(entry.files)) {
      if (!wanted.has(key)) work.push({name, entry, key, trash: true});
    }
  }

  const save = () => filesRef.set({sections: done}, {mergeFields: ["sections"]});
  if (!work.length) {
    await save();
    return;
  }

  const drive = driveClient(await getAccessToken());
  let sinceSave = 0;
  await mapLimit(work, UPLOAD_CONCURRENCY, async (w) => {
    try {
      if (w.trash) {
        await drive.trash(w.entry.files[w.key]);
        delete w.entry.files[w.key];
        return;
      }
      const [bytes] = await w.file.download();
      const [meta] = await w.file.getMetadata();
      const contentType = meta.contentType || "image/jpeg";
      const ext = contentType.includes("png") ? "png" : "jpg";
      const n = ++w.entry.counter;
      const fileName = `${w.name} ${String(n).padStart(2, "0")}.${ext}`;
      w.entry.files[w.key] =
          await drive.upload(fileName, w.entry.folderId, contentType, bytes);
      // Save progress now and then, so a crash doesn't re-upload everything.
      if (++sinceSave >= 10) {
        sinceSave = 0;
        await save();
      }
    } catch (e) {
      // Missing storage object / Drive hiccup: skipped, retried next export.
      functions.logger.warn(`Photo sync step failed in ${reportKey}/${w.name}`, e);
    }
  });
  await save();
}

exports.drivePhotoUpload = functions
    .runWith({secrets: SECRETS, timeoutSeconds: 540, memory: "1GB"})
    .firestore.document("driveSyncJobs/{reportKey}")
    .onWrite(async (change, context) => {
      if (!change.after.exists) return;
      const reportKey = context.params.reportKey;
      const filesRef = admin.firestore().doc(`driveSyncFiles/${reportKey}`);
      if (!(await acquireLease(filesRef))) return;
      try {
        do {
          await uploadReportPhotos(reportKey);
        } while (await finishOrContinue(filesRef));
      } catch (e) {
        functions.logger.error(`drivePhotoUpload ${reportKey}`, e);
        await filesRef.set({leaseUntil: 0}, {merge: true});
      }
    });
