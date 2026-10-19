// Sharing a report with other users by email so they can work on it too.
//
// A report belongs to the user who created it (userID). Sharing adds lower
// case emails to its `sharedWith` array; anyone signed in with one of those
// emails sees the report in their lists and can edit it (photos included).
// Only the owner can share, unshare or delete; a collaborator can leave.
// Enforced by firebase/firestore.rules.
//
// Writes are not awaited: Firestore applies them locally at once and syncs
// when there's signal (an awaited write would hang offline).

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/auth/firebase_auth/auth_util.dart';

String get myShareEmail => currentUserEmail.trim().toLowerCase();

/// Reports the current user owns or that are shared with them.
Query<T> mineOrShared<T>(Query<T> query) {
  final email = myShareEmail;
  if (email.isEmpty) return query.where('userID', isEqualTo: currentUserUid);
  return query.where(Filter.or(
    Filter('userID', isEqualTo: currentUserUid),
    Filter('sharedWith', arrayContains: email),
  ));
}

List<String> sharedWithOf(Map<String, dynamic> data) {
  final v = data['sharedWith'];
  return v is List ? v.whereType<String>().toList() : const [];
}

bool isReportOwner(Map<String, dynamic> data) =>
    data['userID'] == currentUserUid;

/// Owner's email for "Shared by ..." (stored when the owner first shares).
String reportOwnerEmail(Map<String, dynamic> data) {
  final v = data['ownerEmail'];
  return v is String ? v : '';
}

final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

/// Returns an error message, or null when [email] can be added.
String? shareEmailProblem(String email, Map<String, dynamic> data) {
  final e = email.trim().toLowerCase();
  if (e.isEmpty) return 'Enter an email address.';
  if (!_emailPattern.hasMatch(e)) return "That doesn't look like an email.";
  if (e == myShareEmail) return "That's you - you already have access.";
  if (sharedWithOf(data).contains(e)) return 'Already shared with $e.';
  return null;
}

void shareReport(DocumentReference ref, String email) {
  unawaited(ref.update({
    'sharedWith': FieldValue.arrayUnion([email.trim().toLowerCase()]),
    'ownerEmail': myShareEmail,
  }));
}

void unshareReport(DocumentReference ref, String email) {
  unawaited(ref.update({
    'sharedWith': FieldValue.arrayRemove([email]),
  }));
}

/// A collaborator removing the report from their own list.
void leaveReport(DocumentReference ref) {
  unawaited(ref.update({
    'sharedWith': FieldValue.arrayRemove([myShareEmail]),
  }));
}
