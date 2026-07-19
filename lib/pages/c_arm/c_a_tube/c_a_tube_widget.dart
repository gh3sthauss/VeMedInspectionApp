// MANUALLY MIGRATED for offline photo upload (outbox pattern) — see
// lib/components/photo_upload_outbox/. If this page is re-synced from
// FlutterFlow, this migration must be reapplied.
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/compact_app_bar.dart';
import '/components/photo_upload_outbox/photo_upload_outbox_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'c_a_tube_model.dart';
export 'c_a_tube_model.dart';

class CATubeWidget extends StatefulWidget {
  const CATubeWidget({
    super.key,
    required this.docRefSoft,
  });

  final DocumentReference? docRefSoft;

  static String routeName = 'CA_Tube';
  static String routePath = '/cATube';

  @override
  State<CATubeWidget> createState() => _CATubeWidgetState();
}

class _CATubeWidgetState extends State<CATubeWidget> {
  late CATubeModel _model;
  late PhotoUploadOutboxModel _photoModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CATubeModel());
    _photoModel = createModel(context, () => PhotoUploadOutboxModel());

    _model.textFocusNode1 ??= FocusNode();

    _model.textFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    _photoModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CArmRecord>(
      stream: CArmRecord.getDocument(widget.docRefSoft!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final cATubeCArmRecord = snapshot.data!;

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
                  CompactAppBar(title: 'Tube'),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              25.0, 0.0, 25.0, 0.0),
                          child: Container(
                            width: 320.0,
                            child: TextFormField(
                              controller: _model.textTextController1 ??=
                                  TextEditingController(
                                text: cATubeCArmRecord.tube1Model,
                              ),
                              focusNode: _model.textFocusNode1,
                              textCapitalization: TextCapitalization.words,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Tube Model',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF14181B),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                alignLabelWithHint: false,
                                hintText: ' ',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4B39EF),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                filled: true,
                                fillColor: Color(0xFFF0F7FF),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 0.0, 10.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF14181B),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              validator: _model.textTextController1Validator
                                  .asValidator(context),
                              inputFormatters: [
                                if (!isAndroid && !isiOS)
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    return TextEditingValue(
                                      selection: newValue.selection,
                                      text: newValue.text.toCapitalization(
                                          TextCapitalization.words),
                                    );
                                  }),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              25.0, 0.0, 25.0, 0.0),
                          child: Container(
                            width: 320.0,
                            child: TextFormField(
                              controller: _model.textTextController2 ??=
                                  TextEditingController(
                                text: cATubeCArmRecord.tube1YOM,
                              ),
                              focusNode: _model.textFocusNode2,
                              textCapitalization: TextCapitalization.words,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Year of Manufacture',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF14181B),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                alignLabelWithHint: false,
                                hintText: ' ',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4B39EF),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                filled: true,
                                fillColor: Color(0xFFF0F7FF),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 0.0, 10.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF14181B),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              validator: _model.textTextController2Validator
                                  .asValidator(context),
                              inputFormatters: [
                                if (!isAndroid && !isiOS)
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    return TextEditingValue(
                                      selection: newValue.selection,
                                      text: newValue.text.toCapitalization(
                                          TextCapitalization.words),
                                    );
                                  }),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    25.0, 0.0, 25.0, 0.0),
                                child: Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Text(
                                    'Pictures',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                )),
                            wrapWithModel(
                              model: _photoModel,
                              updateCallback: () => safeSetState(() {}),
                              child: PhotoUploadOutboxWidget(
                                collectionPath: 'CArm',
                                docId: widget.docRefSoft!.id,
                                arrayFieldName: 'TubePicURL',
                                storagePathPrefix:
                                    'users/$currentUserUid/cArm/tube',
                                existingPhotoUrls:
                                    cATubeCArmRecord.tubePicURL.toList(),
                              ),
                            ),
                          ],
                        ),
                      ]
                          .divide(SizedBox(height: 16.0))
                          .addToStart(SizedBox(height: 20.0)),
                    )),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await widget.docRefSoft!.update(createCArmRecordData(
                          tube1Model: _model.textTextController1.text,
                          tube1YOM: _model.textTextController2.text,
                        ));

                        context.pushNamed(
                          CArmWidget.routeName,
                          queryParameters: {
                            'docRefCArm': serializeParam(
                              widget.docRefSoft,
                              ParamType.DocumentReference,
                            ),
                          }.withoutNulls,
                        );
                      },
                      text: 'Save',
                      options: FFButtonOptions(
                        width: 320.0,
                        height: 50.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                        elevation: 3.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
