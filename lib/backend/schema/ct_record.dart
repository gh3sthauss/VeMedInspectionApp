import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CtRecord extends FirestoreRecord {
  CtRecord._(
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

  // "SysGenSlices" field.
  String? _sysGenSlices;
  String get sysGenSlices => _sysGenSlices ?? '';
  bool hasSysGenSlices() => _sysGenSlices != null;

  // "GantryModelSN" field.
  String? _gantryModelSN;
  String get gantryModelSN => _gantryModelSN ?? '';
  bool hasGantryModelSN() => _gantryModelSN != null;

  // "GantryTubeModel" field.
  String? _gantryTubeModel;
  String get gantryTubeModel => _gantryTubeModel ?? '';
  bool hasGantryTubeModel() => _gantryTubeModel != null;

  // "GantryTubeYOM" field.
  String? _gantryTubeYOM;
  String get gantryTubeYOM => _gantryTubeYOM ?? '';
  bool hasGantryTubeYOM() => _gantryTubeYOM != null;

  // "GantryTubeScanSec" field.
  String? _gantryTubeScanSec;
  String get gantryTubeScanSec => _gantryTubeScanSec ?? '';
  bool hasGantryTubeScanSec() => _gantryTubeScanSec != null;

  // "GantryDetModal" field.
  String? _gantryDetModal;
  String get gantryDetModal => _gantryDetModal ?? '';
  bool hasGantryDetModal() => _gantryDetModal != null;

  // "GantryDetSN" field.
  String? _gantryDetSN;
  String get gantryDetSN => _gantryDetSN ?? '';
  bool hasGantryDetSN() => _gantryDetSN != null;

  // "GantryDetDC" field.
  String? _gantryDetDC;
  String get gantryDetDC => _gantryDetDC ?? '';
  bool hasGantryDetDC() => _gantryDetDC != null;

  // "GantryTubeOilLeakage" field.
  String? _gantryTubeOilLeakage;
  String get gantryTubeOilLeakage => _gantryTubeOilLeakage ?? '';
  bool hasGantryTubeOilLeakage() => _gantryTubeOilLeakage != null;

  // "CSWaterAir" field.
  String? _cSWaterAir;
  String get cSWaterAir => _cSWaterAir ?? '';
  bool hasCSWaterAir() => _cSWaterAir != null;

  // "CSComesWith" field.
  String? _cSComesWith;
  String get cSComesWith => _cSComesWith ?? '';
  bool hasCSComesWith() => _cSComesWith != null;

  // "PTModal" field.
  String? _pTModal;
  String get pTModal => _pTModal ?? '';
  bool hasPTModal() => _pTModal != null;

  // "PTSN" field.
  String? _ptsn;
  String get ptsn => _ptsn ?? '';
  bool hasPtsn() => _ptsn != null;

  // "PTMC" field.
  String? _ptmc;
  String get ptmc => _ptmc ?? '';
  bool hasPtmc() => _ptmc != null;

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

  // "CnWIRSSN" field.
  String? _cnWIRSSN;
  String get cnWIRSSN => _cnWIRSSN ?? '';
  bool hasCnWIRSSN() => _cnWIRSSN != null;

  // "CnWIRSSW" field.
  String? _cnWIRSSW;
  String get cnWIRSSW => _cnWIRSSW ?? '';
  bool hasCnWIRSSW() => _cnWIRSSW != null;

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

  // "AccessoriesPHolders" field.
  String? _accessoriesPHolders;
  String get accessoriesPHolders => _accessoriesPHolders ?? '';
  bool hasAccessoriesPHolders() => _accessoriesPHolders != null;

  // "AccessoriesCDs" field.
  String? _accessoriesCDs;
  String get accessoriesCDs => _accessoriesCDs ?? '';
  bool hasAccessoriesCDs() => _accessoriesCDs != null;

  // "AccessoriesInjector" field.
  String? _accessoriesInjector;
  String get accessoriesInjector => _accessoriesInjector ?? '';
  bool hasAccessoriesInjector() => _accessoriesInjector != null;

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

  void _initializeFields() {
    _sysGenBrand = snapshotData['SysGenBrand'] as String?;
    _sysGenModal = snapshotData['SysGenModal'] as String?;
    _sysGenYOM = snapshotData['SysGenYOM'] as String?;
    _sysGenSN = snapshotData['SysGenSN'] as String?;
    _sysGenSlices = snapshotData['SysGenSlices'] as String?;
    _gantryModelSN = snapshotData['GantryModelSN'] as String?;
    _gantryTubeModel = snapshotData['GantryTubeModel'] as String?;
    _gantryTubeYOM = snapshotData['GantryTubeYOM'] as String?;
    _gantryTubeScanSec = snapshotData['GantryTubeScanSec'] as String?;
    _gantryDetModal = snapshotData['GantryDetModal'] as String?;
    _gantryDetSN = snapshotData['GantryDetSN'] as String?;
    _gantryDetDC = snapshotData['GantryDetDC'] as String?;
    _gantryTubeOilLeakage = snapshotData['GantryTubeOilLeakage'] as String?;
    _cSWaterAir = snapshotData['CSWaterAir'] as String?;
    _cSComesWith = snapshotData['CSComesWith'] as String?;
    _pTModal = snapshotData['PTModal'] as String?;
    _ptsn = snapshotData['PTSN'] as String?;
    _ptmc = snapshotData['PTMC'] as String?;
    _cnWConsoleMSN = snapshotData['CnWConsoleMSN'] as String?;
    _cnWConsoleMSW = snapshotData['CnWConsoleMSW'] as String?;
    _cnWConsoleMOptions = snapshotData['CnWConsoleMOptions'] as String?;
    _cnWWorkSSN = snapshotData['CnWWorkSSN'] as String?;
    _cnWWorkSSW = snapshotData['CnWWorkSSW'] as String?;
    _cnWWorkSOptions = snapshotData['CnWWorkSOptions'] as String?;
    _cnWIRSSN = snapshotData['CnWIRSSN'] as String?;
    _cnWIRSSW = snapshotData['CnWIRSSW'] as String?;
    _cosmeticText = snapshotData['CosmeticText'] as String?;
    _accessoriesPModal = snapshotData['AccessoriesPModal'] as String?;
    _accessoriesPModelNo = snapshotData['AccessoriesPModelNo'] as String?;
    _accessoriesPSN = snapshotData['AccessoriesPSN'] as String?;
    _accessoriesPHolders = snapshotData['AccessoriesPHolders'] as String?;
    _accessoriesCDs = snapshotData['AccessoriesCDs'] as String?;
    _accessoriesInjector = snapshotData['AccessoriesInjector'] as String?;
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
    _deviceImg = getDataList(snapshotData['DeviceImg']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('CT');

  static Stream<CtRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CtRecord.fromSnapshot(s));

  static Future<CtRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CtRecord.fromSnapshot(s));

  static CtRecord fromSnapshot(DocumentSnapshot snapshot) => CtRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CtRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CtRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CtRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CtRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCtRecordData({
  String? sysGenBrand,
  String? sysGenModal,
  String? sysGenYOM,
  String? sysGenSN,
  String? sysGenSlices,
  String? gantryModelSN,
  String? gantryTubeModel,
  String? gantryTubeYOM,
  String? gantryTubeScanSec,
  String? gantryDetModal,
  String? gantryDetSN,
  String? gantryDetDC,
  String? gantryTubeOilLeakage,
  String? cSWaterAir,
  String? cSComesWith,
  String? pTModal,
  String? ptsn,
  String? ptmc,
  String? cnWConsoleMSN,
  String? cnWConsoleMSW,
  String? cnWConsoleMOptions,
  String? cnWWorkSSN,
  String? cnWWorkSSW,
  String? cnWWorkSOptions,
  String? cnWIRSSN,
  String? cnWIRSSW,
  String? cosmeticText,
  String? accessoriesPModal,
  String? accessoriesPModelNo,
  String? accessoriesPSN,
  String? accessoriesPHolders,
  String? accessoriesCDs,
  String? accessoriesInjector,
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
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'SysGenBrand': sysGenBrand,
      'SysGenModal': sysGenModal,
      'SysGenYOM': sysGenYOM,
      'SysGenSN': sysGenSN,
      'SysGenSlices': sysGenSlices,
      'GantryModelSN': gantryModelSN,
      'GantryTubeModel': gantryTubeModel,
      'GantryTubeYOM': gantryTubeYOM,
      'GantryTubeScanSec': gantryTubeScanSec,
      'GantryDetModal': gantryDetModal,
      'GantryDetSN': gantryDetSN,
      'GantryDetDC': gantryDetDC,
      'GantryTubeOilLeakage': gantryTubeOilLeakage,
      'CSWaterAir': cSWaterAir,
      'CSComesWith': cSComesWith,
      'PTModal': pTModal,
      'PTSN': ptsn,
      'PTMC': ptmc,
      'CnWConsoleMSN': cnWConsoleMSN,
      'CnWConsoleMSW': cnWConsoleMSW,
      'CnWConsoleMOptions': cnWConsoleMOptions,
      'CnWWorkSSN': cnWWorkSSN,
      'CnWWorkSSW': cnWWorkSSW,
      'CnWWorkSOptions': cnWWorkSOptions,
      'CnWIRSSN': cnWIRSSN,
      'CnWIRSSW': cnWIRSSW,
      'CosmeticText': cosmeticText,
      'AccessoriesPModal': accessoriesPModal,
      'AccessoriesPModelNo': accessoriesPModelNo,
      'AccessoriesPSN': accessoriesPSN,
      'AccessoriesPHolders': accessoriesPHolders,
      'AccessoriesCDs': accessoriesCDs,
      'AccessoriesInjector': accessoriesInjector,
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
    }.withoutNulls,
  );

  return firestoreData;
}

class CtRecordDocumentEquality implements Equality<CtRecord> {
  const CtRecordDocumentEquality();

  @override
  bool equals(CtRecord? e1, CtRecord? e2) {
    const listEquality = ListEquality();
    return e1?.sysGenBrand == e2?.sysGenBrand &&
        e1?.sysGenModal == e2?.sysGenModal &&
        e1?.sysGenYOM == e2?.sysGenYOM &&
        e1?.sysGenSN == e2?.sysGenSN &&
        e1?.sysGenSlices == e2?.sysGenSlices &&
        e1?.gantryModelSN == e2?.gantryModelSN &&
        e1?.gantryTubeModel == e2?.gantryTubeModel &&
        e1?.gantryTubeYOM == e2?.gantryTubeYOM &&
        e1?.gantryTubeScanSec == e2?.gantryTubeScanSec &&
        e1?.gantryDetModal == e2?.gantryDetModal &&
        e1?.gantryDetSN == e2?.gantryDetSN &&
        e1?.gantryDetDC == e2?.gantryDetDC &&
        e1?.gantryTubeOilLeakage == e2?.gantryTubeOilLeakage &&
        e1?.cSWaterAir == e2?.cSWaterAir &&
        e1?.cSComesWith == e2?.cSComesWith &&
        e1?.pTModal == e2?.pTModal &&
        e1?.ptsn == e2?.ptsn &&
        e1?.ptmc == e2?.ptmc &&
        e1?.cnWConsoleMSN == e2?.cnWConsoleMSN &&
        e1?.cnWConsoleMSW == e2?.cnWConsoleMSW &&
        e1?.cnWConsoleMOptions == e2?.cnWConsoleMOptions &&
        e1?.cnWWorkSSN == e2?.cnWWorkSSN &&
        e1?.cnWWorkSSW == e2?.cnWWorkSSW &&
        e1?.cnWWorkSOptions == e2?.cnWWorkSOptions &&
        e1?.cnWIRSSN == e2?.cnWIRSSN &&
        e1?.cnWIRSSW == e2?.cnWIRSSW &&
        e1?.cosmeticText == e2?.cosmeticText &&
        e1?.accessoriesPModal == e2?.accessoriesPModal &&
        e1?.accessoriesPModelNo == e2?.accessoriesPModelNo &&
        e1?.accessoriesPSN == e2?.accessoriesPSN &&
        e1?.accessoriesPHolders == e2?.accessoriesPHolders &&
        e1?.accessoriesCDs == e2?.accessoriesCDs &&
        e1?.accessoriesInjector == e2?.accessoriesInjector &&
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
        listEquality.equals(e1?.deviceImg, e2?.deviceImg);
  }

  @override
  int hash(CtRecord? e) => const ListEquality().hash([
        e?.sysGenBrand,
        e?.sysGenModal,
        e?.sysGenYOM,
        e?.sysGenSN,
        e?.sysGenSlices,
        e?.gantryModelSN,
        e?.gantryTubeModel,
        e?.gantryTubeYOM,
        e?.gantryTubeScanSec,
        e?.gantryDetModal,
        e?.gantryDetSN,
        e?.gantryDetDC,
        e?.gantryTubeOilLeakage,
        e?.cSWaterAir,
        e?.cSComesWith,
        e?.pTModal,
        e?.ptsn,
        e?.ptmc,
        e?.cnWConsoleMSN,
        e?.cnWConsoleMSW,
        e?.cnWConsoleMOptions,
        e?.cnWWorkSSN,
        e?.cnWWorkSSW,
        e?.cnWWorkSOptions,
        e?.cnWIRSSN,
        e?.cnWIRSSW,
        e?.cosmeticText,
        e?.accessoriesPModal,
        e?.accessoriesPModelNo,
        e?.accessoriesPSN,
        e?.accessoriesPHolders,
        e?.accessoriesCDs,
        e?.accessoriesInjector,
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
        e?.deviceImg
      ]);

  @override
  bool isValidKey(Object? o) => o is CtRecord;
}
