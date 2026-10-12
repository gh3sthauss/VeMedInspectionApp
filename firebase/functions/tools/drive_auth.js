// One-time setup: authorise the syncReportPhotos Cloud Function to put report
// photos into a Google Drive account, and store the credentials as Firebase
// secrets (GDRIVE_CLIENT_ID / GDRIVE_CLIENT_SECRET / GDRIVE_REFRESH_TOKEN).
//
// Run from firebase/functions:   node tools/drive_auth.js
//
// You'll be asked for the OAuth "Desktop app" client ID + secret from Google
// Cloud Console, then a browser opens to sign in with the Google account whose
// Drive should hold the photos. Nothing is printed or written to disk.

const http = require("http");
const readline = require("readline");
const {execSync, spawnSync} = require("child_process");

const PROJECT = "ve-med-on7ngs";
const SCOPE = "https://www.googleapis.com/auth/drive.file";

function ask(question, {hidden = false} = {}) {
  const rl = readline.createInterface({input: process.stdin, output: process.stdout});
  if (hidden) {
    // Don't echo what's typed/pasted (the client secret).
    rl._writeToOutput = (s) => {
      if (s.startsWith(question)) rl.output.write(question);
    };
  }
  return new Promise((resolve) => rl.question(question, (a) => {
    rl.close();
    if (hidden) process.stdout.write("\n");
    resolve(a.trim());
  }));
}

function checkFirebaseLogin() {
  const r = spawnSync("firebase", ["projects:list", "--json"],
      {stdio: ["ignore", "pipe", "pipe"], shell: true});
  const out = String(r.stdout || "");
  if (r.status !== 0 || !out.includes(PROJECT)) {
    throw new Error(
        "The Firebase CLI isn't logged in to an account with access to " +
        PROJECT + ".\nRun  firebase login  first, then run this script again.");
  }
}

function waitForCode(server) {
  return new Promise((resolve, reject) => {
    server.on("request", (req, res) => {
      const url = new URL(req.url, "http://127.0.0.1");
      const code = url.searchParams.get("code");
      const error = url.searchParams.get("error");
      res.writeHead(200, {"Content-Type": "text/html"});
      res.end(code ?
        "<h2>VeMed: Google Drive connected. You can close this tab.</h2>" :
        `<h2>Authorisation failed: ${error || "no code"}</h2>`);
      if (code) resolve(code);
      else if (error) reject(new Error(error));
    });
  });
}

function setSecret(name, value) {
  const r = spawnSync(
      "firebase",
      ["functions:secrets:set", name, "--data-file=-", "-P", PROJECT],
      {input: value, stdio: ["pipe", "inherit", "inherit"], shell: true});
  if (r.status !== 0) throw new Error(`Setting secret ${name} failed.`);
}

(async () => {
  checkFirebaseLogin();
  const clientId = await ask("OAuth client ID: ");
  const clientSecret = await ask("OAuth client secret (hidden): ", {hidden: true});
  if (!clientId || !clientSecret) throw new Error("Client ID and secret are required.");

  const server = http.createServer();
  await new Promise((r) => server.listen(0, "127.0.0.1", r));
  const redirectUri = `http://127.0.0.1:${server.address().port}`;
  const authUrl = "https://accounts.google.com/o/oauth2/v2/auth?" + new URLSearchParams({
    client_id: clientId,
    redirect_uri: redirectUri,
    response_type: "code",
    scope: SCOPE,
    access_type: "offline",
    prompt: "consent",
  });

  console.log("\nOpening the browser to sign in. If it doesn't open, visit:\n" + authUrl + "\n");
  try {
    execSync(`start "" "${authUrl}"`, {shell: "cmd.exe", stdio: "ignore"});
  } catch (_) {/* URL printed above */}

  const code = await waitForCode(server);
  server.close();

  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: new URLSearchParams({
      code,
      client_id: clientId,
      client_secret: clientSecret,
      redirect_uri: redirectUri,
      grant_type: "authorization_code",
    }),
  });
  const token = await res.json();
  if (!token.refresh_token) {
    throw new Error("Google did not return a refresh token: " + JSON.stringify(token.error || token));
  }

  console.log("\nSigned in. Saving secrets to Firebase project " + PROJECT + "...");
  setSecret("GDRIVE_CLIENT_ID", clientId);
  setSecret("GDRIVE_CLIENT_SECRET", clientSecret);
  setSecret("GDRIVE_REFRESH_TOKEN", token.refresh_token);
  console.log("\nDone. Google Drive is connected.");
  process.exit(0);
})().catch((e) => {
  console.error("\n" + e.message);
  process.exit(1);
});
