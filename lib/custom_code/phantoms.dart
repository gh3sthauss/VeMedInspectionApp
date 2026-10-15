// Phantom slots on the Accessories page (Angiography, MRI, CT).
//
// Each report holds up to [kMaxPhantoms] phantoms, each with a few text fields
// and its own photo list. Slots 1-3 predate this file and keep their original
// Firestore field names; slots 4-10 and every slot's photo list follow the same
// naming per modality. The values are read from / written to the raw document
// data (record.snapshotData / DocumentReference.update) so the slots don't
// need dozens of generated schema fields.

const int kMaxPhantoms = 10;

class PhantomField {
  const PhantomField(this.label, this.pdfLabel, this.key);

  /// Label in the app ("Model Number") and the PDF ("Model No.").
  final String label;
  final String pdfLabel;

  /// Firestore field name for phantom [slot] (1-based).
  final String Function(int slot) key;
}

class PhantomSchema {
  const PhantomSchema(this.fields, this.photoKey);

  final List<PhantomField> fields;

  /// Firestore array field holding phantom [slot]'s photo URLs.
  final String Function(int slot) photoKey;

  /// Angiography and MRI: AccPhantom{N}Model / ModelNo / ModelSN.
  static final PhantomSchema accPhantom = PhantomSchema(
    [
      PhantomField('Model', 'Model', (n) => 'AccPhantom${n}Model'),
      PhantomField('Model Number', 'Model No.', (n) => 'AccPhantom${n}ModelNo'),
      PhantomField('Serial Number', 'Serial No.', (n) => 'AccPhantom${n}ModelSN'),
    ],
    (n) => 'AccPhantom${n}PicURL',
  );

  /// CT: phantom 1 is AccessoriesPModal / PModelNo / PSN / PHolders, later
  /// ones AccessoriesP{N}Modal etc.
  static final PhantomSchema ct = PhantomSchema(
    [
      PhantomField('Model', 'Model', (n) => 'AccessoriesP${_ct(n)}Modal'),
      PhantomField(
          'Model Number', 'Model No.', (n) => 'AccessoriesP${_ct(n)}ModelNo'),
      PhantomField('Serial Number', 'Serial No.', (n) => 'AccessoriesP${_ct(n)}SN'),
      PhantomField('Holders', 'Holders', (n) => 'AccessoriesP${_ct(n)}Holders'),
    ],
    (n) => 'AccessoriesP${n}PicURL',
  );

  static String _ct(int n) => n == 1 ? '' : '$n';

  String text(Map<String, dynamic> data, int slot, PhantomField field) {
    final v = data[field.key(slot)];
    return v is String ? v : '';
  }

  List<String> photos(Map<String, dynamic> data, int slot) {
    final v = data[photoKey(slot)];
    return v is List ? v.whereType<String>().toList() : const [];
  }

  bool slotHasText(Map<String, dynamic> data, int slot) =>
      fields.any((f) => text(data, slot, f).trim().isNotEmpty);

  bool slotHasData(Map<String, dynamic> data, int slot) =>
      slotHasText(data, slot) || photos(data, slot).isNotEmpty;

  /// Highest slot holding any text or photos, or 0 when none do.
  int lastUsedSlot(Map<String, dynamic> data) {
    for (var n = kMaxPhantoms; n >= 1; n--) {
      if (slotHasData(data, n)) return n;
    }
    return 0;
  }
}
