import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBHFhI3lYLOYR-RBlEpZ6kxzidACUjEEuA",
            authDomain: "ve-med-on7ngs.firebaseapp.com",
            projectId: "ve-med-on7ngs",
            storageBucket: "ve-med-on7ngs.appspot.com",
            messagingSenderId: "84892380374",
            appId: "1:84892380374:web:3899508271f4733301ed77"));
  } else {
    await Firebase.initializeApp();
  }

  try {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  } catch (_) {
    // Can throw failed-precondition on web with multiple tabs open;
    // persistence is best-effort and shouldn't block app boot.
  }
}
