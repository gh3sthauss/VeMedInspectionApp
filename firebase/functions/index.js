const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.onUserDeleted = functions.auth.user().onDelete(async (user) => {
  let firestore = admin.firestore();
  let userRef = firestore.doc("Users/" + user.uid);
});

const driveSync = require("./drive_sync");
exports.drivePhotoSync = driveSync.drivePhotoSync;
exports.drivePhotoUpload = driveSync.drivePhotoUpload;
exports.driveVideo = driveSync.driveVideo;
