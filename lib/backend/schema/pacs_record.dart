import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PacsRecord extends FirestoreRecord {
  PacsRecord._(
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

  // "CR1Model" field.
  String? _cR1Model;
  String get cR1Model => _cR1Model ?? '';
  bool hasCR1Model() => _cR1Model != null;

  // "CR2Model" field.
  String? _cR2Model;
  String get cR2Model => _cR2Model ?? '';
  bool hasCR2Model() => _cR2Model != null;

  // "CR3Model" field.
  String? _cR3Model;
  String get cR3Model => _cR3Model ?? '';
  bool hasCR3Model() => _cR3Model != null;

  // "CR4Model" field.
  String? _cR4Model;
  String get cR4Model => _cR4Model ?? '';
  bool hasCR4Model() => _cR4Model != null;

  // "CR5Model" field.
  String? _cR5Model;
  String get cR5Model => _cR5Model ?? '';
  bool hasCR5Model() => _cR5Model != null;

  // "CR6Model" field.
  String? _cR6Model;
  String get cR6Model => _cR6Model ?? '';
  bool hasCR6Model() => _cR6Model != null;

  // "CR7Model" field.
  String? _cR7Model;
  String get cR7Model => _cR7Model ?? '';
  bool hasCR7Model() => _cR7Model != null;

  // "CR8Model" field.
  String? _cR8Model;
  String get cR8Model => _cR8Model ?? '';
  bool hasCR8Model() => _cR8Model != null;

  // "CR1Size" field.
  String? _cR1Size;
  String get cR1Size => _cR1Size ?? '';
  bool hasCR1Size() => _cR1Size != null;

  // "CR2Size" field.
  String? _cR2Size;
  String get cR2Size => _cR2Size ?? '';
  bool hasCR2Size() => _cR2Size != null;

  // "CR3Size" field.
  String? _cR3Size;
  String get cR3Size => _cR3Size ?? '';
  bool hasCR3Size() => _cR3Size != null;

  // "CR4Size" field.
  String? _cR4Size;
  String get cR4Size => _cR4Size ?? '';
  bool hasCR4Size() => _cR4Size != null;

  // "CR5Size" field.
  String? _cR5Size;
  String get cR5Size => _cR5Size ?? '';
  bool hasCR5Size() => _cR5Size != null;

  // "CR6Size" field.
  String? _cR6Size;
  String get cR6Size => _cR6Size ?? '';
  bool hasCR6Size() => _cR6Size != null;

  // "CR7Size" field.
  String? _cR7Size;
  String get cR7Size => _cR7Size ?? '';
  bool hasCR7Size() => _cR7Size != null;

  // "CR8Size" field.
  String? _cR8Size;
  String get cR8Size => _cR8Size ?? '';
  bool hasCR8Size() => _cR8Size != null;

  // "CR1Condition" field.
  String? _cR1Condition;
  String get cR1Condition => _cR1Condition ?? '';
  bool hasCR1Condition() => _cR1Condition != null;

  // "CR2Condition" field.
  String? _cR2Condition;
  String get cR2Condition => _cR2Condition ?? '';
  bool hasCR2Condition() => _cR2Condition != null;

  // "CR3Condition" field.
  String? _cR3Condition;
  String get cR3Condition => _cR3Condition ?? '';
  bool hasCR3Condition() => _cR3Condition != null;

  // "CR4Condition" field.
  String? _cR4Condition;
  String get cR4Condition => _cR4Condition ?? '';
  bool hasCR4Condition() => _cR4Condition != null;

  // "CR5Condition" field.
  String? _cR5Condition;
  String get cR5Condition => _cR5Condition ?? '';
  bool hasCR5Condition() => _cR5Condition != null;

  // "CR6Condition" field.
  String? _cR6Condition;
  String get cR6Condition => _cR6Condition ?? '';
  bool hasCR6Condition() => _cR6Condition != null;

  // "CR7Condition" field.
  String? _cR7Condition;
  String get cR7Condition => _cR7Condition ?? '';
  bool hasCR7Condition() => _cR7Condition != null;

  // "CR8Condition" field.
  String? _cR8Condition;
  String get cR8Condition => _cR8Condition ?? '';
  bool hasCR8Condition() => _cR8Condition != null;

  // "AccessoriesPicURL" field.
  List<String>? _accessoriesPicURL;
  List<String> get accessoriesPicURL => _accessoriesPicURL ?? const [];
  bool hasAccessoriesPicURL() => _accessoriesPicURL != null;

  // "CassettesPicURL" field.
  List<String>? _cassettesPicURL;
  List<String> get cassettesPicURL => _cassettesPicURL ?? const [];
  bool hasCassettesPicURL() => _cassettesPicURL != null;

  // "DetectorPicURL" field.
  List<String>? _detectorPicURL;
  List<String> get detectorPicURL => _detectorPicURL ?? const [];
  bool hasDetectorPicURL() => _detectorPicURL != null;

  // "DnTPicURL" field.
  List<String>? _dnTPicURL;
  List<String> get dnTPicURL => _dnTPicURL ?? const [];
  bool hasDnTPicURL() => _dnTPicURL != null;

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
    _cR1Model = snapshotData['CR1Model'] as String?;
    _cR2Model = snapshotData['CR2Model'] as String?;
    _cR3Model = snapshotData['CR3Model'] as String?;
    _cR4Model = snapshotData['CR4Model'] as String?;
    _cR5Model = snapshotData['CR5Model'] as String?;
    _cR6Model = snapshotData['CR6Model'] as String?;
    _cR7Model = snapshotData['CR7Model'] as String?;
    _cR8Model = snapshotData['CR8Model'] as String?;
    _cR1Size = snapshotData['CR1Size'] as String?;
    _cR2Size = snapshotData['CR2Size'] as String?;
    _cR3Size = snapshotData['CR3Size'] as String?;
    _cR4Size = snapshotData['CR4Size'] as String?;
    _cR5Size = snapshotData['CR5Size'] as String?;
    _cR6Size = snapshotData['CR6Size'] as String?;
    _cR7Size = snapshotData['CR7Size'] as String?;
    _cR8Size = snapshotData['CR8Size'] as String?;
    _cR1Condition = snapshotData['CR1Condition'] as String?;
    _cR2Condition = snapshotData['CR2Condition'] as String?;
    _cR3Condition = snapshotData['CR3Condition'] as String?;
    _cR4Condition = snapshotData['CR4Condition'] as String?;
    _cR5Condition = snapshotData['CR5Condition'] as String?;
    _cR6Condition = snapshotData['CR6Condition'] as String?;
    _cR7Condition = snapshotData['CR7Condition'] as String?;
    _cR8Condition = snapshotData['CR8Condition'] as String?;
    _deviceImg = getDataList(snapshotData['DeviceImg']);
    _accessoriesPicURL = getDataList(snapshotData['AccessoriesPicURL']);
    _cassettesPicURL = getDataList(snapshotData['CassettesPicURL']);
    _detectorPicURL = getDataList(snapshotData['DetectorPicURL']);
    _dnTPicURL = getDataList(snapshotData['DnTPicURL']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('PACS');

  static Stream<PacsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PacsRecord.fromSnapshot(s));

  static Future<PacsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PacsRecord.fromSnapshot(s));

  static PacsRecord fromSnapshot(DocumentSnapshot snapshot) => PacsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PacsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PacsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PacsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PacsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPacsRecordData({
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
  String? cR1Model,
  String? cR2Model,
  String? cR3Model,
  String? cR4Model,
  String? cR5Model,
  String? cR6Model,
  String? cR7Model,
  String? cR8Model,
  String? cR1Size,
  String? cR2Size,
  String? cR3Size,
  String? cR4Size,
  String? cR5Size,
  String? cR6Size,
  String? cR7Size,
  String? cR8Size,
  String? cR1Condition,
  String? cR2Condition,
  String? cR3Condition,
  String? cR4Condition,
  String? cR5Condition,
  String? cR6Condition,
  String? cR7Condition,
  String? cR8Condition,
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
      'CR1Model': cR1Model,
      'CR2Model': cR2Model,
      'CR3Model': cR3Model,
      'CR4Model': cR4Model,
      'CR5Model': cR5Model,
      'CR6Model': cR6Model,
      'CR7Model': cR7Model,
      'CR8Model': cR8Model,
      'CR1Size': cR1Size,
      'CR2Size': cR2Size,
      'CR3Size': cR3Size,
      'CR4Size': cR4Size,
      'CR5Size': cR5Size,
      'CR6Size': cR6Size,
      'CR7Size': cR7Size,
      'CR8Size': cR8Size,
      'CR1Condition': cR1Condition,
      'CR2Condition': cR2Condition,
      'CR3Condition': cR3Condition,
      'CR4Condition': cR4Condition,
      'CR5Condition': cR5Condition,
      'CR6Condition': cR6Condition,
      'CR7Condition': cR7Condition,
      'CR8Condition': cR8Condition,
    }.withoutNulls,
  );

  return firestoreData;
}

class PacsRecordDocumentEquality implements Equality<PacsRecord> {
  const PacsRecordDocumentEquality();

  @override
  bool equals(PacsRecord? e1, PacsRecord? e2) {
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
        e1?.cR1Model == e2?.cR1Model &&
        e1?.cR2Model == e2?.cR2Model &&
        e1?.cR3Model == e2?.cR3Model &&
        e1?.cR4Model == e2?.cR4Model &&
        e1?.cR5Model == e2?.cR5Model &&
        e1?.cR6Model == e2?.cR6Model &&
        e1?.cR7Model == e2?.cR7Model &&
        e1?.cR8Model == e2?.cR8Model &&
        e1?.cR1Size == e2?.cR1Size &&
        e1?.cR2Size == e2?.cR2Size &&
        e1?.cR3Size == e2?.cR3Size &&
        e1?.cR4Size == e2?.cR4Size &&
        e1?.cR5Size == e2?.cR5Size &&
        e1?.cR6Size == e2?.cR6Size &&
        e1?.cR7Size == e2?.cR7Size &&
        e1?.cR8Size == e2?.cR8Size &&
        e1?.cR1Condition == e2?.cR1Condition &&
        e1?.cR2Condition == e2?.cR2Condition &&
        e1?.cR3Condition == e2?.cR3Condition &&
        e1?.cR4Condition == e2?.cR4Condition &&
        e1?.cR5Condition == e2?.cR5Condition &&
        e1?.cR6Condition == e2?.cR6Condition &&
        e1?.cR7Condition == e2?.cR7Condition &&
        e1?.cR8Condition == e2?.cR8Condition &&
        listEquality.equals(e1?.deviceImg, e2?.deviceImg) &&
        listEquality.equals(e1?.accessoriesPicURL, e2?.accessoriesPicURL) &&
        listEquality.equals(e1?.cassettesPicURL, e2?.cassettesPicURL) &&
        listEquality.equals(e1?.detectorPicURL, e2?.detectorPicURL) &&
        listEquality.equals(e1?.dnTPicURL, e2?.dnTPicURL);
  }

  @override
  int hash(PacsRecord? e) => const ListEquality().hash([
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
        e?.cR1Model,
        e?.cR2Model,
        e?.cR3Model,
        e?.cR4Model,
        e?.cR5Model,
        e?.cR6Model,
        e?.cR7Model,
        e?.cR8Model,
        e?.cR1Size,
        e?.cR2Size,
        e?.cR3Size,
        e?.cR4Size,
        e?.cR5Size,
        e?.cR6Size,
        e?.cR7Size,
        e?.cR8Size,
        e?.cR1Condition,
        e?.cR2Condition,
        e?.cR3Condition,
        e?.cR4Condition,
        e?.cR5Condition,
        e?.cR6Condition,
        e?.cR7Condition,
        e?.cR8Condition,
        e?.deviceImg,
        e?.accessoriesPicURL,
        e?.cassettesPicURL,
        e?.detectorPicURL,
        e?.dnTPicURL
      ]);

  @override
  bool isValidKey(Object? o) => o is PacsRecord;
}
