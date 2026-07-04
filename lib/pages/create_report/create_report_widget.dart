import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var angiographyRecordReference =
                                AngiographyRecord.collection.doc();
                            await angiographyRecordReference.set({
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
                            _model.newDocAngio =
                                AngiographyRecord.getDocumentFromData({
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
                          text: 'Angiography',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var ctRecordReference = CtRecord.collection.doc();
                            await ctRecordReference.set(createCtRecordData(
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
                          text: 'CT',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var ultrasoundRecordReference =
                                UltrasoundRecord.collection.doc();
                            await ultrasoundRecordReference.set({
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
                            _model.newDocUltrasound =
                                UltrasoundRecord.getDocumentFromData({
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
                          text: 'Ultrasound',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var mriRecordReference = MriRecord.collection.doc();
                            await mriRecordReference.set(createMriRecordData(
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
                          text: 'MRI',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var xRayRecordReference =
                                XRayRecord.collection.doc();
                            await xRayRecordReference.set(createXRayRecordData(
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
                          text: 'X-Ray',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var fluoroscopyRecordReference =
                                FluoroscopyRecord.collection.doc();
                            await fluoroscopyRecordReference
                                .set(createFluoroscopyRecordData(
                              userID: currentUserUid,
                            ));
                            _model.newDocFL =
                                FluoroscopyRecord.getDocumentFromData(
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
                          text: 'Flouroscopy',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var cArmRecordReference =
                                CArmRecord.collection.doc();
                            await cArmRecordReference.set(createCArmRecordData(
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
                          text: 'C-Arm',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var mammographyRecordReference =
                                MammographyRecord.collection.doc();
                            await mammographyRecordReference
                                .set(createMammographyRecordData(
                              userID: currentUserUid,
                            ));
                            _model.newDocMamm =
                                MammographyRecord.getDocumentFromData(
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
                          text: 'Mammography',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var pacsRecordReference =
                                PacsRecord.collection.doc();
                            await pacsRecordReference.set(createPacsRecordData(
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
                          text: 'PACS',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var drRecordReference = DrRecord.collection.doc();
                            await drRecordReference.set(createDrRecordData(
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
                          text: 'DR',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var crRecordReference = CrRecord.collection.doc();
                            await crRecordReference.set(createCrRecordData(
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
                          text: 'CR',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(TestWidget.routeName);
                          },
                          text: 'Test',
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 2.0, 0.0, 2.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF0F7FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 10.0))
                        .addToStart(SizedBox(height: 30.0))
                        .addToEnd(SizedBox(height: 120.0)),
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
