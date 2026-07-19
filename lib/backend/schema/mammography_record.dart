import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MammographyRecord extends FirestoreRecord {
  MammographyRecord._(
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

  // "CnWConsoleMSN" field.
  String? _cnWConsoleMSN;
  String get cnWConsoleMSN => _cnWConsoleMSN ?? '';
  bool hasCnWConsoleMSN() => _cnWConsoleMSN != null;

  // "CnWConsoleMSW" field.
  String? _cnWConsoleMSW;
  String get cnWConsoleMSW => _cnWConsoleMSW ?? '';
  bool hasCnWConsoleMSW() => _cnWConsoleMSW != null;

  // "CnWConsoleMOptions" field.
  String? _cnWConsoleMOptions;
  String get cnWConsoleMOptions => _cnWConsoleMOptions ?? '';
  bool hasCnWConsoleMOptions() => _cnWConsoleMOptions != null;

  // "CnWWorkSSN" field.
  String? _cnWWorkSSN;
  String get cnWWorkSSN => _cnWWorkSSN ?? '';
  bool hasCnWWorkSSN() => _cnWWorkSSN != null;

  // "CnWWorkSSW" field.
  String? _cnWWorkSSW;
  String get cnWWorkSSW => _cnWWorkSSW ?? '';
  bool hasCnWWorkSSW() => _cnWWorkSSW != null;

  // "CnWWorkSOptions" field.
  String? _cnWWorkSOptions;
  String get cnWWorkSOptions => _cnWWorkSOptions ?? '';
  bool hasCnWWorkSOptions() => _cnWWorkSOptions != null;

  // "CosmeticText" field.
  String? _cosmeticText;
  String get cosmeticText => _cosmeticText ?? '';
  bool hasCosmeticText() => _cosmeticText != null;

  // "AccessoriesPModal" field.
  String? _accessoriesPModal;
  String get accessoriesPModal => _accessoriesPModal ?? '';
  bool hasAccessoriesPModal() => _accessoriesPModal != null;

  // "AccessoriesPModelNo" field.
  String? _accessoriesPModelNo;
  String get accessoriesPModelNo => _accessoriesPModelNo ?? '';
  bool hasAccessoriesPModelNo() => _accessoriesPModelNo != null;

  // "AccessoriesPSN" field.
  String? _accessoriesPSN;
  String get accessoriesPSN => _accessoriesPSN ?? '';
  bool hasAccessoriesPSN() => _accessoriesPSN != null;

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

  // "CnWWorkstationOptPURL" field.
  List<String>? _cnWWorkstationOptPURL;
  List<String> get cnWWorkstationOptPURL => _cnWWorkstationOptPURL ?? const [];
  bool hasCnWWorkstationOptPURL() => _cnWWorkstationOptPURL != null;

  // "CnWCMOptPURL" field.
  List<String>? _cnWCMOptPURL;
  List<String> get cnWCMOptPURL => _cnWCMOptPURL ?? const [];
  bool hasCnWCMOptPURL() => _cnWCMOptPURL != null;

  // "CosmeticPicURL" field.
  List<String>? _cosmeticPicURL;
  List<String> get cosmeticPicURL => _cosmeticPicURL ?? const [];
  bool hasCosmeticPicURL() => _cosmeticPicURL != null;

  // "DeviceImg" field.
  List<String>? _deviceImg;
  List<String> get deviceImg => _deviceImg ?? const [];
  bool hasDeviceImg() => _deviceImg != null;

  // "DetectorModel" field.
  String? _detectorModel;
  String get detectorModel => _detectorModel ?? '';
  bool hasDetectorModel() => _detectorModel != null;

  // "DetectorSize" field.
  String? _detectorSize;
  String get detectorSize => _detectorSize ?? '';
  bool hasDetectorSize() => _detectorSize != null;

  // "DetectorYOM" field.
  String? _detectorYOM;
  String get detectorYOM => _detectorYOM ?? '';
  bool hasDetectorYOM() => _detectorYOM != null;

  // "DetectorCondition" field.
  String? _detectorCondition;
  String get detectorCondition => _detectorCondition ?? '';
  bool hasDetectorCondition() => _detectorCondition != null;

  // "Tube1Model" field.
  String? _tube1Model;
  String get tube1Model => _tube1Model ?? '';
  bool hasTube1Model() => _tube1Model != null;

  // "Tube1YOM" field.
  String? _tube1YOM;
  String get tube1YOM => _tube1YOM ?? '';
  bool hasTube1YOM() => _tube1YOM != null;

  // "AccessoriesPicURL" field.
  List<String>? _accessoriesPicURL;
  List<String> get accessoriesPicURL => _accessoriesPicURL ?? const [];
  bool hasAccessoriesPicURL() => _accessoriesPicURL != null;

  // "DetectorPicURL" field.
  List<String>? _detectorPicURL;
  List<String> get detectorPicURL => _detectorPicURL ?? const [];
  bool hasDetectorPicURL() => _detectorPicURL != null;

  // "DnTPicURL" field.
  List<String>? _dnTPicURL;
  List<String> get dnTPicURL => _dnTPicURL ?? const [];
  bool hasDnTPicURL() => _dnTPicURL != null;

  // "TubePicURL" field.
  List<String>? _tubePicURL;
  List<String> get tubePicURL => _tubePicURL ?? const [];
  bool hasTubePicURL() => _tubePicURL != null;

  void _initializeFields() {
    _sysGenBrand = snapshotData['SysGenBrand'] as String?;
    _sysGenModal = snapshotData['SysGenModal'] as String?;
    _sysGenYOM = snapshotData['SysGenYOM'] as String?;
    _sysGenSN = snapshotData['SysGenSN'] as String?;
    _cnWConsoleMSN = snapshotData['CnWConsoleMSN'] as String?;
    _cnWConsoleMSW = snapshotData['CnWConsoleMSW'] as String?;
    _cnWConsoleMOptions = snapshotData['CnWConsoleMOptions'] as String?;
    _cnWWorkSSN = snapshotData['CnWWorkSSN'] as String?;
    _cnWWorkSSW = snapshotData['CnWWorkSSW'] as String?;
    _cnWWorkSOptions = snapshotData['CnWWorkSOptions'] as String?;
    _cosmeticText = snapshotData['CosmeticText'] as String?;
    _accessoriesPModal = snapshotData['AccessoriesPModal'] as String?;
    _accessoriesPModelNo = snapshotData['AccessoriesPModelNo'] as String?;
    _accessoriesPSN = snapshotData['AccessoriesPSN'] as String?;
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
    _cnWWorkstationOptPURL = getDataList(snapshotData['CnWWorkstationOptPURL']);
    _cnWCMOptPURL = getDataList(snapshotData['CnWCMOptPURL']);
    _cosmeticPicURL = getDataList(snapshotData['CosmeticPicURL']);
    _detectorModel = snapshotData['DetectorModel'] as String?;
    _detectorSize = snapshotData['DetectorSize'] as String?;
    _detectorYOM = snapshotData['DetectorYOM'] as String?;
    _detectorCondition = snapshotData['DetectorCondition'] as String?;
    _tube1Model = snapshotData['Tube1Model'] as String?;
    _tube1YOM = snapshotData['Tube1YOM'] as String?;
    _deviceImg = getDataList(snapshotData['DeviceImg']);
    _accessoriesPicURL = getDataList(snapshotData['AccessoriesPicURL']);
    _detectorPicURL = getDataList(snapshotData['DetectorPicURL']);
    _dnTPicURL = getDataList(snapshotData['DnTPicURL']);
    _tubePicURL = getDataList(snapshotData['TubePicURL']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Mammography');

  static Stream<MammographyRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MammographyRecord.fromSnapshot(s));

  static Future<MammographyRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MammographyRecord.fromSnapshot(s));

  static MammographyRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MammographyRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MammographyRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MammographyRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MammographyRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MammographyRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMammographyRecordData({
  String? sysGenBrand,
  String? sysGenModal,
  String? sysGenYOM,
  String? sysGenSN,
  String? cnWConsoleMSN,
  String? cnWConsoleMSW,
  String? cnWConsoleMOptions,
  String? cnWWorkSSN,
  String? cnWWorkSSW,
  String? cnWWorkSOptions,
  String? cosmeticText,
  String? accessoriesPModal,
  String? accessoriesPModelNo,
  String? accessoriesPSN,
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
  String? detectorModel,
  String? detectorSize,
  String? detectorYOM,
  String? detectorCondition,
  String? tube1Model,
  String? tube1YOM,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'SysGenBrand': sysGenBrand,
      'SysGenModal': sysGenModal,
      'SysGenYOM': sysGenYOM,
      'SysGenSN': sysGenSN,
      'CnWConsoleMSN': cnWConsoleMSN,
      'CnWConsoleMSW': cnWConsoleMSW,
      'CnWConsoleMOptions': cnWConsoleMOptions,
      'CnWWorkSSN': cnWWorkSSN,
      'CnWWorkSSW': cnWWorkSSW,
      'CnWWorkSOptions': cnWWorkSOptions,
      'CosmeticText': cosmeticText,
      'AccessoriesPModal': accessoriesPModal,
      'AccessoriesPModelNo': accessoriesPModelNo,
      'AccessoriesPSN': accessoriesPSN,
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
      'DetectorModel': detectorModel,
      'DetectorSize': detectorSize,
      'DetectorYOM': detectorYOM,
      'DetectorCondition': detectorCondition,
      'Tube1Model': tube1Model,
      'Tube1YOM': tube1YOM,
    }.withoutNulls,
  );

  return firestoreData;
}

class MammographyRecordDocumentEquality implements Equality<MammographyRecord> {
  const MammographyRecordDocumentEquality();

  @override
  bool equals(MammographyRecord? e1, MammographyRecord? e2) {
    const listEquality = ListEquality();
    return e1?.sysGenBrand == e2?.sysGenBrand &&
        e1?.sysGenModal == e2?.sysGenModal &&
        e1?.sysGenYOM == e2?.sysGenYOM &&
        e1?.sysGenSN == e2?.sysGenSN &&
        e1?.cnWConsoleMSN == e2?.cnWConsoleMSN &&
        e1?.cnWConsoleMSW == e2?.cnWConsoleMSW &&
        e1?.cnWConsoleMOptions == e2?.cnWConsoleMOptions &&
        e1?.cnWWorkSSN == e2?.cnWWorkSSN &&
        e1?.cnWWorkSSW == e2?.cnWWorkSSW &&
        e1?.cnWWorkSOptions == e2?.cnWWorkSOptions &&
        e1?.cosmeticText == e2?.cosmeticText &&
        e1?.accessoriesPModal == e2?.accessoriesPModal &&
        e1?.accessoriesPModelNo == e2?.accessoriesPModelNo &&
        e1?.accessoriesPSN == e2?.accessoriesPSN &&
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
        listEquality.equals(
            e1?.cnWWorkstationOptPURL, e2?.cnWWorkstationOptPURL) &&
        listEquality.equals(e1?.cnWCMOptPURL, e2?.cnWCMOptPURL) &&
        listEquality.equals(e1?.cosmeticPicURL, e2?.cosmeticPicURL) &&
        e1?.detectorModel == e2?.detectorModel &&
        e1?.detectorSize == e2?.detectorSize &&
        e1?.detectorYOM == e2?.detectorYOM &&
        e1?.detectorCondition == e2?.detectorCondition &&
        e1?.tube1Model == e2?.tube1Model &&
        e1?.tube1YOM == e2?.tube1YOM &&
        listEquality.equals(e1?.deviceImg, e2?.deviceImg) &&
        listEquality.equals(e1?.accessoriesPicURL, e2?.accessoriesPicURL) &&
        listEquality.equals(e1?.detectorPicURL, e2?.detectorPicURL) &&
        listEquality.equals(e1?.dnTPicURL, e2?.dnTPicURL) &&
        listEquality.equals(e1?.tubePicURL, e2?.tubePicURL);
  }

  @override
  int hash(MammographyRecord? e) => const ListEquality().hash([
        e?.sysGenBrand,
        e?.sysGenModal,
        e?.sysGenYOM,
        e?.sysGenSN,
        e?.cnWConsoleMSN,
        e?.cnWConsoleMSW,
        e?.cnWConsoleMOptions,
        e?.cnWWorkSSN,
        e?.cnWWorkSSW,
        e?.cnWWorkSOptions,
        e?.cosmeticText,
        e?.accessoriesPModal,
        e?.accessoriesPModelNo,
        e?.accessoriesPSN,
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
        e?.cnWWorkstationOptPURL,
        e?.cnWCMOptPURL,
        e?.cosmeticPicURL,
        e?.detectorModel,
        e?.detectorSize,
        e?.detectorYOM,
        e?.detectorCondition,
        e?.tube1Model,
        e?.tube1YOM,
        e?.deviceImg,
        e?.accessoriesPicURL,
        e?.detectorPicURL,
        e?.dnTPicURL,
        e?.tubePicURL
      ]);

  @override
  bool isValidKey(Object? o) => o is MammographyRecord;
}
