import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';

Future<String?> uploadData(String path, Uint8List data) async {
  final storageRef = FirebaseStorage.instance.ref().child(path);
  final metadata = SettableMetadata(contentType: mime(path));
  try {
    final result = await storageRef.putData(data, metadata);
    return result.state == TaskState.success
        ? result.ref.getDownloadURL()
        : null;
  } catch (e) {
    return null;
  }
}

/// Deletes a Storage object given its public download URL. Returns true on
/// success (including "already gone"), false if the delete could not be made
/// (e.g. offline) so the caller can retry later. Requires connectivity.
Future<bool> deleteDataByUrl(String downloadUrl) async {
  try {
    await FirebaseStorage.instance.refFromURL(downloadUrl).delete();
    return true;
  } on FirebaseException catch (e) {
    // Object is already gone — treat as success so we stop retrying.
    if (e.code == 'object-not-found') {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}
