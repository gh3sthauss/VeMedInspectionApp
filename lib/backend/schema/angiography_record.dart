import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AngiographyRecord extends FirestoreRecord {
  AngiographyRecord._(
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

  // "Tube1Model" field.
  String? _tube1Model;
  String get tube1Model => _tube1Model ?? '';
  bool hasTube1Model() => _tube1Model != null;

  // "Tube1YOM" field.
  String? _tube1YOM;
  String get tube1YOM => _tube1YOM ?? '';
  bool hasTube1YOM() => _tube1YOM != null;

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

  // "AccPhantomModel" field.
  String? _accPhantomModel;
  String get accPhantomModel => _accPhantomModel ?? '';
  bool hasAccPhantomModel() => _accPhantomModel != null;

  // "AccPhantomModelNo" field.
  String? _accPhantomModelNo;
  String get accPhantomModelNo => _accPhantomModelNo ?? '';
  bool hasAccPhantomModelNo() => _accPhantomModelNo != null;

  // "AccPhantomSN" field.
  String? _accPhantomSN;
  String get accPhantomSN => _accPhantomSN ?? '';
  bool hasAccPhantomSN() => _accPhantomSN != null;

  // "CosmeticPicURL" field.
  List<String>? _cosmeticPicURL;
  List<String> get cosmeticPicURL => _cosmeticPicURL ?? const [];
  bool hasCosmeticPicURL() => _cosmeticPicURL != null;

  // "AccPhantom1Model" field.
  String? _accPhantom1Model;
  String get accPhantom1Model => _accPhantom1Model ?? '';
  bool hasAccPhantom1Model() => _accPhantom1Model != null;

  // "AccPhantom1ModelNo" field.
  String? _accPhantom1ModelNo;
  String get accPhantom1ModelNo => _accPhantom1ModelNo ?? '';
  bool hasAccPhantom1ModelNo() => _accPhantom1ModelNo != null;

  // "AccPhantom1ModelSN" field.
  String? _accPhantom1ModelSN;
  String get accPhantom1ModelSN => _accPhantom1ModelSN ?? '';
  bool hasAccPhantom1ModelSN() => _accPhantom1ModelSN != null;

  // "AccPhantom2Model" field.
  String? _accPhantom2Model;
  String get accPhantom2Model => _accPhantom2Model ?? '';
  bool hasAccPhantom2Model() => _accPhantom2Model != null;

  // "AccPhantom2ModelNo" field.
  String? _accPhantom2ModelNo;
  String get accPhantom2ModelNo => _accPhantom2ModelNo ?? '';
  bool hasAccPhantom2ModelNo() => _accPhantom2ModelNo != null;

  // "AccPhantom2ModelSN" field.
  String? _accPhantom2ModelSN;
  String get accPhantom2ModelSN => _accPhantom2ModelSN ?? '';
  bool hasAccPhantom2ModelSN() => _accPhantom2ModelSN != null;

  // "AccPhantom3Model" field.
  String? _accPhantom3Model;
  String get accPhantom3Model => _accPhantom3Model ?? '';
  bool hasAccPhantom3Model() => _accPhantom3Model != null;

  // "AccPhantom3ModelNo" field.
  String? _accPhantom3ModelNo;
  String get accPhantom3ModelNo => _accPhantom3ModelNo ?? '';
  bool hasAccPhantom3ModelNo() => _accPhantom3ModelNo != null;

  // "AccPhantom3ModelSN" field.
  String? _accPhantom3ModelSN;
  String get accPhantom3ModelSN => _accPhantom3ModelSN ?? '';
  bool hasAccPhantom3ModelSN() => _accPhantom3ModelSN != null;

  // "CnWCMOptPURL" field.
  List<String>? _cnWCMOptPURL;
  List<String> get cnWCMOptPURL => _cnWCMOptPURL ?? const [];
  bool hasCnWCMOptPURL() => _cnWCMOptPURL != null;

  // "CnWConsoleMOptions" field.
  String? _cnWConsoleMOptions;
  String get cnWConsoleMOptions => _cnWConsoleMOptions ?? '';
  bool hasCnWConsoleMOptions() => _cnWConsoleMOptions != null;

  // "CnWConsoleMSN" field.
  String? _cnWConsoleMSN;
  String get cnWConsoleMSN => _cnWConsoleMSN ?? '';
  bool hasCnWConsoleMSN() => _cnWConsoleMSN != null;

  // "CnWConsoleMSW" field.
  String? _cnWConsoleMSW;
  String get cnWConsoleMSW => _cnWConsoleMSW ?? '';
  bool hasCnWConsoleMSW() => _cnWConsoleMSW != null;

  // "CnWIRSSN" field.
  String? _cnWIRSSN;
  String get cnWIRSSN => _cnWIRSSN ?? '';
  bool hasCnWIRSSN() => _cnWIRSSN != null;

  // "CnWIRSSW" field.
  String? _cnWIRSSW;
  String get cnWIRSSW => _cnWIRSSW ?? '';
  bool hasCnWIRSSW() => _cnWIRSSW != null;

  // "CnWWorkSOptions" field.
  String? _cnWWorkSOptions;
  String get cnWWorkSOptions => _cnWWorkSOptions ?? '';
  bool hasCnWWorkSOptions() => _cnWWorkSOptions != null;

  // "CnWWorkSSN" field.
  String? _cnWWorkSSN;
  String get cnWWorkSSN => _cnWWorkSSN ?? '';
  bool hasCnWWorkSSN() => _cnWWorkSSN != null;

  // "CnWWorkSSW" field.
  String? _cnWWorkSSW;
  String get cnWWorkSSW => _cnWWorkSSW ?? '';
  bool hasCnWWorkSSW() => _cnWWorkSSW != null;

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

  // "DeviceImg" field.
  List<String>? _deviceImg;
  List<String> get deviceImg => _deviceImg ?? const [];
  bool hasDeviceImg() => _deviceImg != null;

  // "PhotosURL" field.
  String? _photosURL;
  String get photosURL => _photosURL ?? '';
  bool hasPhotosURL() => _photosURL != null;

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
    _tube1Model = snapshotData['Tube1Model'] as String?;
    _tube1YOM = snapshotData['Tube1YOM'] as String?;
    _detectorModel = snapshotData['DetectorModel'] as String?;
    _detectorSize = snapshotData['DetectorSize'] as String?;
    _detectorYOM = snapshotData['DetectorYOM'] as String?;
    _detectorCondition = snapshotData['DetectorCondition'] as String?;
    _accPhantomModel = snapshotData['AccPhantomModel'] as String?;
    _accPhantomModelNo = snapshotData['AccPhantomModelNo'] as String?;
    _accPhantomSN = snapshotData['AccPhantomSN'] as String?;
    _cosmeticPicURL = getDataList(snapshotData['CosmeticPicURL']);
    _accPhantom1Model = snapshotData['AccPhantom1Model'] as String?;
    _accPhantom1ModelNo = snapshotData['AccPhantom1ModelNo'] as String?;
    _accPhantom1ModelSN = snapshotData['AccPhantom1ModelSN'] as String?;
    _accPhantom2Model = snapshotData['AccPhantom2Model'] as String?;
    _accPhantom2ModelNo = snapshotData['AccPhantom2ModelNo'] as String?;
    _accPhantom2ModelSN = snapshotData['AccPhantom2ModelSN'] as String?;
    _accPhantom3Model = snapshotData['AccPhantom3Model'] as String?;
    _accPhantom3ModelNo = snapshotData['AccPhantom3ModelNo'] as String?;
    _accPhantom3ModelSN = snapshotData['AccPhantom3ModelSN'] as String?;
    _cnWCMOptPURL = getDataList(snapshotData['CnWCMOptPURL']);
    _cnWConsoleMOptions = snapshotData['CnWConsoleMOptions'] as String?;
    _cnWConsoleMSN = snapshotData['CnWConsoleMSN'] as String?;
    _cnWConsoleMSW = snapshotData['CnWConsoleMSW'] as String?;
    _cnWIRSSN = snapshotData['CnWIRSSN'] as String?;
    _cnWIRSSW = snapshotData['CnWIRSSW'] as String?;
    _cnWWorkSOptions = snapshotData['CnWWorkSOptions'] as String?;
    _cnWWorkSSN = snapshotData['CnWWorkSSN'] as String?;
    _cnWWorkSSW = snapshotData['CnWWorkSSW'] as String?;
    _pTModal = snapshotData['PTModal'] as String?;
    _ptsn = snapshotData['PTSN'] as String?;
    _ptmc = snapshotData['PTMC'] as String?;
    _deviceImg = getDataList(snapshotData['DeviceImg']);
    _photosURL = snapshotData['PhotosURL'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Angiography');

  static Stream<AngiographyRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AngiographyRecord.fromSnapshot(s));

  static Future<AngiographyRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AngiographyRecord.fromSnapshot(s));

  static AngiographyRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AngiographyRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AngiographyRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AngiographyRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AngiographyRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AngiographyRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAngiographyRecordData({
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
  String? tube1Model,
  String? tube1YOM,
  String? detectorModel,
  String? detectorSize,
  String? detectorYOM,
  String? detectorCondition,
  String? accPhantomModel,
  String? accPhantomModelNo,
  String? accPhantomSN,
  String? accPhantom1Model,
  String? accPhantom1ModelNo,
  String? accPhantom1ModelSN,
  String? accPhantom2Model,
  String? accPhantom2ModelNo,
  String? accPhantom2ModelSN,
  String? accPhantom3Model,
  String? accPhantom3ModelNo,
  String? accPhantom3ModelSN,
  String? cnWConsoleMOptions,
  String? cnWConsoleMSN,
  String? cnWConsoleMSW,
  String? cnWIRSSN,
  String? cnWIRSSW,
  String? cnWWorkSOptions,
  String? cnWWorkSSN,
  String? cnWWorkSSW,
  String? pTModal,
  String? ptsn,
  String? ptmc,
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
      'Tube1Model': tube1Model,
      'Tube1YOM': tube1YOM,
      'DetectorModel': detectorModel,
      'DetectorSize': detectorSize,
      'DetectorYOM': detectorYOM,
      'DetectorCondition': detectorCondition,
      'AccPhantomModel': accPhantomModel,
      'AccPhantomModelNo': accPhantomModelNo,
      'AccPhantomSN': accPhantomSN,
      'AccPhantom1Model': accPhantom1Model,
      'AccPhantom1ModelNo': accPhantom1ModelNo,
      'AccPhantom1ModelSN': accPhantom1ModelSN,
      'AccPhantom2Model': accPhantom2Model,
      'AccPhantom2ModelNo': accPhantom2ModelNo,
      'AccPhantom2ModelSN': accPhantom2ModelSN,
      'AccPhantom3Model': accPhantom3Model,
      'AccPhantom3ModelNo': accPhantom3ModelNo,
      'AccPhantom3ModelSN': accPhantom3ModelSN,
      'CnWConsoleMOptions': cnWConsoleMOptions,
      'CnWConsoleMSN': cnWConsoleMSN,
      'CnWConsoleMSW': cnWConsoleMSW,
      'CnWIRSSN': cnWIRSSN,
      'CnWIRSSW': cnWIRSSW,
      'CnWWorkSOptions': cnWWorkSOptions,
      'CnWWorkSSN': cnWWorkSSN,
      'CnWWorkSSW': cnWWorkSSW,
      'PTModal': pTModal,
      'PTSN': ptsn,
      'PTMC': ptmc,
      'PhotosURL': photosURL,
    }.withoutNulls,
  );

  return firestoreData;
}

class AngiographyRecordDocumentEquality implements Equality<AngiographyRecord> {
  const AngiographyRecordDocumentEquality();

  @override
  bool equals(AngiographyRecord? e1, AngiographyRecord? e2) {
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
        e1?.tube1Model == e2?.tube1Model &&
        e1?.tube1YOM == e2?.tube1YOM &&
        e1?.detectorModel == e2?.detectorModel &&
        e1?.detectorSize == e2?.detectorSize &&
        e1?.detectorYOM == e2?.detectorYOM &&
        e1?.detectorCondition == e2?.detectorCondition &&
        e1?.accPhantomModel == e2?.accPhantomModel &&
        e1?.accPhantomModelNo == e2?.accPhantomModelNo &&
        e1?.accPhantomSN == e2?.accPhantomSN &&
        listEquality.equals(e1?.cosmeticPicURL, e2?.cosmeticPicURL) &&
        e1?.accPhantom1Model == e2?.accPhantom1Model &&
        e1?.accPhantom1ModelNo == e2?.accPhantom1ModelNo &&
        e1?.accPhantom1ModelSN == e2?.accPhantom1ModelSN &&
        e1?.accPhantom2Model == e2?.accPhantom2Model &&
        e1?.accPhantom2ModelNo == e2?.accPhantom2ModelNo &&
        e1?.accPhantom2ModelSN == e2?.accPhantom2ModelSN &&
        e1?.accPhantom3Model == e2?.accPhantom3Model &&
        e1?.accPhantom3ModelNo == e2?.accPhantom3ModelNo &&
        e1?.accPhantom3ModelSN == e2?.accPhantom3ModelSN &&
        listEquality.equals(e1?.cnWCMOptPURL, e2?.cnWCMOptPURL) &&
        e1?.cnWConsoleMOptions == e2?.cnWConsoleMOptions &&
        e1?.cnWConsoleMSN == e2?.cnWConsoleMSN &&
        e1?.cnWConsoleMSW == e2?.cnWConsoleMSW &&
        e1?.cnWIRSSN == e2?.cnWIRSSN &&
        e1?.cnWIRSSW == e2?.cnWIRSSW &&
        e1?.cnWWorkSOptions == e2?.cnWWorkSOptions &&
        e1?.cnWWorkSSN == e2?.cnWWorkSSN &&
        e1?.cnWWorkSSW == e2?.cnWWorkSSW &&
        e1?.pTModal == e2?.pTModal &&
        e1?.ptsn == e2?.ptsn &&
        e1?.ptmc == e2?.ptmc &&
        listEquality.equals(e1?.deviceImg, e2?.deviceImg) &&
        e1?.photosURL == e2?.photosURL;
  }

  @override
  int hash(AngiographyRecord? e) => const ListEquality().hash([
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
        e?.tube1Model,
        e?.tube1YOM,
        e?.detectorModel,
        e?.detectorSize,
        e?.detectorYOM,
        e?.detectorCondition,
        e?.accPhantomModel,
        e?.accPhantomModelNo,
        e?.accPhantomSN,
        e?.cosmeticPicURL,
        e?.accPhantom1Model,
        e?.accPhantom1ModelNo,
        e?.accPhantom1ModelSN,
        e?.accPhantom2Model,
        e?.accPhantom2ModelNo,
        e?.accPhantom2ModelSN,
        e?.accPhantom3Model,
        e?.accPhantom3ModelNo,
        e?.accPhantom3ModelSN,
        e?.cnWCMOptPURL,
        e?.cnWConsoleMOptions,
        e?.cnWConsoleMSN,
        e?.cnWConsoleMSW,
        e?.cnWIRSSN,
        e?.cnWIRSSW,
        e?.cnWWorkSOptions,
        e?.cnWWorkSSN,
        e?.cnWWorkSSW,
        e?.pTModal,
        e?.ptsn,
        e?.ptmc,
        e?.deviceImg,
        e?.photosURL
      ]);

  @override
  bool isValidKey(Object? o) => o is AngiographyRecord;
}
