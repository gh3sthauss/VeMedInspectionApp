// Photo fields for the sub-sections (cards) inside a page: IRS on Console &
// Workstations, the gantry parts, each coil / cassette / probe, ... Each has
// its own Firestore array of photo URLs, read from the raw document data
// (record.snapshotData) so they need no generated schema fields.

class SubsectionPhotoField {
  const SubsectionPhotoField(this.label, this.key);

  /// Shown in the PDF and used as the Drive folder name.
  final String label;

  /// Firestore array field holding the photo URLs.
  final String key;
}

List<String> subsectionPhotos(Map<String, dynamic> data, String key) {
  final v = data[key];
  return v is List ? v.whereType<String>().toList() : const [];
}

List<SubsectionPhotoField> _numbered(String label, String key, int count) => [
      for (var n = 1; n <= count; n++)
        SubsectionPhotoField('$label $n', '$key${n}PicURL'),
    ];

/// CT / Angiography Console & Workstations: the IRS card.
const kIrsPhotos = [SubsectionPhotoField('Console - IRS', 'CnWIRSPicURL')];

/// CT Gantry: Model / Tube / Detector cards.
const kCtGantryPhotos = [
  SubsectionPhotoField('Gantry - Model', 'GantryModelPicURL'),
  SubsectionPhotoField('Gantry - Tube', 'GantryTubePicURL'),
  SubsectionPhotoField('Gantry - Detector', 'GantryDetectorPicURL'),
];

/// MRI Cooling System: Compressor / Cold Head cards.
const kMriCoolingPhotos = [
  SubsectionPhotoField('Cooler - Compressor', 'CSCompressorPicURL'),
  SubsectionPhotoField('Cooler - Cold Head', 'CSColdHeadPicURL'),
];

/// MRI Imager: Imager / DV Star / PCIe - RX1 / PCIe - RX2 cards.
const kMriImagerPhotos = [
  SubsectionPhotoField('Imager - Imager', 'ImagerImagerPicURL'),
  SubsectionPhotoField('Imager - DV Star', 'ImagerDVStarPicURL'),
  SubsectionPhotoField('Imager - PCIe RX1', 'ImagerPCIeRX1PicURL'),
  SubsectionPhotoField('Imager - PCIe RX2', 'ImagerPCIeRX2PicURL'),
];

/// MRI Coils 1-8.
final kMriCoilPhotos = _numbered('Coil', 'Coil', 8);

/// CR / DR / PACS Cassettes 1-8.
final kCassettePhotos = _numbered('Cassette', 'Cassette', 8);

/// Ultrasound Probes 1-5.
final kProbePhotos = _numbered('Probe', 'Probe', 5);
