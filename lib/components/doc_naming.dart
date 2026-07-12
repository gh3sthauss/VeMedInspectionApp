/// Falls back to a readable placeholder like "Angiography Report #A1B2C3"
/// instead of the generic "Unnamed Document" when a record has no
/// user-entered SysGenDocName. Uses a slice of the Firestore document id
/// (stable, always present) since records don't carry a created-at field.
String smartDocName(String? sysGenDocName, String modalityLabel, String docId) {
  final trimmed = sysGenDocName?.trim() ?? '';
  if (trimmed.isNotEmpty) return trimmed;
  final suffix = docId.length >= 6 ? docId.substring(0, 6) : docId;
  return '$modalityLabel Report #${suffix.toUpperCase()}';
}
