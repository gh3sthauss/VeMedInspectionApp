import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UltrasoundRecord extends FirestoreRecord {
  UltrasoundRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "SysGenBrand" field.
  String? _sysGenBrand;
  String get sysGenBrand => _sysGenBrand ?? '';
  bool hasSysGenBrand() => _sysGenBrand != null;

  // "SysGenModal" field.
  String? _sysGenModal;
  String get sysGenModal => _sysGenModal ?? '';
  bool hasSysGenModal() => _sysGenModal != null;

  // "SysGenYOM" field.
  String? _sysGenYOM;
  String get sysGenYOM => _sysGenYOM ?? '';
  bool hasSysGenYOM() => _sysGenYOM != null;

  // "SysGenSN" field.
  String? _sysGenSN;
  String get sysGenSN => _sysGenSN ?? '';
  bool hasSysGenSN() => _sysGenSN != null;

  // "CosmeticText" field.
  String? _cosmeticText;
  String get cosmeticText => _cosmeticText ?? '';
  bool hasCosmeticText() => _cosmeticText != null;

  // "AccessoriesCDs" field.
  String? _accessoriesCDs;
  String get accessoriesCDs => _accessoriesCDs ?? '';
  bool hasAccessoriesCDs() => _accessoriesCDs != null;

  // "AccessoriesSpareP" field.
  String? _accessoriesSpareP;
  String get accessoriesSpareP => _accessoriesSpareP ?? '';
  bool hasAccessoriesSpareP() => _accessoriesSpareP != null;

  // "DnTAddress" field.
  String? _dnTAddress;
  String get dnTAddress => _dnTAddress ?? '';
  bool hasDnTAddress() => _dnTAddress != null;

  // "DnTFloor" field.
  String? _dnTFloor;
  String get dnTFloor => _dnTFloor ?? '';
  bool hasDnTFloor() => _dnTFloor != null;

  // "DnTDoorS" field.
  String? _dnTDoorS;
  String get dnTDoorS => _dnTDoorS ?? '';
  bool hasDnTDoorS() => _dnTDoorS != null;

  // "DnTDockAvailable" field.
  String? _dnTDockAvailable;
  String get dnTDockAvailable => _dnTDockAvailable ?? '';
  bool hasDnTDockAvailable() => _dnTDockAvailable != null;

  // "DnTNeedOfCrane" field.
  String? _dnTNeedOfCrane;
  String get dnTNeedOfCrane => _dnTNeedOfCrane ?? '';
  bool hasDnTNeedOfCrane() => _dnTNeedOfCrane != null;

  // "DnTTools" field.
  String? _dnTTools;
  String get dnTTools => _dnTTools ?? '';
  bool hasDnTTools() => _dnTTools != null;

  // "DnTSpecialAttention" field.
  String? _dnTSpecialAttention;
  String get dnTSpecialAttention => _dnTSpecialAttention ?? '';
  bool hasDnTSpecialAttention() => _dnTSpecialAttention != null;

  // "OtherNotes" field.
  String? _otherNotes;
  String get otherNotes => _otherNotes ?? '';
  bool hasOtherNotes() => _otherNotes != null;

  // "SysGenDocName" field.
  String? _sysGenDocName;
  String get sysGenDocName => _sysGenDocName ?? '';
  bool hasSysGenDocName() => _sysGenDocName != null;

  // "userID" field.
  String? _userID;
  String get userID => _userID ?? '';
  bool hasUserID() => _userID != null;

  // "OtherNotesPhotosURL" field.
  List<String>? _otherNotesPhotosURL;
  List<String> get otherNotesPhotosURL => _otherNotesPhotosURL ?? const [];
  bool hasOtherNotesPhotosURL() => _otherNotesPhotosURL != null;

  // "SoftwareSN" field.
  String? _softwareSN;
  String get softwareSN => _softwareSN ?? '';
  bool hasSoftwareSN() => _softwareSN != null;

  // "SoftwareVersion" field.
  String? _softwareVersion;
  String get softwareVersion => _softwareVersion ?? '';
  bool hasSoftwareVersion() => _softwareVersion != null;

  // "SoftwareOptionsText" field.
  String? _softwareOptionsText;
  String get softwareOptionsText => _softwareOptionsText ?? '';
  bool hasSoftwareOptionsText() => _softwareOptionsText != null;

  // "SoftwareOptPicsURL" field.
  List<String>? _softwareOptPicsURL;
  List<String> get softwareOptPicsURL => _softwareOptPicsURL ?? const [];
  bool hasSoftwareOptPicsURL() => _softwareOptPicsURL != null;

  // "Probe1Model" field.
  String? _probe1Model;
  String get probe1Model => _probe1Model ?? '';
  bool hasProbe1Model() => _probe1Model != null;

  // "Probe2Model" field.
  String? _probe2Model;
  String get probe2Model => _probe2Model ?? '';
  bool hasProbe2Model() => _probe2Model != null;

  // "Probe3Model" field.
  String? _probe3Model;
  String get probe3Model => _probe3Model ?? '';
  bool hasProbe3Model() => _probe3Model != null;

  // "Probe4Model" field.
  String? _probe4Model;
  String get probe4Model => _probe4Model ?? '';
  bool hasProbe4Model() => _probe4Model != null;

  // "Probe5Model" field.
  String? _probe5Model;
  String get probe5Model => _probe5Model ?? '';
  bool hasProbe5Model() => _probe5Model != null;

  // "Probe1YOM" field.
  String? _probe1YOM;
  String get probe1YOM => _probe1YOM ?? '';
  bool hasProbe1YOM() => _probe1YOM != null;

  // "Probe2YOM" field.
  String? _probe2YOM;
  String get probe2YOM => _probe2YOM ?? '';
  bool hasProbe2YOM() => _probe2YOM != null;

  // "Probe3YOM" field.
  String? _probe3YOM;
  String get probe3YOM => _probe3YOM ?? '';
  bool hasProbe3YOM() => _probe3YOM != null;

  // "Probe4YOM" field.
  String? _probe4YOM;
  String get probe4YOM => _probe4YOM ?? '';
  bool hasProbe4YOM() => _probe4YOM != null;

  // "Probe5YOM" field.
  String? _probe5YOM;
  String get probe5YOM => _probe5YOM ?? '';
  bool hasProbe5YOM() => _probe5YOM != null;

  // "Probe1Condition" field.
  String? _probe1Condition;
  String get probe1Condition => _probe1Condition ?? '';
  bool hasProbe1Condition() => _probe1Condition != null;

  // "Probe2Condition" field.
  String? _probe2Condition;
  String get probe2Condition => _probe2Condition ?? '';
  bool hasProbe2Condition() => _probe2Condition != null;

  // "Probe3Condition" field.
  String? _probe3Condition;
  String get probe3Condition => _probe3Condition ?? '';
  bool hasProbe3Condition() => _probe3Condition != null;

  // "Probe4Condition" field.
  String? _probe4Condition;
  String get probe4Condition => _probe4Condition ?? '';
  bool hasProbe4Condition() => _probe4Condition != null;

  // "Probe5Condition" field.
  String? _probe5Condition;
  String get probe5Condition => _probe5Condition ?? '';
  bool hasProbe5Condition() => _probe5Condition != null;

  // "CosmeticPicURL" field.
  List<String>? _cosmeticPicURL;
  List<String> get cosmeticPicURL => _cosmeticPicURL ?? const [];
  bool hasCosmeticPicURL() => _cosmeticPicURL != null;

  // "PhotosURL" field.
  String? _photosURL;
  String get photosURL => _photosURL ?? '';
  bool hasPhotosURL() => _photosURL != null;

  // "DeviceImg" field.
  List<String>? _deviceImg;
  List<String> get deviceImg => _deviceImg ?? const [];
  bool hasDeviceImg() => _deviceImg != null;

  // "AccessoriesPicURL" field.
  List<String>? _accessoriesPicURL;
  List<String> get accessoriesPicURL => _accessoriesPicURL ?? const [];
  bool hasAccessoriesPicURL() => _accessoriesPicURL != null;

  // "DnTPicURL" field.
  List<String>? _dnTPicURL;
  List<String> get dnTPicURL => _dnTPicURL ?? const [];
  bool hasDnTPicURL() => _dnTPicURL != null;

  void _initializeFields() {
    _sysGenBrand = snapshotData['SysGenBrand'] as String?;
    _sysGenModal = snapshotData['SysGenModal'] as String?;
    _sysGenYOM = snapshotData['SysGenYOM'] as String?;
    _sysGenSN = snapshotData['SysGenSN'] as String?;
    _cosmeticText = snapshotData['CosmeticText'] as String?;
    _accessoriesCDs = snapshotData['AccessoriesCDs'] as String?;
    _accessoriesSpareP = snapshotData['AccessoriesSpareP'] as String?;
    _dnTAddress = snapshotData['DnTAddress'] as String?;
    _dnTFloor = snapshotData['DnTFloor'] as String?;
    _dnTDoorS = snapshotData['DnTDoorS'] as String?;
    _dnTDockAvailable = snapshotData['DnTDockAvailable'] as String?;
    _dnTNeedOfCrane = snapshotData['DnTNeedOfCrane'] as String?;
    _dnTTools = snapshotData['DnTTools'] as String?;
    _dnTSpecialAttention = snapshotData['DnTSpecialAttention'] as String?;
    _otherNotes = snapshotData['OtherNotes'] as String?;
    _sysGenDocName = snapshotData['SysGenDocName'] as String?;
    _userID = snapshotData['userID'] as String?;
    _otherNotesPhotosURL = getDataList(snapshotData['OtherNotesPhotosURL']);
    _softwareSN = snapshotData['SoftwareSN'] as String?;
    _softwareVersion = snapshotData['SoftwareVersion'] as String?;
    _softwareOptionsText = snapshotData['SoftwareOptionsText'] as String?;
    _softwareOptPicsURL = getDataList(snapshotData['SoftwareOptPicsURL']);
    _probe1Model = snapshotData['Probe1Model'] as String?;
    _probe2Model = snapshotData['Probe2Model'] as String?;
    _probe3Model = snapshotData['Probe3Model'] as String?;
    _probe4Model = snapshotData['Probe4Model'] as String?;
    _probe5Model = snapshotData['Probe5Model'] as String?;
    _probe1YOM = snapshotData['Probe1YOM'] as String?;
    _probe2YOM = snapshotData['Probe2YOM'] as String?;
    _probe3YOM = snapshotData['Probe3YOM'] as String?;
    _probe4YOM = snapshotData['Probe4YOM'] as String?;
    _probe5YOM = snapshotData['Probe5YOM'] as String?;
    _probe1Condition = snapshotData['Probe1Condition'] as String?;
    _probe2Condition = snapshotData['Probe2Condition'] as String?;
    _probe3Condition = snapshotData['Probe3Condition'] as String?;
    _probe4Condition = snapshotData['Probe4Condition'] as String?;
    _probe5Condition = snapshotData['Probe5Condition'] as String?;
    _cosmeticPicURL = getDataList(snapshotData['CosmeticPicURL']);
    _photosURL = snapshotData['PhotosURL'] as String?;
    _deviceImg = getDataList(snapshotData['DeviceImg']);
    _accessoriesPicURL = getDataList(snapshotData['AccessoriesPicURL']);
    _dnTPicURL = getDataList(snapshotData['DnTPicURL']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Ultrasound');

  static Stream<UltrasoundRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UltrasoundRecord.fromSnapshot(s));

  static Future<UltrasoundRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UltrasoundRecord.fromSnapshot(s));

  static UltrasoundRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UltrasoundRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UltrasoundRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UltrasoundRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UltrasoundRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UltrasoundRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUltrasoundRecordData({
  String? sysGenBrand,
  String? sysGenModal,
  String? sysGenYOM,
  String? sysGenSN,
  String? cosmeticText,
  String? accessoriesCDs,
  String? accessoriesSpareP,
  String? dnTAddress,
  String? dnTFloor,
  String? dnTDoorS,
  String? dnTDockAvailable,
  String? dnTNeedOfCrane,
  String? dnTTools,
  String? dnTSpecialAttention,
  String? otherNotes,
  String? sysGenDocName,
  String? userID,
  String? softwareSN,
  String? softwareVersion,
  String? softwareOptionsText,
  String? probe1Model,
  String? probe2Model,
  String? probe3Model,
  String? probe4Model,
  String? probe5Model,
  String? probe1YOM,
  String? probe2YOM,
  String? probe3YOM,
  String? probe4YOM,
  String? probe5YOM,
  String? probe1Condition,
  String? probe2Condition,
  String? probe3Condition,
  String? probe4Condition,
  String? probe5Condition,
  String? photosURL,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'SysGenBrand': sysGenBrand,
      'SysGenModal': sysGenModal,
      'SysGenYOM': sysGenYOM,
      'SysGenSN': sysGenSN,
      'CosmeticText': cosmeticText,
      'AccessoriesCDs': accessoriesCDs,
      'AccessoriesSpareP': accessoriesSpareP,
      'DnTAddress': dnTAddress,
      'DnTFloor': dnTFloor,
      'DnTDoorS': dnTDoorS,
      'DnTDockAvailable': dnTDockAvailable,
      'DnTNeedOfCrane': dnTNeedOfCrane,
      'DnTTools': dnTTools,
      'DnTSpecialAttention': dnTSpecialAttention,
      'OtherNotes': otherNotes,
      'SysGenDocName': sysGenDocName,
      'userID': userID,
      'SoftwareSN': softwareSN,
      'SoftwareVersion': softwareVersion,
      'SoftwareOptionsText': softwareOptionsText,
      'Probe1Model': probe1Model,
      'Probe2Model': probe2Model,
      'Probe3Model': probe3Model,
      'Probe4Model': probe4Model,
      'Probe5Model': probe5Model,
      'Probe1YOM': probe1YOM,
      'Probe2YOM': probe2YOM,
      'Probe3YOM': probe3YOM,
      'Probe4YOM': probe4YOM,
      'Probe5YOM': probe5YOM,
      'Probe1Condition': probe1Condition,
      'Probe2Condition': probe2Condition,
      'Probe3Condition': probe3Condition,
      'Probe4Condition': probe4Condition,
      'Probe5Condition': probe5Condition,
      'PhotosURL': photosURL,
    }.withoutNulls,
  );

  return firestoreData;
}

class UltrasoundRecordDocumentEquality implements Equality<UltrasoundRecord> {
  const UltrasoundRecordDocumentEquality();

  @override
  bool equals(UltrasoundRecord? e1, UltrasoundRecord? e2) {
    const listEquality = ListEquality();
    return e1?.sysGenBrand == e2?.sysGenBrand &&
        e1?.sysGenModal == e2?.sysGenModal &&
        e1?.sysGenYOM == e2?.sysGenYOM &&
        e1?.sysGenSN == e2?.sysGenSN &&
        e1?.cosmeticText == e2?.cosmeticText &&
        e1?.accessoriesCDs == e2?.accessoriesCDs &&
        e1?.accessoriesSpareP == e2?.accessoriesSpareP &&
        e1?.dnTAddress == e2?.dnTAddress &&
        e1?.dnTFloor == e2?.dnTFloor &&
        e1?.dnTDoorS == e2?.dnTDoorS &&
        e1?.dnTDockAvailable == e2?.dnTDockAvailable &&
        e1?.dnTNeedOfCrane == e2?.dnTNeedOfCrane &&
        e1?.dnTTools == e2?.dnTTools &&
        e1?.dnTSpecialAttention == e2?.dnTSpecialAttention &&
        e1?.otherNotes == e2?.otherNotes &&
        e1?.sysGenDocName == e2?.sysGenDocName &&
        e1?.userID == e2?.userID &&
        listEquality.equals(e1?.otherNotesPhotosURL, e2?.otherNotesPhotosURL) &&
        e1?.softwareSN == e2?.softwareSN &&
        e1?.softwareVersion == e2?.softwareVersion &&
        e1?.softwareOptionsText == e2?.softwareOptionsText &&
        listEquality.equals(e1?.softwareOptPicsURL, e2?.softwareOptPicsURL) &&
        e1?.probe1Model == e2?.probe1Model &&
        e1?.probe2Model == e2?.probe2Model &&
        e1?.probe3Model == e2?.probe3Model &&
        e1?.probe4Model == e2?.probe4Model &&
        e1?.probe5Model == e2?.probe5Model &&
        e1?.probe1YOM == e2?.probe1YOM &&
        e1?.probe2YOM == e2?.probe2YOM &&
        e1?.probe3YOM == e2?.probe3YOM &&
        e1?.probe4YOM == e2?.probe4YOM &&
        e1?.probe5YOM == e2?.probe5YOM &&
        e1?.probe1Condition == e2?.probe1Condition &&
        e1?.probe2Condition == e2?.probe2Condition &&
        e1?.probe3Condition == e2?.probe3Condition &&
        e1?.probe4Condition == e2?.probe4Condition &&
        e1?.probe5Condition == e2?.probe5Condition &&
        listEquality.equals(e1?.cosmeticPicURL, e2?.cosmeticPicURL) &&
        e1?.photosURL == e2?.photosURL &&
        listEquality.equals(e1?.deviceImg, e2?.deviceImg) &&
        listEquality.equals(e1?.accessoriesPicURL, e2?.accessoriesPicURL) &&
        listEquality.equals(e1?.dnTPicURL, e2?.dnTPicURL);
  }

  @override
  int hash(UltrasoundRecord? e) => const ListEquality().hash([
        e?.sysGenBrand,
        e?.sysGenModal,
        e?.sysGenYOM,
        e?.sysGenSN,
        e?.cosmeticText,
        e?.accessoriesCDs,
        e?.accessoriesSpareP,
        e?.dnTAddress,
        e?.dnTFloor,
        e?.dnTDoorS,
        e?.dnTDockAvailable,
        e?.dnTNeedOfCrane,
        e?.dnTTools,
        e?.dnTSpecialAttention,
        e?.otherNotes,
        e?.sysGenDocName,
        e?.userID,
        e?.otherNotesPhotosURL,
        e?.softwareSN,
        e?.softwareVersion,
        e?.softwareOptionsText,
        e?.softwareOptPicsURL,
        e?.probe1Model,
        e?.probe2Model,
        e?.probe3Model,
        e?.probe4Model,
        e?.probe5Model,
        e?.probe1YOM,
        e?.probe2YOM,
        e?.probe3YOM,
        e?.probe4YOM,
        e?.probe5YOM,
        e?.probe1Condition,
        e?.probe2Condition,
        e?.probe3Condition,
        e?.probe4Condition,
        e?.probe5Condition,
        e?.cosmeticPicURL,
        e?.photosURL,
        e?.deviceImg,
        e?.accessoriesPicURL,
        e?.dnTPicURL
      ]);

  @override
  bool isValidKey(Object? o) => o is UltrasoundRecord;
}
