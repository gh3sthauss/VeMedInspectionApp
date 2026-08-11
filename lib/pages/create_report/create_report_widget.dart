import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/logo_widget.dart';
import '/components/modality_icons.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_report_model.dart';
export 'create_report_model.dart';

class CreateReportWidget extends StatefulWidget {
  const CreateReportWidget({super.key});

  static String routeName = 'CreateReport';
  static String routePath = '/createReport';

  @override
  State<CreateReportWidget> createState() => _CreateReportWidgetState();
}

class _CreateReportWidgetState extends State<CreateReportWidget> {
  late CreateReportModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateReportModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  /// Each modality: label + the action that creates a new record and opens its
  /// form. The record-creation logic below is unchanged from the original
  /// per-button handlers; only the presentation (a grid of tiles) is new.
  List<_CreateSpec> get _modalities => [
        _CreateSpec(
          label: 'Angiography',
          onTap: () async {
            var angiographyRecordReference =
                AngiographyRecord.collection.doc();
            // Do not await: offline, set() persists to the
            // local cache immediately but its Future does not
            // resolve until the server acks. Awaiting it would
            // hang the button spinner forever with no signal.
            angiographyRecordReference.set({
              ...createAngiographyRecordData(
                sysGenBrand: '',
                sysGenModal: '',
                sysGenYOM: '',
                sysGenSN: '',
                cosmeticText: '',
                accessoriesCDs: '',
                accessoriesSpareP: '',
                dnTAddress: '',
                dnTFloor: '',
                dnTDoorS: '',
                dnTDockAvailable: '',
                dnTNeedOfCrane: '',
                dnTTools: '',
                dnTSpecialAttention: '',
                otherNotes: '',
                sysGenDocName: '',
                userID: currentUserUid,
                softwareSN: '',
                softwareVersion: '',
                softwareOptionsText: '',
                tube1Model: '',
                tube1YOM: '',
                detectorModel: '',
                detectorSize: '',
                detectorYOM: '',
                detectorCondition: '',
                accPhantomModel: '',
                accPhantomModelNo: '',
                accPhantomSN: '',
                accPhantom1Model: '',
                accPhantom1ModelNo: '',
                accPhantom1ModelSN: '',
                accPhantom2Model: '',
                accPhantom2ModelNo: '',
                accPhantom2ModelSN: '',
                accPhantom3Model: '',
                accPhantom3ModelNo: '',
                accPhantom3ModelSN: '',
                cnWConsoleMOptions: '',
                cnWConsoleMSN: '',
                cnWConsoleMSW: '',
                cnWIRSSN: '',
                cnWIRSSW: '',
                cnWWorkSOptions: '',
                cnWWorkSSN: '',
                cnWWorkSSW: '',
                pTModal: '',
                ptsn: '',
                ptmc: '',
                photosURL: '',
              ),
              ...mapToFirestore(
                {
                  'OtherNotesPhotosURL': ['[]'],
                  'SoftwareOptPicsURL': ['[]'],
                  'CosmeticPicURL': ['[]'],
                  'CnWCMOptPURL': ['[]'],
                  'DeviceImg': ['[]'],
                },
              ),
            });
            _model.newDocAngio = AngiographyRecord.getDocumentFromData({
              ...createAngiographyRecordData(
                sysGenBrand: '',
                sysGenModal: '',
                sysGenYOM: '',
                sysGenSN: '',
                cosmeticText: '',
                accessoriesCDs: '',
                accessoriesSpareP: '',
                dnTAddress: '',
                dnTFloor: '',
                dnTDoorS: '',
                dnTDockAvailable: '',
                dnTNeedOfCrane: '',
                dnTTools: '',
                dnTSpecialAttention: '',
                otherNotes: '',
                sysGenDocName: '',
                userID: currentUserUid,
                softwareSN: '',
                softwareVersion: '',
                softwareOptionsText: '',
                tube1Model: '',
                tube1YOM: '',
                detectorModel: '',
                detectorSize: '',
                detectorYOM: '',
                detectorCondition: '',
                accPhantomModel: '',
                accPhantomModelNo: '',
                accPhantomSN: '',
                accPhantom1Model: '',
                accPhantom1ModelNo: '',
                accPhantom1ModelSN: '',
                accPhantom2Model: '',
                accPhantom2ModelNo: '',
                accPhantom2ModelSN: '',
                accPhantom3Model: '',
                accPhantom3ModelNo: '',
                accPhantom3ModelSN: '',
                cnWConsoleMOptions: '',
                cnWConsoleMSN: '',
                cnWConsoleMSW: '',
                cnWIRSSN: '',
                cnWIRSSW: '',
                cnWWorkSOptions: '',
                cnWWorkSSN: '',
                cnWWorkSSW: '',
                pTModal: '',
                ptsn: '',
                ptmc: '',
                photosURL: '',
              ),
              ...mapToFirestore(
                {
                  'OtherNotesPhotosURL': ['[]'],
                  'SoftwareOptPicsURL': ['[]'],
                  'CosmeticPicURL': ['[]'],
                  'CnWCMOptPURL': ['[]'],
                  'DeviceImg': ['[]'],
                },
              ),
            }, angiographyRecordReference);

            context.pushNamed(
              AngiographyWidget.routeName,
              queryParameters: {
                'docData': serializeParam(
                  _model.newDocAngio?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
        _CreateSpec(
          label: 'CT',
          onTap: () async {
            var ctRecordReference = CtRecord.collection.doc();
            ctRecordReference.set(createCtRecordData(
              sysGenBrand: '',
              sysGenModal: '',
              sysGenYOM: '',
              sysGenSN: '',
              sysGenSlices: '',
              gantryModelSN: '',
              gantryTubeModel: '',
              gantryTubeYOM: '',
              gantryTubeScanSec: '',
              gantryTubeOilLeakage: '',
              gantryDetModal: '',
              gantryDetSN: '',
              gantryDetDC: '',
              cSWaterAir: '',
              cSComesWith: '',
              pTModal: '',
              ptsn: '',
              ptmc: '',
              cnWConsoleMSN: '',
              cnWConsoleMSW: '',
              cnWConsoleMOptions: '',
              cnWWorkSSN: '',
              cnWWorkSSW: '',
              cnWWorkSOptions: '',
              cnWIRSSN: '',
              cnWIRSSW: '',
              cosmeticText: '',
              accessoriesPModal: '',
              accessoriesPModelNo: '',
              accessoriesPSN: '',
              accessoriesPHolders: '',
              accessoriesCDs: '',
              accessoriesInjector: '',
              accessoriesSpareP: '',
              dnTAddress: '',
              dnTFloor: '',
              dnTDoorS: '',
              dnTDockAvailable: '',
              dnTNeedOfCrane: '',
              dnTTools: '',
              dnTSpecialAttention: '',
              otherNotes: '',
              sysGenDocName: '',
              userID: currentUserUid,
            ));
            _model.newDocCT = CtRecord.getDocumentFromData(
                createCtRecordData(
                  sysGenBrand: '',
                  sysGenModal: '',
                  sysGenYOM: '',
                  sysGenSN: '',
                  sysGenSlices: '',
                  gantryModelSN: '',
                  gantryTubeModel: '',
                  gantryTubeYOM: '',
                  gantryTubeScanSec: '',
                  gantryTubeOilLeakage: '',
                  gantryDetModal: '',
                  gantryDetSN: '',
                  gantryDetDC: '',
                  cSWaterAir: '',
                  cSComesWith: '',
                  pTModal: '',
                  ptsn: '',
                  ptmc: '',
                  cnWConsoleMSN: '',
                  cnWConsoleMSW: '',
                  cnWConsoleMOptions: '',
                  cnWWorkSSN: '',
                  cnWWorkSSW: '',
                  cnWWorkSOptions: '',
                  cnWIRSSN: '',
                  cnWIRSSW: '',
                  cosmeticText: '',
                  accessoriesPModal: '',
                  accessoriesPModelNo: '',
                  accessoriesPSN: '',
                  accessoriesPHolders: '',
                  accessoriesCDs: '',
                  accessoriesInjector: '',
                  accessoriesSpareP: '',
                  dnTAddress: '',
                  dnTFloor: '',
                  dnTDoorS: '',
                  dnTDockAvailable: '',
                  dnTNeedOfCrane: '',
                  dnTTools: '',
                  dnTSpecialAttention: '',
                  otherNotes: '',
                  sysGenDocName: '',
                  userID: currentUserUid,
                ),
                ctRecordReference);

            context.pushNamed(
              CtWidget.routeName,
              queryParameters: {
                'docData': serializeParam(
                  _model.newDocCT?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
        _CreateSpec(
          label: 'Ultrasound',
          onTap: () async {
            var ultrasoundRecordReference =
                UltrasoundRecord.collection.doc();
            ultrasoundRecordReference.set({
              ...createUltrasoundRecordData(
                sysGenBrand: '',
                sysGenModal: '',
                sysGenYOM: '',
                sysGenSN: '',
                cosmeticText: '',
                accessoriesCDs: '',
                accessoriesSpareP: '',
                dnTAddress: '',
                dnTFloor: '',
                dnTDoorS: '',
                dnTDockAvailable: '',
                dnTNeedOfCrane: '',
                dnTTools: '',
                dnTSpecialAttention: '',
                otherNotes: '',
                sysGenDocName: '',
                userID: currentUserUid,
                softwareSN: '',
                softwareVersion: '',
                softwareOptionsText: '',
                probe1Model: '',
                probe2Model: '',
                probe3Model: '',
                probe4Model: '',
                probe5Model: '',
                probe1YOM: '',
                probe2YOM: '',
                probe3YOM: '',
                probe4YOM: '',
                probe5YOM: '',
                probe1Condition: '',
                probe2Condition: '',
                probe3Condition: '',
                probe4Condition: '',
                probe5Condition: '',
                photosURL: '[]',
              ),
              ...mapToFirestore(
                {
                  'OtherNotesPhotosURL': ['[]'],
                  'SoftwareOptPicsURL': ['[]'],
                  'CosmeticPicURL': ['[]'],
                  'DeviceImg': ['[]'],
                },
              ),
            });
            _model.newDocUltrasound = UltrasoundRecord.getDocumentFromData({
              ...createUltrasoundRecordData(
                sysGenBrand: '',
                sysGenModal: '',
                sysGenYOM: '',
                sysGenSN: '',
                cosmeticText: '',
                accessoriesCDs: '',
                accessoriesSpareP: '',
                dnTAddress: '',
                dnTFloor: '',
                dnTDoorS: '',
                dnTDockAvailable: '',
                dnTNeedOfCrane: '',
                dnTTools: '',
                dnTSpecialAttention: '',
                otherNotes: '',
                sysGenDocName: '',
                userID: currentUserUid,
                softwareSN: '',
                softwareVersion: '',
                softwareOptionsText: '',
                probe1Model: '',
                probe2Model: '',
                probe3Model: '',
                probe4Model: '',
                probe5Model: '',
                probe1YOM: '',
                probe2YOM: '',
                probe3YOM: '',
                probe4YOM: '',
                probe5YOM: '',
                probe1Condition: '',
                probe2Condition: '',
                probe3Condition: '',
                probe4Condition: '',
                probe5Condition: '',
                photosURL: '[]',
              ),
              ...mapToFirestore(
                {
                  'OtherNotesPhotosURL': ['[]'],
                  'SoftwareOptPicsURL': ['[]'],
                  'CosmeticPicURL': ['[]'],
                  'DeviceImg': ['[]'],
                },
              ),
            }, ultrasoundRecordReference);

            context.pushNamed(
              UltrasoundWidget.routeName,
              queryParameters: {
                'docData': serializeParam(
                  _model.newDocUltrasound?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
        _CreateSpec(
          label: 'MRI',
          onTap: () async {
            var mriRecordReference = MriRecord.collection.doc();
            mriRecordReference.set(createMriRecordData(
              userID: currentUserUid,
            ));
            _model.newDocMRI = MriRecord.getDocumentFromData(
                createMriRecordData(
                  userID: currentUserUid,
                ),
                mriRecordReference);

            context.pushNamed(
              MriWidget.routeName,
              queryParameters: {
                'docRefMRI': serializeParam(
                  _model.newDocMRI?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
        _CreateSpec(
          label: 'X-Ray',
          onTap: () async {
            var xRayRecordReference = XRayRecord.collection.doc();
            xRayRecordReference.set(createXRayRecordData(
              userID: currentUserUid,
            ));
            _model.newDocXRay = XRayRecord.getDocumentFromData(
                createXRayRecordData(
                  userID: currentUserUid,
                ),
                xRayRecordReference);

            context.pushNamed(
              XRayWidget.routeName,
              queryParameters: {
                'docRefXRay': serializeParam(
                  _model.newDocXRay?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
        _CreateSpec(
          label: 'Flouroscopy',
          onTap: () async {
            var fluoroscopyRecordReference =
                FluoroscopyRecord.collection.doc();
            fluoroscopyRecordReference.set(createFluoroscopyRecordData(
              userID: currentUserUid,
            ));
            _model.newDocFL = FluoroscopyRecord.getDocumentFromData(
                createFluoroscopyRecordData(
                  userID: currentUserUid,
                ),
                fluoroscopyRecordReference);

            context.pushNamed(
              FlouroscopyWidget.routeName,
              queryParameters: {
                'docRefFL': serializeParam(
                  _model.newDocFL?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
        _CreateSpec(
          label: 'C-Arm',
          onTap: () async {
            var cArmRecordReference = CArmRecord.collection.doc();
            cArmRecordReference.set(createCArmRecordData(
              userID: currentUserUid,
              sysGenBrand: '',
              sysGenModal: '',
              sysGenYOM: '',
              sysGenSN: '',
              cosmeticText: '',
              accessoriesCDs: '',
              accessoriesSpareP: '',
              dnTAddress: '',
              dnTFloor: '',
              dnTDoorS: '',
              dnTDockAvailable: '',
              dnTNeedOfCrane: '',
              dnTTools: '',
              dnTSpecialAttention: '',
              otherNotes: '',
              sysGenDocName: '',
              softwareSN: '',
              softwareVersion: '',
              tube1Model: '',
              tube1YOM: '',
              detectorModel: '',
              detectorSize: '',
              detectorYOM: '',
              detectorCondition: '',
              accPhantomModel: '',
              accPhantomModelNo: '',
              accPhantomSN: '',
              softwareOptionsText: '',
            ));
            _model.newDocCArm = CArmRecord.getDocumentFromData(
                createCArmRecordData(
                  userID: currentUserUid,
                  sysGenBrand: '',
                  sysGenModal: '',
                  sysGenYOM: '',
                  sysGenSN: '',
                  cosmeticText: '',
                  accessoriesCDs: '',
                  accessoriesSpareP: '',
                  dnTAddress: '',
                  dnTFloor: '',
                  dnTDoorS: '',
                  dnTDockAvailable: '',
                  dnTNeedOfCrane: '',
                  dnTTools: '',
                  dnTSpecialAttention: '',
                  otherNotes: '',
                  sysGenDocName: '',
                  softwareSN: '',
                  softwareVersion: '',
                  tube1Model: '',
                  tube1YOM: '',
                  detectorModel: '',
                  detectorSize: '',
                  detectorYOM: '',
                  detectorCondition: '',
                  accPhantomModel: '',
                  accPhantomModelNo: '',
                  accPhantomSN: '',
                  softwareOptionsText: '',
                ),
                cArmRecordReference);

            context.pushNamed(
              CArmWidget.routeName,
              queryParameters: {
                'docRefCArm': serializeParam(
                  _model.newDocCArm?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
        _CreateSpec(
          label: 'Mammography',
          onTap: () async {
            var mammographyRecordReference =
                MammographyRecord.collection.doc();
            mammographyRecordReference.set(createMammographyRecordData(
              userID: currentUserUid,
            ));
            _model.newDocMamm = MammographyRecord.getDocumentFromData(
                createMammographyRecordData(
                  userID: currentUserUid,
                ),
                mammographyRecordReference);

            context.pushNamed(
              MammographyWidget.routeName,
              queryParameters: {
                'docRefMamm': serializeParam(
                  _model.newDocMamm?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
        _CreateSpec(
          label: 'PACS',
          onTap: () async {
            var pacsRecordReference = PacsRecord.collection.doc();
            pacsRecordReference.set(createPacsRecordData(
              userID: currentUserUid,
            ));
            _model.newDocPACS = PacsRecord.getDocumentFromData(
                createPacsRecordData(
                  userID: currentUserUid,
                ),
                pacsRecordReference);

            context.pushNamed(
              PacsWidget.routeName,
              queryParameters: {
                'docRefPACS': serializeParam(
                  _model.newDocPACS?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
        _CreateSpec(
          label: 'DR',
          onTap: () async {
            var drRecordReference = DrRecord.collection.doc();
            drRecordReference.set(createDrRecordData(
              userID: currentUserUid,
            ));
            _model.newDocDR = DrRecord.getDocumentFromData(
                createDrRecordData(
                  userID: currentUserUid,
                ),
                drRecordReference);

            context.pushNamed(
              DrWidget.routeName,
              queryParameters: {
                'docRefDR': serializeParam(
                  _model.newDocDR?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
        _CreateSpec(
          label: 'CR',
          onTap: () async {
            var crRecordReference = CrRecord.collection.doc();
            crRecordReference.set(createCrRecordData(
              userID: currentUserUid,
            ));
            _model.newDocCR = CrRecord.getDocumentFromData(
                createCrRecordData(
                  userID: currentUserUid,
                ),
                crRecordReference);

            context.pushNamed(
              CrWidget.routeName,
              queryParameters: {
                'docRefCR': serializeParam(
                  _model.newDocCR?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );

            safeSetState(() {});
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.logoModel,
                updateCallback: () => safeSetState(() {}),
                child: LogoWidget(),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                  child: Text(
                    'Choose modality',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.readexPro(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 120.0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 0.82,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: _modalities
                        .map((m) => _CreateTile(label: m.label, onTap: m.onTap))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Declarative description of one modality tile on the Create grid.
class _CreateSpec {
  const _CreateSpec({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;
}

/// A square card: modality icon centered with the label beneath. Tapping it
/// runs the modality's record-creation action.
class _CreateTile extends StatelessWidget {
  const _CreateTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18.0),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF0F7FF),
            borderRadius: BorderRadius.circular(18.0),
          ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ModalityIcon(label: label, size: 46.0),
              SizedBox(height: 8.0),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.readexPro(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: theme.primaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
