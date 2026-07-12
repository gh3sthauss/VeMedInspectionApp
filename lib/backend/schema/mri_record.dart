import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MriRecord extends FirestoreRecord {
  MriRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "SysGenModal" field.
  String? _sysGenModal;
  String get sysGenModal => _sysGenModal ?? '';
  bool hasSysGenModal() => _sysGenModal != null;

  // "SysGenBrand" field.
  String? _sysGenBrand;
  String get sysGenBrand => _sysGenBrand ?? '';
  bool hasSysGenBrand() => _sysGenBrand != null;

  // "SysGenSN" field.
  String? _sysGenSN;
  String get sysGenSN => _sysGenSN ?? '';
  bool hasSysGenSN() => _sysGenSN != null;

  // "SysGenYOM" field.
  String? _sysGenYOM;
  String get sysGenYOM => _sysGenYOM ?? '';
  bool hasSysGenYOM() => _sysGenYOM != null;

  // "MagnetYOM" field.
  String? _magnetYOM;
  String get magnetYOM => _magnetYOM ?? '';
  bool hasMagnetYOM() => _magnetYOM != null;

  // "MagnetModel" field.
  String? _magnetModel;
  String get magnetModel => _magnetModel ?? '';
  bool hasMagnetModel() => _magnetModel != null;

  // "MagnetSN" field.
  String? _magnetSN;
  String get magnetSN => _magnetSN ?? '';
  bool hasMagnetSN() => _magnetSN != null;

  // "MagnetPressure" field.
  String? _magnetPressure;
  String get magnetPressure => _magnetPressure ?? '';
  bool hasMagnetPressure() => _magnetPressure != null;

  // "MagnetShieldTemp" field.
  String? _magnetShieldTemp;
  String get magnetShieldTemp => _magnetShieldTemp ?? '';
  bool hasMagnetShieldTemp() => _magnetShieldTemp != null;

  // "MagnetHELevel" field.
  String? _magnetHELevel;
  String get magnetHELevel => _magnetHELevel ?? '';
  bool hasMagnetHELevel() => _magnetHELevel != null;

  // "CoolerCompModel" field.
  String? _coolerCompModel;
  String get coolerCompModel => _coolerCompModel ?? '';
  bool hasCoolerCompModel() => _coolerCompModel != null;

  // "CoolerCompYOM" field.
  String? _coolerCompYOM;
  String get coolerCompYOM => _coolerCompYOM ?? '';
  bool hasCoolerCompYOM() => _coolerCompYOM != null;

  // "CoolerCompHours" field.
  String? _coolerCompHours;
  String get coolerCompHours => _coolerCompHours ?? '';
  bool hasCoolerCompHours() => _coolerCompHours != null;

  // "CoolerCompPressure" field.
  String? _coolerCompPressure;
  String get coolerCompPressure => _coolerCompPressure ?? '';
  bool hasCoolerCompPressure() => _coolerCompPressure != null;

  // "CoolerCompLAR" field.
  String? _coolerCompLAR;
  String get coolerCompLAR => _coolerCompLAR ?? '';
  bool hasCoolerCompLAR() => _coolerCompLAR != null;

  // "ImagerModel" field.
  String? _imagerModel;
  String get imagerModel => _imagerModel ?? '';
  bool hasImagerModel() => _imagerModel != null;

  // "ImagerModelSN" field.
  String? _imagerModelSN;
  String get imagerModelSN => _imagerModelSN ?? '';
  bool hasImagerModelSN() => _imagerModelSN != null;

  // "ImagerDVStarModel" field.
  String? _imagerDVStarModel;
  String get imagerDVStarModel => _imagerDVStarModel ?? '';
  bool hasImagerDVStarModel() => _imagerDVStarModel != null;

  // "ImagerDVStarSN" field.
  String? _imagerDVStarSN;
  String get imagerDVStarSN => _imagerDVStarSN ?? '';
  bool hasImagerDVStarSN() => _imagerDVStarSN != null;

  // "ImagerPCIRX1Model" field.
  String? _imagerPCIRX1Model;
  String get imagerPCIRX1Model => _imagerPCIRX1Model ?? '';
  bool hasImagerPCIRX1Model() => _imagerPCIRX1Model != null;

  // "ImagerPCIRX1ModelSN" field.
  String? _imagerPCIRX1ModelSN;
  String get imagerPCIRX1ModelSN => _imagerPCIRX1ModelSN ?? '';
  bool hasImagerPCIRX1ModelSN() => _imagerPCIRX1ModelSN != null;

  // "ImagerPCIRX2Model" field.
  String? _imagerPCIRX2Model;
  String get imagerPCIRX2Model => _imagerPCIRX2Model ?? '';
  bool hasImagerPCIRX2Model() => _imagerPCIRX2Model != null;

  // "ImagerPCIRX2ModelSN" field.
  String? _imagerPCIRX2ModelSN;
  String get imagerPCIRX2ModelSN => _imagerPCIRX2ModelSN ?? '';
  bool hasImagerPCIRX2ModelSN() => _imagerPCIRX2ModelSN != null;

  // "ECGModel" field.
  String? _eCGModel;
  String get eCGModel => _eCGModel ?? '';
  bool hasECGModel() => _eCGModel != null;

  // "ECGSN" field.
  String? _ecgsn;
  String get ecgsn => _ecgsn ?? '';
  bool hasEcgsn() => _ecgsn != null;

  // "ECGFuncChecked" field.
  String? _eCGFuncChecked;
  String get eCGFuncChecked => _eCGFuncChecked ?? '';
  bool hasECGFuncChecked() => _eCGFuncChecked != null;

  // "PowerStages1SN" field.
  String? _powerStages1SN;
  String get powerStages1SN => _powerStages1SN ?? '';
  bool hasPowerStages1SN() => _powerStages1SN != null;

  // "PowerStages2SN" field.
  String? _powerStages2SN;
  String get powerStages2SN => _powerStages2SN ?? '';
  bool hasPowerStages2SN() => _powerStages2SN != null;

  // "PowerStages3SN" field.
  String? _powerStages3SN;
  String get powerStages3SN => _powerStages3SN ?? '';
  bool hasPowerStages3SN() => _powerStages3SN != null;

  // "TalesLastReplacement" field.
  String? _talesLastReplacement;
  String get talesLastReplacement => _talesLastReplacement ?? '';
  bool hasTalesLastReplacement() => _talesLastReplacement != null;

  // "PatientTableModel" field.
  String? _patientTableModel;
  String get patientTableModel => _patientTableModel ?? '';
  bool hasPatientTableModel() => _patientTableModel != null;

  // "PatientTableSN" field.
  String? _patientTableSN;
  String get patientTableSN => _patientTableSN ?? '';
  bool hasPatientTableSN() => _patientTableSN != null;

  // "PatientTableMoveTests" field.
  String? _patientTableMoveTests;
  String get patientTableMoveTests => _patientTableMoveTests ?? '';
  bool hasPatientTableMoveTests() => _patientTableMoveTests != null;

  // "CnWConsoleSN" field.
  String? _cnWConsoleSN;
  String get cnWConsoleSN => _cnWConsoleSN ?? '';
  bool hasCnWConsoleSN() => _cnWConsoleSN != null;

  // "CnWConsoleSW" field.
  String? _cnWConsoleSW;
  String get cnWConsoleSW => _cnWConsoleSW ?? '';
  bool hasCnWConsoleSW() => _cnWConsoleSW != null;

  // "CnWConsoleOptionsText" field.
  String? _cnWConsoleOptionsText;
  String get cnWConsoleOptionsText => _cnWConsoleOptionsText ?? '';
  bool hasCnWConsoleOptionsText() => _cnWConsoleOptionsText != null;

  // "CnWConsoleOptionsPicsURL" field.
  List<String>? _cnWConsoleOptionsPicsURL;
  List<String> get cnWConsoleOptionsPicsURL =>
      _cnWConsoleOptionsPicsURL ?? const [];
  bool hasCnWConsoleOptionsPicsURL() => _cnWConsoleOptionsPicsURL != null;

  // "CnWWSSN" field.
  String? _cnWWSSN;
  String get cnWWSSN => _cnWWSSN ?? '';
  bool hasCnWWSSN() => _cnWWSSN != null;

  // "CnWWSSW" field.
  String? _cnWWSSW;
  String get cnWWSSW => _cnWWSSW ?? '';
  bool hasCnWWSSW() => _cnWWSSW != null;

  // "CnWWSOptionsText" field.
  String? _cnWWSOptionsText;
  String get cnWWSOptionsText => _cnWWSOptionsText ?? '';
  bool hasCnWWSOptionsText() => _cnWWSOptionsText != null;

  // "CnWWSOptionsPicsURL" field.
  List<String>? _cnWWSOptionsPicsURL;
  List<String> get cnWWSOptionsPicsURL => _cnWWSOptionsPicsURL ?? const [];
  bool hasCnWWSOptionsPicsURL() => _cnWWSOptionsPicsURL != null;

  // "CnWCDAvailable" field.
  String? _cnWCDAvailable;
  String get cnWCDAvailable => _cnWCDAvailable ?? '';
  bool hasCnWCDAvailable() => _cnWCDAvailable != null;

  // "LocalSMeasSettings" field.
  String? _localSMeasSettings;
  String get localSMeasSettings => _localSMeasSettings ?? '';
  bool hasLocalSMeasSettings() => _localSMeasSettings != null;

  // "LocalSTuneUpPage" field.
  String? _localSTuneUpPage;
  String get localSTuneUpPage => _localSTuneUpPage ?? '';
  bool hasLocalSTuneUpPage() => _localSTuneUpPage != null;

  // "LocalSQA" field.
  String? _localSQA;
  String get localSQA => _localSQA ?? '';
  bool hasLocalSQA() => _localSQA != null;

  // "LocalSMagnetStatus" field.
  String? _localSMagnetStatus;
  String get localSMagnetStatus => _localSMagnetStatus ?? '';
  bool hasLocalSMagnetStatus() => _localSMagnetStatus != null;

  // "LocalSCoolingSPage" field.
  String? _localSCoolingSPage;
  String get localSCoolingSPage => _localSCoolingSPage ?? '';
  bool hasLocalSCoolingSPage() => _localSCoolingSPage != null;

  // "LocalSQASpikeTestDate" field.
  String? _localSQASpikeTestDate;
  String get localSQASpikeTestDate => _localSQASpikeTestDate ?? '';
  bool hasLocalSQASpikeTestDate() => _localSQASpikeTestDate != null;

  // "LocalSQASpikeTestOK" field.
  String? _localSQASpikeTestOK;
  String get localSQASpikeTestOK => _localSQASpikeTestOK ?? '';
  bool hasLocalSQASpikeTestOK() => _localSQASpikeTestOK != null;

  // "LocalSGeneralQATest" field.
  String? _localSGeneralQATest;
  String get localSGeneralQATest => _localSGeneralQATest ?? '';
  bool hasLocalSGeneralQATest() => _localSGeneralQATest != null;

  // "Coil1SN" field.
  String? _coil1SN;
  String get coil1SN => _coil1SN ?? '';
  bool hasCoil1SN() => _coil1SN != null;

  // "Coil2SN" field.
  String? _coil2SN;
  String get coil2SN => _coil2SN ?? '';
  bool hasCoil2SN() => _coil2SN != null;

  // "Coil3SN" field.
  String? _coil3SN;
  String get coil3SN => _coil3SN ?? '';
  bool hasCoil3SN() => _coil3SN != null;

  // "Coil4SN" field.
  String? _coil4SN;
  String get coil4SN => _coil4SN ?? '';
  bool hasCoil4SN() => _coil4SN != null;

  // "Coil5SN" field.
  String? _coil5SN;
  String get coil5SN => _coil5SN ?? '';
  bool hasCoil5SN() => _coil5SN != null;

  // "Coil6SN" field.
  String? _coil6SN;
  String get coil6SN => _coil6SN ?? '';
  bool hasCoil6SN() => _coil6SN != null;

  // "Coil7SN" field.
  String? _coil7SN;
  String get coil7SN => _coil7SN ?? '';
  bool hasCoil7SN() => _coil7SN != null;

  // "Coil8SN" field.
  String? _coil8SN;
  String get coil8SN => _coil8SN ?? '';
  bool hasCoil8SN() => _coil8SN != null;

  // "Coil1YOM" field.
  String? _coil1YOM;
  String get coil1YOM => _coil1YOM ?? '';
  bool hasCoil1YOM() => _coil1YOM != null;

  // "Coil2YOM" field.
  String? _coil2YOM;
  String get coil2YOM => _coil2YOM ?? '';
  bool hasCoil2YOM() => _coil2YOM != null;

  // "Coil3YOM" field.
  String? _coil3YOM;
  String get coil3YOM => _coil3YOM ?? '';
  bool hasCoil3YOM() => _coil3YOM != null;

  // "Coil4YOM" field.
  String? _coil4YOM;
  String get coil4YOM => _coil4YOM ?? '';
  bool hasCoil4YOM() => _coil4YOM != null;

  // "Coil5YOM" field.
  String? _coil5YOM;
  String get coil5YOM => _coil5YOM ?? '';
  bool hasCoil5YOM() => _coil5YOM != null;

  // "Coil6YOM" field.
  String? _coil6YOM;
  String get coil6YOM => _coil6YOM ?? '';
  bool hasCoil6YOM() => _coil6YOM != null;

  // "Coil7YOM" field.
  String? _coil7YOM;
  String get coil7YOM => _coil7YOM ?? '';
  bool hasCoil7YOM() => _coil7YOM != null;

  // "Coil8YOM" field.
  String? _coil8YOM;
  String get coil8YOM => _coil8YOM ?? '';
  bool hasCoil8YOM() => _coil8YOM != null;

  // "Coil1QACheck" field.
  String? _coil1QACheck;
  String get coil1QACheck => _coil1QACheck ?? '';
  bool hasCoil1QACheck() => _coil1QACheck != null;

  // "Coil2QACheck" field.
  String? _coil2QACheck;
  String get coil2QACheck => _coil2QACheck ?? '';
  bool hasCoil2QACheck() => _coil2QACheck != null;

  // "Coil3QACheck" field.
  String? _coil3QACheck;
  String get coil3QACheck => _coil3QACheck ?? '';
  bool hasCoil3QACheck() => _coil3QACheck != null;

  // "Coil4QACheck" field.
  String? _coil4QACheck;
  String get coil4QACheck => _coil4QACheck ?? '';
  bool hasCoil4QACheck() => _coil4QACheck != null;

  // "Coil5QACheck" field.
  String? _coil5QACheck;
  String get coil5QACheck => _coil5QACheck ?? '';
  bool hasCoil5QACheck() => _coil5QACheck != null;

  // "Coil6QACheck" field.
  String? _coil6QACheck;
  String get coil6QACheck => _coil6QACheck ?? '';
  bool hasCoil6QACheck() => _coil6QACheck != null;

  // "Coil7QACheck" field.
  String? _coil7QACheck;
  String get coil7QACheck => _coil7QACheck ?? '';
  bool hasCoil7QACheck() => _coil7QACheck != null;

  // "Coil8QACheck" field.
  String? _coil8QACheck;
  String get coil8QACheck => _coil8QACheck ?? '';
  bool hasCoil8QACheck() => _coil8QACheck != null;

  // "AccPhantom1Model" field.
  String? _accPhantom1Model;
  String get accPhantom1Model => _accPhantom1Model ?? '';
  bool hasAccPhantom1Model() => _accPhantom1Model != null;

  // "AccPhantom2Model" field.
  String? _accPhantom2Model;
  String get accPhantom2Model => _accPhantom2Model ?? '';
  bool hasAccPhantom2Model() => _accPhantom2Model != null;

  // "AccPhantom3Model" field.
  String? _accPhantom3Model;
  String get accPhantom3Model => _accPhantom3Model ?? '';
  bool hasAccPhantom3Model() => _accPhantom3Model != null;

  // "AccPhantom1ModelNo" field.
  String? _accPhantom1ModelNo;
  String get accPhantom1ModelNo => _accPhantom1ModelNo ?? '';
  bool hasAccPhantom1ModelNo() => _accPhantom1ModelNo != null;

  // "AccPhantom2ModelNo" field.
  String? _accPhantom2ModelNo;
  String get accPhantom2ModelNo => _accPhantom2ModelNo ?? '';
  bool hasAccPhantom2ModelNo() => _accPhantom2ModelNo != null;

  // "AccPhantom3ModelNo" field.
  String? _accPhantom3ModelNo;
  String get accPhantom3ModelNo => _accPhantom3ModelNo ?? '';
  bool hasAccPhantom3ModelNo() => _accPhantom3ModelNo != null;

  // "AccPhantom1ModelSN" field.
  String? _accPhantom1ModelSN;
  String get accPhantom1ModelSN => _accPhantom1ModelSN ?? '';
  bool hasAccPhantom1ModelSN() => _accPhantom1ModelSN != null;

  // "AccPhantom2ModelSN" field.
  String? _accPhantom2ModelSN;
  String get accPhantom2ModelSN => _accPhantom2ModelSN ?? '';
  bool hasAccPhantom2ModelSN() => _accPhantom2ModelSN != null;

  // "AccPhantom3ModelSN" field.
  String? _accPhantom3ModelSN;
  String get accPhantom3ModelSN => _accPhantom3ModelSN ?? '';
  bool hasAccPhantom3ModelSN() => _accPhantom3ModelSN != null;

  // "AccInjector" field.
  String? _accInjector;
  String get accInjector => _accInjector ?? '';
  bool hasAccInjector() => _accInjector != null;

  // "AccSpareParts" field.
  String? _accSpareParts;
  String get accSpareParts => _accSpareParts ?? '';
  bool hasAccSpareParts() => _accSpareParts != null;

  // "AccSmokeDet" field.
  String? _accSmokeDet;
  String get accSmokeDet => _accSmokeDet ?? '';
  bool hasAccSmokeDet() => _accSmokeDet != null;

  // "AccSqueezeBall" field.
  String? _accSqueezeBall;
  String get accSqueezeBall => _accSqueezeBall ?? '';
  bool hasAccSqueezeBall() => _accSqueezeBall != null;

  // "AccHeadphone" field.
  String? _accHeadphone;
  String get accHeadphone => _accHeadphone ?? '';
  bool hasAccHeadphone() => _accHeadphone != null;

  // "AccMagnetSpareBag" field.
  String? _accMagnetSpareBag;
  String get accMagnetSpareBag => _accMagnetSpareBag ?? '';
  bool hasAccMagnetSpareBag() => _accMagnetSpareBag != null;

  // "CosmeticCondition" field.
  String? _cosmeticCondition;
  String get cosmeticCondition => _cosmeticCondition ?? '';
  bool hasCosmeticCondition() => _cosmeticCondition != null;

  // "DnTAddress" field.
  String? _dnTAddress;
  String get dnTAddress => _dnTAddress ?? '';
  bool hasDnTAddress() => _dnTAddress != null;

  // "DntFloor" field.
  String? _dntFloor;
  String get dntFloor => _dntFloor ?? '';
  bool hasDntFloor() => _dntFloor != null;

  // "DntDoors" field.
  String? _dntDoors;
  String get dntDoors => _dntDoors ?? '';
  bool hasDntDoors() => _dntDoors != null;

  // "DntDockAvailable" field.
  String? _dntDockAvailable;
  String get dntDockAvailable => _dntDockAvailable ?? '';
  bool hasDntDockAvailable() => _dntDockAvailable != null;

  // "DntNeedOfCrane" field.
  String? _dntNeedOfCrane;
  String get dntNeedOfCrane => _dntNeedOfCrane ?? '';
  bool hasDntNeedOfCrane() => _dntNeedOfCrane != null;

  // "DntTools" field.
  String? _dntTools;
  String get dntTools => _dntTools ?? '';
  bool hasDntTools() => _dntTools != null;

  // "DntSpecialAttention" field.
  String? _dntSpecialAttention;
  String get dntSpecialAttention => _dntSpecialAttention ?? '';
  bool hasDntSpecialAttention() => _dntSpecialAttention != null;

  // "OtherNotes" field.
  String? _otherNotes;
  String get otherNotes => _otherNotes ?? '';
  bool hasOtherNotes() => _otherNotes != null;

  // "ICSCabinetActive" field.
  String? _iCSCabinetActive;
  String get iCSCabinetActive => _iCSCabinetActive ?? '';
  bool hasICSCabinetActive() => _iCSCabinetActive != null;

  // "userID" field.
  String? _userID;
  String get userID => _userID ?? '';
  bool hasUserID() => _userID != null;

  // "SysGenDocName" field.
  String? _sysGenDocName;
  String get sysGenDocName => _sysGenDocName ?? '';
  bool hasSysGenDocName() => _sysGenDocName != null;

  // "Coil1Model" field.
  String? _coil1Model;
  String get coil1Model => _coil1Model ?? '';
  bool hasCoil1Model() => _coil1Model != null;

  // "Coil2Model" field.
  String? _coil2Model;
  String get coil2Model => _coil2Model ?? '';
  bool hasCoil2Model() => _coil2Model != null;

  // "Coil3Model" field.
  String? _coil3Model;
  String get coil3Model => _coil3Model ?? '';
  bool hasCoil3Model() => _coil3Model != null;

  // "Coil4Model" field.
  String? _coil4Model;
  String get coil4Model => _coil4Model ?? '';
  bool hasCoil4Model() => _coil4Model != null;

  // "Coil5Model" field.
  String? _coil5Model;
  String get coil5Model => _coil5Model ?? '';
  bool hasCoil5Model() => _coil5Model != null;

  // "Coil6Model" field.
  String? _coil6Model;
  String get coil6Model => _coil6Model ?? '';
  bool hasCoil6Model() => _coil6Model != null;

  // "Coil7Model" field.
  String? _coil7Model;
  String get coil7Model => _coil7Model ?? '';
  bool hasCoil7Model() => _coil7Model != null;

  // "Coil8Model" field.
  String? _coil8Model;
  String get coil8Model => _coil8Model ?? '';
  bool hasCoil8Model() => _coil8Model != null;

  // "ColdHeadModel" field.
  String? _coldHeadModel;
  String get coldHeadModel => _coldHeadModel ?? '';
  bool hasColdHeadModel() => _coldHeadModel != null;

  // "ColdHeadLastR" field.
  String? _coldHeadLastR;
  String get coldHeadLastR => _coldHeadLastR ?? '';
  bool hasColdHeadLastR() => _coldHeadLastR != null;

  // "CosmeticText" field.
  String? _cosmeticText;
  String get cosmeticText => _cosmeticText ?? '';
  bool hasCosmeticText() => _cosmeticText != null;

  // "CosmeticPicURL" field.
  List<String>? _cosmeticPicURL;
  List<String> get cosmeticPicURL => _cosmeticPicURL ?? const [];
  bool hasCosmeticPicURL() => _cosmeticPicURL != null;

  // "OtherNotesPhotosURL" field.
  List<String>? _otherNotesPhotosURL;
  List<String> get otherNotesPhotosURL => _otherNotesPhotosURL ?? const [];
  bool hasOtherNotesPhotosURL() => _otherNotesPhotosURL != null;

  // "DeviceImg" field.
  List<String>? _deviceImg;
  List<String> get deviceImg => _deviceImg ?? const [];
  bool hasDeviceImg() => _deviceImg != null;

  void _initializeFields() {
    _sysGenModal = snapshotData['SysGenModal'] as String?;
    _sysGenBrand = snapshotData['SysGenBrand'] as String?;
    _sysGenSN = snapshotData['SysGenSN'] as String?;
    _sysGenYOM = snapshotData['SysGenYOM'] as String?;
    _magnetYOM = snapshotData['MagnetYOM'] as String?;
    _magnetModel = snapshotData['MagnetModel'] as String?;
    _magnetSN = snapshotData['MagnetSN'] as String?;
    _magnetPressure = snapshotData['MagnetPressure'] as String?;
    _magnetShieldTemp = snapshotData['MagnetShieldTemp'] as String?;
    _magnetHELevel = snapshotData['MagnetHELevel'] as String?;
    _coolerCompModel = snapshotData['CoolerCompModel'] as String?;
    _coolerCompYOM = snapshotData['CoolerCompYOM'] as String?;
    _coolerCompHours = snapshotData['CoolerCompHours'] as String?;
    _coolerCompPressure = snapshotData['CoolerCompPressure'] as String?;
    _coolerCompLAR = snapshotData['CoolerCompLAR'] as String?;
    _imagerModel = snapshotData['ImagerModel'] as String?;
    _imagerModelSN = snapshotData['ImagerModelSN'] as String?;
    _imagerDVStarModel = snapshotData['ImagerDVStarModel'] as String?;
    _imagerDVStarSN = snapshotData['ImagerDVStarSN'] as String?;
    _imagerPCIRX1Model = snapshotData['ImagerPCIRX1Model'] as String?;
    _imagerPCIRX1ModelSN = snapshotData['ImagerPCIRX1ModelSN'] as String?;
    _imagerPCIRX2Model = snapshotData['ImagerPCIRX2Model'] as String?;
    _imagerPCIRX2ModelSN = snapshotData['ImagerPCIRX2ModelSN'] as String?;
    _eCGModel = snapshotData['ECGModel'] as String?;
    _ecgsn = snapshotData['ECGSN'] as String?;
    _eCGFuncChecked = snapshotData['ECGFuncChecked'] as String?;
    _powerStages1SN = snapshotData['PowerStages1SN'] as String?;
    _powerStages2SN = snapshotData['PowerStages2SN'] as String?;
    _powerStages3SN = snapshotData['PowerStages3SN'] as String?;
    _talesLastReplacement = snapshotData['TalesLastReplacement'] as String?;
    _patientTableModel = snapshotData['PatientTableModel'] as String?;
    _patientTableSN = snapshotData['PatientTableSN'] as String?;
    _patientTableMoveTests = snapshotData['PatientTableMoveTests'] as String?;
    _cnWConsoleSN = snapshotData['CnWConsoleSN'] as String?;
    _cnWConsoleSW = snapshotData['CnWConsoleSW'] as String?;
    _cnWConsoleOptionsText = snapshotData['CnWConsoleOptionsText'] as String?;
    _cnWConsoleOptionsPicsURL =
        getDataList(snapshotData['CnWConsoleOptionsPicsURL']);
    _cnWWSSN = snapshotData['CnWWSSN'] as String?;
    _cnWWSSW = snapshotData['CnWWSSW'] as String?;
    _cnWWSOptionsText = snapshotData['CnWWSOptionsText'] as String?;
    _cnWWSOptionsPicsURL = getDataList(snapshotData['CnWWSOptionsPicsURL']);
    _cnWCDAvailable = snapshotData['CnWCDAvailable'] as String?;
    _localSMeasSettings = snapshotData['LocalSMeasSettings'] as String?;
    _localSTuneUpPage = snapshotData['LocalSTuneUpPage'] as String?;
    _localSQA = snapshotData['LocalSQA'] as String?;
    _localSMagnetStatus = snapshotData['LocalSMagnetStatus'] as String?;
    _localSCoolingSPage = snapshotData['LocalSCoolingSPage'] as String?;
    _localSQASpikeTestDate = snapshotData['LocalSQASpikeTestDate'] as String?;
    _localSQASpikeTestOK = snapshotData['LocalSQASpikeTestOK'] as String?;
    _localSGeneralQATest = snapshotData['LocalSGeneralQATest'] as String?;
    _coil1SN = snapshotData['Coil1SN'] as String?;
    _coil2SN = snapshotData['Coil2SN'] as String?;
    _coil3SN = snapshotData['Coil3SN'] as String?;
    _coil4SN = snapshotData['Coil4SN'] as String?;
    _coil5SN = snapshotData['Coil5SN'] as String?;
    _coil6SN = snapshotData['Coil6SN'] as String?;
    _coil7SN = snapshotData['Coil7SN'] as String?;
    _coil8SN = snapshotData['Coil8SN'] as String?;
    _coil1YOM = snapshotData['Coil1YOM'] as String?;
    _coil2YOM = snapshotData['Coil2YOM'] as String?;
    _coil3YOM = snapshotData['Coil3YOM'] as String?;
    _coil4YOM = snapshotData['Coil4YOM'] as String?;
    _coil5YOM = snapshotData['Coil5YOM'] as String?;
    _coil6YOM = snapshotData['Coil6YOM'] as String?;
    _coil7YOM = snapshotData['Coil7YOM'] as String?;
    _coil8YOM = snapshotData['Coil8YOM'] as String?;
    _coil1QACheck = snapshotData['Coil1QACheck'] as String?;
    _coil2QACheck = snapshotData['Coil2QACheck'] as String?;
    _coil3QACheck = snapshotData['Coil3QACheck'] as String?;
    _coil4QACheck = snapshotData['Coil4QACheck'] as String?;
    _coil5QACheck = snapshotData['Coil5QACheck'] as String?;
    _coil6QACheck = snapshotData['Coil6QACheck'] as String?;
    _coil7QACheck = snapshotData['Coil7QACheck'] as String?;
    _coil8QACheck = snapshotData['Coil8QACheck'] as String?;
    _accPhantom1Model = snapshotData['AccPhantom1Model'] as String?;
    _accPhantom2Model = snapshotData['AccPhantom2Model'] as String?;
    _accPhantom3Model = snapshotData['AccPhantom3Model'] as String?;
    _accPhantom1ModelNo = snapshotData['AccPhantom1ModelNo'] as String?;
    _accPhantom2ModelNo = snapshotData['AccPhantom2ModelNo'] as String?;
    _accPhantom3ModelNo = snapshotData['AccPhantom3ModelNo'] as String?;
    _accPhantom1ModelSN = snapshotData['AccPhantom1ModelSN'] as String?;
    _accPhantom2ModelSN = snapshotData['AccPhantom2ModelSN'] as String?;
    _accPhantom3ModelSN = snapshotData['AccPhantom3ModelSN'] as String?;
    _accInjector = snapshotData['AccInjector'] as String?;
    _accSpareParts = snapshotData['AccSpareParts'] as String?;
    _accSmokeDet = snapshotData['AccSmokeDet'] as String?;
    _accSqueezeBall = snapshotData['AccSqueezeBall'] as String?;
    _accHeadphone = snapshotData['AccHeadphone'] as String?;
    _accMagnetSpareBag = snapshotData['AccMagnetSpareBag'] as String?;
    _cosmeticCondition = snapshotData['CosmeticCondition'] as String?;
    _dnTAddress = snapshotData['DnTAddress'] as String?;
    _dntFloor = snapshotData['DntFloor'] as String?;
    _dntDoors = snapshotData['DntDoors'] as String?;
    _dntDockAvailable = snapshotData['DntDockAvailable'] as String?;
    _dntNeedOfCrane = snapshotData['DntNeedOfCrane'] as String?;
    _dntTools = snapshotData['DntTools'] as String?;
    _dntSpecialAttention = snapshotData['DntSpecialAttention'] as String?;
    _otherNotes = snapshotData['OtherNotes'] as String?;
    _iCSCabinetActive = snapshotData['ICSCabinetActive'] as String?;
    _userID = snapshotData['userID'] as String?;
    _sysGenDocName = snapshotData['SysGenDocName'] as String?;
    _coil1Model = snapshotData['Coil1Model'] as String?;
    _coil2Model = snapshotData['Coil2Model'] as String?;
    _coil3Model = snapshotData['Coil3Model'] as String?;
    _coil4Model = snapshotData['Coil4Model'] as String?;
    _coil5Model = snapshotData['Coil5Model'] as String?;
    _coil6Model = snapshotData['Coil6Model'] as String?;
    _coil7Model = snapshotData['Coil7Model'] as String?;
    _coil8Model = snapshotData['Coil8Model'] as String?;
    _coldHeadModel = snapshotData['ColdHeadModel'] as String?;
    _coldHeadLastR = snapshotData['ColdHeadLastR'] as String?;
    _cosmeticText = snapshotData['CosmeticText'] as String?;
    _cosmeticPicURL = getDataList(snapshotData['CosmeticPicURL']);
    _otherNotesPhotosURL = getDataList(snapshotData['OtherNotesPhotosURL']);
    _deviceImg = getDataList(snapshotData['DeviceImg']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('MRI');

  static Stream<MriRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MriRecord.fromSnapshot(s));

  static Future<MriRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MriRecord.fromSnapshot(s));

  static MriRecord fromSnapshot(DocumentSnapshot snapshot) => MriRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MriRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MriRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MriRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MriRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMriRecordData({
  String? sysGenModal,
  String? sysGenBrand,
  String? sysGenSN,
  String? sysGenYOM,
  String? magnetYOM,
  String? magnetModel,
  String? magnetSN,
  String? magnetPressure,
  String? magnetShieldTemp,
  String? magnetHELevel,
  String? coolerCompModel,
  String? coolerCompYOM,
  String? coolerCompHours,
  String? coolerCompPressure,
  String? coolerCompLAR,
  String? imagerModel,
  String? imagerModelSN,
  String? imagerDVStarModel,
  String? imagerDVStarSN,
  String? imagerPCIRX1Model,
  String? imagerPCIRX1ModelSN,
  String? imagerPCIRX2Model,
  String? imagerPCIRX2ModelSN,
  String? eCGModel,
  String? ecgsn,
  String? eCGFuncChecked,
  String? powerStages1SN,
  String? powerStages2SN,
  String? powerStages3SN,
  String? talesLastReplacement,
  String? patientTableModel,
  String? patientTableSN,
  String? patientTableMoveTests,
  String? cnWConsoleSN,
  String? cnWConsoleSW,
  String? cnWConsoleOptionsText,
  String? cnWWSSN,
  String? cnWWSSW,
  String? cnWWSOptionsText,
  String? cnWCDAvailable,
  String? localSMeasSettings,
  String? localSTuneUpPage,
  String? localSQA,
  String? localSMagnetStatus,
  String? localSCoolingSPage,
  String? localSQASpikeTestDate,
  String? localSQASpikeTestOK,
  String? localSGeneralQATest,
  String? coil1SN,
  String? coil2SN,
  String? coil3SN,
  String? coil4SN,
  String? coil5SN,
  String? coil6SN,
  String? coil7SN,
  String? coil8SN,
  String? coil1YOM,
  String? coil2YOM,
  String? coil3YOM,
  String? coil4YOM,
  String? coil5YOM,
  String? coil6YOM,
  String? coil7YOM,
  String? coil8YOM,
  String? coil1QACheck,
  String? coil2QACheck,
  String? coil3QACheck,
  String? coil4QACheck,
  String? coil5QACheck,
  String? coil6QACheck,
  String? coil7QACheck,
  String? coil8QACheck,
  String? accPhantom1Model,
  String? accPhantom2Model,
  String? accPhantom3Model,
  String? accPhantom1ModelNo,
  String? accPhantom2ModelNo,
  String? accPhantom3ModelNo,
  String? accPhantom1ModelSN,
  String? accPhantom2ModelSN,
  String? accPhantom3ModelSN,
  String? accInjector,
  String? accSpareParts,
  String? accSmokeDet,
  String? accSqueezeBall,
  String? accHeadphone,
  String? accMagnetSpareBag,
  String? cosmeticCondition,
  String? dnTAddress,
  String? dntFloor,
  String? dntDoors,
  String? dntDockAvailable,
  String? dntNeedOfCrane,
  String? dntTools,
  String? dntSpecialAttention,
  String? otherNotes,
  String? iCSCabinetActive,
  String? userID,
  String? sysGenDocName,
  String? coil1Model,
  String? coil2Model,
  String? coil3Model,
  String? coil4Model,
  String? coil5Model,
  String? coil6Model,
  String? coil7Model,
  String? coil8Model,
  String? coldHeadModel,
  String? coldHeadLastR,
  String? cosmeticText,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'SysGenModal': sysGenModal,
      'SysGenBrand': sysGenBrand,
      'SysGenSN': sysGenSN,
      'SysGenYOM': sysGenYOM,
      'MagnetYOM': magnetYOM,
      'MagnetModel': magnetModel,
      'MagnetSN': magnetSN,
      'MagnetPressure': magnetPressure,
      'MagnetShieldTemp': magnetShieldTemp,
      'MagnetHELevel': magnetHELevel,
      'CoolerCompModel': coolerCompModel,
      'CoolerCompYOM': coolerCompYOM,
      'CoolerCompHours': coolerCompHours,
      'CoolerCompPressure': coolerCompPressure,
      'CoolerCompLAR': coolerCompLAR,
      'ImagerModel': imagerModel,
      'ImagerModelSN': imagerModelSN,
      'ImagerDVStarModel': imagerDVStarModel,
      'ImagerDVStarSN': imagerDVStarSN,
      'ImagerPCIRX1Model': imagerPCIRX1Model,
      'ImagerPCIRX1ModelSN': imagerPCIRX1ModelSN,
      'ImagerPCIRX2Model': imagerPCIRX2Model,
      'ImagerPCIRX2ModelSN': imagerPCIRX2ModelSN,
      'ECGModel': eCGModel,
      'ECGSN': ecgsn,
      'ECGFuncChecked': eCGFuncChecked,
      'PowerStages1SN': powerStages1SN,
      'PowerStages2SN': powerStages2SN,
      'PowerStages3SN': powerStages3SN,
      'TalesLastReplacement': talesLastReplacement,
      'PatientTableModel': patientTableModel,
      'PatientTableSN': patientTableSN,
      'PatientTableMoveTests': patientTableMoveTests,
      'CnWConsoleSN': cnWConsoleSN,
      'CnWConsoleSW': cnWConsoleSW,
      'CnWConsoleOptionsText': cnWConsoleOptionsText,
      'CnWWSSN': cnWWSSN,
      'CnWWSSW': cnWWSSW,
      'CnWWSOptionsText': cnWWSOptionsText,
      'CnWCDAvailable': cnWCDAvailable,
      'LocalSMeasSettings': localSMeasSettings,
      'LocalSTuneUpPage': localSTuneUpPage,
      'LocalSQA': localSQA,
      'LocalSMagnetStatus': localSMagnetStatus,
      'LocalSCoolingSPage': localSCoolingSPage,
      'LocalSQASpikeTestDate': localSQASpikeTestDate,
      'LocalSQASpikeTestOK': localSQASpikeTestOK,
      'LocalSGeneralQATest': localSGeneralQATest,
      'Coil1SN': coil1SN,
      'Coil2SN': coil2SN,
      'Coil3SN': coil3SN,
      'Coil4SN': coil4SN,
      'Coil5SN': coil5SN,
      'Coil6SN': coil6SN,
      'Coil7SN': coil7SN,
      'Coil8SN': coil8SN,
      'Coil1YOM': coil1YOM,
      'Coil2YOM': coil2YOM,
      'Coil3YOM': coil3YOM,
      'Coil4YOM': coil4YOM,
      'Coil5YOM': coil5YOM,
      'Coil6YOM': coil6YOM,
      'Coil7YOM': coil7YOM,
      'Coil8YOM': coil8YOM,
      'Coil1QACheck': coil1QACheck,
      'Coil2QACheck': coil2QACheck,
      'Coil3QACheck': coil3QACheck,
      'Coil4QACheck': coil4QACheck,
      'Coil5QACheck': coil5QACheck,
      'Coil6QACheck': coil6QACheck,
      'Coil7QACheck': coil7QACheck,
      'Coil8QACheck': coil8QACheck,
      'AccPhantom1Model': accPhantom1Model,
      'AccPhantom2Model': accPhantom2Model,
      'AccPhantom3Model': accPhantom3Model,
      'AccPhantom1ModelNo': accPhantom1ModelNo,
      'AccPhantom2ModelNo': accPhantom2ModelNo,
      'AccPhantom3ModelNo': accPhantom3ModelNo,
      'AccPhantom1ModelSN': accPhantom1ModelSN,
      'AccPhantom2ModelSN': accPhantom2ModelSN,
      'AccPhantom3ModelSN': accPhantom3ModelSN,
      'AccInjector': accInjector,
      'AccSpareParts': accSpareParts,
      'AccSmokeDet': accSmokeDet,
      'AccSqueezeBall': accSqueezeBall,
      'AccHeadphone': accHeadphone,
      'AccMagnetSpareBag': accMagnetSpareBag,
      'CosmeticCondition': cosmeticCondition,
      'DnTAddress': dnTAddress,
      'DntFloor': dntFloor,
      'DntDoors': dntDoors,
      'DntDockAvailable': dntDockAvailable,
      'DntNeedOfCrane': dntNeedOfCrane,
      'DntTools': dntTools,
      'DntSpecialAttention': dntSpecialAttention,
      'OtherNotes': otherNotes,
      'ICSCabinetActive': iCSCabinetActive,
      'userID': userID,
      'SysGenDocName': sysGenDocName,
      'Coil1Model': coil1Model,
      'Coil2Model': coil2Model,
      'Coil3Model': coil3Model,
      'Coil4Model': coil4Model,
      'Coil5Model': coil5Model,
      'Coil6Model': coil6Model,
      'Coil7Model': coil7Model,
      'Coil8Model': coil8Model,
      'ColdHeadModel': coldHeadModel,
      'ColdHeadLastR': coldHeadLastR,
      'CosmeticText': cosmeticText,
    }.withoutNulls,
  );

  return firestoreData;
}

class MriRecordDocumentEquality implements Equality<MriRecord> {
  const MriRecordDocumentEquality();

  @override
  bool equals(MriRecord? e1, MriRecord? e2) {
    const listEquality = ListEquality();
    return e1?.sysGenModal == e2?.sysGenModal &&
        e1?.sysGenBrand == e2?.sysGenBrand &&
        e1?.sysGenSN == e2?.sysGenSN &&
        e1?.sysGenYOM == e2?.sysGenYOM &&
        e1?.magnetYOM == e2?.magnetYOM &&
        e1?.magnetModel == e2?.magnetModel &&
        e1?.magnetSN == e2?.magnetSN &&
        e1?.magnetPressure == e2?.magnetPressure &&
        e1?.magnetShieldTemp == e2?.magnetShieldTemp &&
        e1?.magnetHELevel == e2?.magnetHELevel &&
        e1?.coolerCompModel == e2?.coolerCompModel &&
        e1?.coolerCompYOM == e2?.coolerCompYOM &&
        e1?.coolerCompHours == e2?.coolerCompHours &&
        e1?.coolerCompPressure == e2?.coolerCompPressure &&
        e1?.coolerCompLAR == e2?.coolerCompLAR &&
        e1?.imagerModel == e2?.imagerModel &&
        e1?.imagerModelSN == e2?.imagerModelSN &&
        e1?.imagerDVStarModel == e2?.imagerDVStarModel &&
        e1?.imagerDVStarSN == e2?.imagerDVStarSN &&
        e1?.imagerPCIRX1Model == e2?.imagerPCIRX1Model &&
        e1?.imagerPCIRX1ModelSN == e2?.imagerPCIRX1ModelSN &&
        e1?.imagerPCIRX2Model == e2?.imagerPCIRX2Model &&
        e1?.imagerPCIRX2ModelSN == e2?.imagerPCIRX2ModelSN &&
        e1?.eCGModel == e2?.eCGModel &&
        e1?.ecgsn == e2?.ecgsn &&
        e1?.eCGFuncChecked == e2?.eCGFuncChecked &&
        e1?.powerStages1SN == e2?.powerStages1SN &&
        e1?.powerStages2SN == e2?.powerStages2SN &&
        e1?.powerStages3SN == e2?.powerStages3SN &&
        e1?.talesLastReplacement == e2?.talesLastReplacement &&
        e1?.patientTableModel == e2?.patientTableModel &&
        e1?.patientTableSN == e2?.patientTableSN &&
        e1?.patientTableMoveTests == e2?.patientTableMoveTests &&
        e1?.cnWConsoleSN == e2?.cnWConsoleSN &&
        e1?.cnWConsoleSW == e2?.cnWConsoleSW &&
        e1?.cnWConsoleOptionsText == e2?.cnWConsoleOptionsText &&
        listEquality.equals(
            e1?.cnWConsoleOptionsPicsURL, e2?.cnWConsoleOptionsPicsURL) &&
        e1?.cnWWSSN == e2?.cnWWSSN &&
        e1?.cnWWSSW == e2?.cnWWSSW &&
        e1?.cnWWSOptionsText == e2?.cnWWSOptionsText &&
        listEquality.equals(e1?.cnWWSOptionsPicsURL, e2?.cnWWSOptionsPicsURL) &&
        e1?.cnWCDAvailable == e2?.cnWCDAvailable &&
        e1?.localSMeasSettings == e2?.localSMeasSettings &&
        e1?.localSTuneUpPage == e2?.localSTuneUpPage &&
        e1?.localSQA == e2?.localSQA &&
        e1?.localSMagnetStatus == e2?.localSMagnetStatus &&
        e1?.localSCoolingSPage == e2?.localSCoolingSPage &&
        e1?.localSQASpikeTestDate == e2?.localSQASpikeTestDate &&
        e1?.localSQASpikeTestOK == e2?.localSQASpikeTestOK &&
        e1?.localSGeneralQATest == e2?.localSGeneralQATest &&
        e1?.coil1SN == e2?.coil1SN &&
        e1?.coil2SN == e2?.coil2SN &&
        e1?.coil3SN == e2?.coil3SN &&
        e1?.coil4SN == e2?.coil4SN &&
        e1?.coil5SN == e2?.coil5SN &&
        e1?.coil6SN == e2?.coil6SN &&
        e1?.coil7SN == e2?.coil7SN &&
        e1?.coil8SN == e2?.coil8SN &&
        e1?.coil1YOM == e2?.coil1YOM &&
        e1?.coil2YOM == e2?.coil2YOM &&
        e1?.coil3YOM == e2?.coil3YOM &&
        e1?.coil4YOM == e2?.coil4YOM &&
        e1?.coil5YOM == e2?.coil5YOM &&
        e1?.coil6YOM == e2?.coil6YOM &&
        e1?.coil7YOM == e2?.coil7YOM &&
        e1?.coil8YOM == e2?.coil8YOM &&
        e1?.coil1QACheck == e2?.coil1QACheck &&
        e1?.coil2QACheck == e2?.coil2QACheck &&
        e1?.coil3QACheck == e2?.coil3QACheck &&
        e1?.coil4QACheck == e2?.coil4QACheck &&
        e1?.coil5QACheck == e2?.coil5QACheck &&
        e1?.coil6QACheck == e2?.coil6QACheck &&
        e1?.coil7QACheck == e2?.coil7QACheck &&
        e1?.coil8QACheck == e2?.coil8QACheck &&
        e1?.accPhantom1Model == e2?.accPhantom1Model &&
        e1?.accPhantom2Model == e2?.accPhantom2Model &&
        e1?.accPhantom3Model == e2?.accPhantom3Model &&
        e1?.accPhantom1ModelNo == e2?.accPhantom1ModelNo &&
        e1?.accPhantom2ModelNo == e2?.accPhantom2ModelNo &&
        e1?.accPhantom3ModelNo == e2?.accPhantom3ModelNo &&
        e1?.accPhantom1ModelSN == e2?.accPhantom1ModelSN &&
        e1?.accPhantom2ModelSN == e2?.accPhantom2ModelSN &&
        e1?.accPhantom3ModelSN == e2?.accPhantom3ModelSN &&
        e1?.accInjector == e2?.accInjector &&
        e1?.accSpareParts == e2?.accSpareParts &&
        e1?.accSmokeDet == e2?.accSmokeDet &&
        e1?.accSqueezeBall == e2?.accSqueezeBall &&
        e1?.accHeadphone == e2?.accHeadphone &&
        e1?.accMagnetSpareBag == e2?.accMagnetSpareBag &&
        e1?.cosmeticCondition == e2?.cosmeticCondition &&
        e1?.dnTAddress == e2?.dnTAddress &&
        e1?.dntFloor == e2?.dntFloor &&
        e1?.dntDoors == e2?.dntDoors &&
        e1?.dntDockAvailable == e2?.dntDockAvailable &&
        e1?.dntNeedOfCrane == e2?.dntNeedOfCrane &&
        e1?.dntTools == e2?.dntTools &&
        e1?.dntSpecialAttention == e2?.dntSpecialAttention &&
        e1?.otherNotes == e2?.otherNotes &&
        e1?.iCSCabinetActive == e2?.iCSCabinetActive &&
        e1?.userID == e2?.userID &&
        e1?.sysGenDocName == e2?.sysGenDocName &&
        e1?.coil1Model == e2?.coil1Model &&
        e1?.coil2Model == e2?.coil2Model &&
        e1?.coil3Model == e2?.coil3Model &&
        e1?.coil4Model == e2?.coil4Model &&
        e1?.coil5Model == e2?.coil5Model &&
        e1?.coil6Model == e2?.coil6Model &&
        e1?.coil7Model == e2?.coil7Model &&
        e1?.coil8Model == e2?.coil8Model &&
        e1?.coldHeadModel == e2?.coldHeadModel &&
        e1?.coldHeadLastR == e2?.coldHeadLastR &&
        e1?.cosmeticText == e2?.cosmeticText &&
        listEquality.equals(e1?.cosmeticPicURL, e2?.cosmeticPicURL) &&
        listEquality.equals(e1?.otherNotesPhotosURL, e2?.otherNotesPhotosURL) &&
        listEquality.equals(e1?.deviceImg, e2?.deviceImg);
  }

  @override
  int hash(MriRecord? e) => const ListEquality().hash([
        e?.sysGenModal,
        e?.sysGenBrand,
        e?.sysGenSN,
        e?.sysGenYOM,
        e?.magnetYOM,
        e?.magnetModel,
        e?.magnetSN,
        e?.magnetPressure,
        e?.magnetShieldTemp,
        e?.magnetHELevel,
        e?.coolerCompModel,
        e?.coolerCompYOM,
        e?.coolerCompHours,
        e?.coolerCompPressure,
        e?.coolerCompLAR,
        e?.imagerModel,
        e?.imagerModelSN,
        e?.imagerDVStarModel,
        e?.imagerDVStarSN,
        e?.imagerPCIRX1Model,
        e?.imagerPCIRX1ModelSN,
        e?.imagerPCIRX2Model,
        e?.imagerPCIRX2ModelSN,
        e?.eCGModel,
        e?.ecgsn,
        e?.eCGFuncChecked,
        e?.powerStages1SN,
        e?.powerStages2SN,
        e?.powerStages3SN,
        e?.talesLastReplacement,
        e?.patientTableModel,
        e?.patientTableSN,
        e?.patientTableMoveTests,
        e?.cnWConsoleSN,
        e?.cnWConsoleSW,
        e?.cnWConsoleOptionsText,
        e?.cnWConsoleOptionsPicsURL,
        e?.cnWWSSN,
        e?.cnWWSSW,
        e?.cnWWSOptionsText,
        e?.cnWWSOptionsPicsURL,
        e?.cnWCDAvailable,
        e?.localSMeasSettings,
        e?.localSTuneUpPage,
        e?.localSQA,
        e?.localSMagnetStatus,
        e?.localSCoolingSPage,
        e?.localSQASpikeTestDate,
        e?.localSQASpikeTestOK,
        e?.localSGeneralQATest,
        e?.coil1SN,
        e?.coil2SN,
        e?.coil3SN,
        e?.coil4SN,
        e?.coil5SN,
        e?.coil6SN,
        e?.coil7SN,
        e?.coil8SN,
        e?.coil1YOM,
        e?.coil2YOM,
        e?.coil3YOM,
        e?.coil4YOM,
        e?.coil5YOM,
        e?.coil6YOM,
        e?.coil7YOM,
        e?.coil8YOM,
        e?.coil1QACheck,
        e?.coil2QACheck,
        e?.coil3QACheck,
        e?.coil4QACheck,
        e?.coil5QACheck,
        e?.coil6QACheck,
        e?.coil7QACheck,
        e?.coil8QACheck,
        e?.accPhantom1Model,
        e?.accPhantom2Model,
        e?.accPhantom3Model,
        e?.accPhantom1ModelNo,
        e?.accPhantom2ModelNo,
        e?.accPhantom3ModelNo,
        e?.accPhantom1ModelSN,
        e?.accPhantom2ModelSN,
        e?.accPhantom3ModelSN,
        e?.accInjector,
        e?.accSpareParts,
        e?.accSmokeDet,
        e?.accSqueezeBall,
        e?.accHeadphone,
        e?.accMagnetSpareBag,
        e?.cosmeticCondition,
        e?.dnTAddress,
        e?.dntFloor,
        e?.dntDoors,
        e?.dntDockAvailable,
        e?.dntNeedOfCrane,
        e?.dntTools,
        e?.dntSpecialAttention,
        e?.otherNotes,
        e?.iCSCabinetActive,
        e?.userID,
        e?.sysGenDocName,
        e?.coil1Model,
        e?.coil2Model,
        e?.coil3Model,
        e?.coil4Model,
        e?.coil5Model,
        e?.coil6Model,
        e?.coil7Model,
        e?.coil8Model,
        e?.coldHeadModel,
        e?.coldHeadLastR,
        e?.cosmeticText,
        e?.cosmeticPicURL,
        e?.otherNotesPhotosURL,
        e?.deviceImg
      ]);

  @override
  bool isValidKey(Object? o) => o is MriRecord;
}
