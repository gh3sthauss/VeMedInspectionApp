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
import 'm_r_i_mars_imager_model.dart';
export 'm_r_i_mars_imager_model.dart';

class MRIMarsImagerWidget extends StatefulWidget {
  const MRIMarsImagerWidget({
    super.key,
    required this.docRefImager,
  });

  final DocumentReference? docRefImager;

  static String routeName = 'MRI_MarsImager';
  static String routePath = '/mRIMarsImager';

  @override
  State<MRIMarsImagerWidget> createState() => _MRIMarsImagerWidgetState();
}

class _MRIMarsImagerWidgetState extends State<MRIMarsImagerWidget> {
  late MRIMarsImagerModel _model;
  late PhotoUploadOutboxModel _photoModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MRIMarsImagerModel());
    _photoModel = createModel(context, () => PhotoUploadOutboxModel());

    _model.textInputFocusNode1 ??= FocusNode();

    _model.textInputFocusNode2 ??= FocusNode();

    _model.textInputFocusNode3 ??= FocusNode();

    _model.textInputFocusNode4 ??= FocusNode();

    _model.textInputFocusNode5 ??= FocusNode();

    _model.textInputFocusNode6 ??= FocusNode();

    _model.textInputFocusNode7 ??= FocusNode();

    _model.textInputFocusNode8 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    _photoModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MriRecord>(
      stream: MriRecord.getDocument(widget.docRefImager!),
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

        final mRIMarsImagerMriRecord = snapshot.data!;

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
                  CompactAppBar(title: 'Mars / Imager'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 100.0,
                              height: 194.0,
                              constraints: BoxConstraints(
                                minWidth: 330.0,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0x91F0F7FF),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 0.0, 10.0),
                                    child: Text(
                                      'Imager',
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
                                            fontSize: 18.0,
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
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 2.0, 0.0),
                                    child: Container(
                                      width: 320.0,
                                      child: TextFormField(
                                        controller:
                                            _model.textInputTextController1 ??=
                                                TextEditingController(
                                          text: mRIMarsImagerMriRecord
                                              .imagerModel,
                                        ),
                                        focusNode: _model.textInputFocusNode1,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Model',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF14181B),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF0F7FF),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 0.0, 10.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF14181B),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .textInputTextController1Validator
                                            .asValidator(context),
                                        inputFormatters: [
                                          if (!isAndroid && !isiOS)
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return TextEditingValue(
                                                selection: newValue.selection,
                                                text: newValue.text
                                                    .toCapitalization(
                                                        TextCapitalization
                                                            .words),
                                              );
                                            }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 2.0, 0.0),
                                    child: Container(
                                      width: 320.0,
                                      child: TextFormField(
                                        controller:
                                            _model.textInputTextController2 ??=
                                                TextEditingController(
                                          text: mRIMarsImagerMriRecord
                                              .imagerModelSN,
                                        ),
                                        focusNode: _model.textInputFocusNode2,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Serial Number',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF14181B),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF0F7FF),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 0.0, 10.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF14181B),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .textInputTextController2Validator
                                            .asValidator(context),
                                        inputFormatters: [
                                          if (!isAndroid && !isiOS)
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return TextEditingValue(
                                                selection: newValue.selection,
                                                text: newValue.text
                                                    .toCapitalization(
                                                        TextCapitalization
                                                            .words),
                                              );
                                            }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(height: 16.0))
                                    .addToStart(SizedBox(height: 10.0))
                                    .addToEnd(SizedBox(height: 10.0)),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 100.0,
                              height: 194.0,
                              constraints: BoxConstraints(
                                minWidth: 330.0,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0x91F0F7FF),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 0.0, 10.0),
                                    child: Text(
                                      'DV Star',
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
                                            fontSize: 18.0,
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
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 2.0, 0.0),
                                    child: Container(
                                      width: 320.0,
                                      child: TextFormField(
                                        controller:
                                            _model.textInputTextController3 ??=
                                                TextEditingController(
                                          text: mRIMarsImagerMriRecord
                                              .imagerDVStarModel,
                                        ),
                                        focusNode: _model.textInputFocusNode3,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Model',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF14181B),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF0F7FF),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 0.0, 10.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF14181B),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .textInputTextController3Validator
                                            .asValidator(context),
                                        inputFormatters: [
                                          if (!isAndroid && !isiOS)
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return TextEditingValue(
                                                selection: newValue.selection,
                                                text: newValue.text
                                                    .toCapitalization(
                                                        TextCapitalization
                                                            .words),
                                              );
                                            }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 2.0, 0.0),
                                    child: Container(
                                      width: 320.0,
                                      child: TextFormField(
                                        controller:
                                            _model.textInputTextController4 ??=
                                                TextEditingController(
                                          text: mRIMarsImagerMriRecord
                                              .imagerDVStarSN,
                                        ),
                                        focusNode: _model.textInputFocusNode4,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Serial Number',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF14181B),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF0F7FF),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 0.0, 10.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF14181B),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .textInputTextController4Validator
                                            .asValidator(context),
                                        inputFormatters: [
                                          if (!isAndroid && !isiOS)
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return TextEditingValue(
                                                selection: newValue.selection,
                                                text: newValue.text
                                                    .toCapitalization(
                                                        TextCapitalization
                                                            .words),
                                              );
                                            }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(height: 16.0))
                                    .addToStart(SizedBox(height: 10.0))
                                    .addToEnd(SizedBox(height: 10.0)),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 100.0,
                              height: 194.0,
                              constraints: BoxConstraints(
                                minWidth: 330.0,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0x91F0F7FF),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 0.0, 10.0),
                                    child: Text(
                                      'PCIe - RX1',
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
                                            fontSize: 18.0,
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
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 2.0, 0.0),
                                    child: Container(
                                      width: 320.0,
                                      child: TextFormField(
                                        controller:
                                            _model.textInputTextController5 ??=
                                                TextEditingController(
                                          text: mRIMarsImagerMriRecord
                                              .imagerPCIRX1Model,
                                        ),
                                        focusNode: _model.textInputFocusNode5,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Model',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF14181B),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF0F7FF),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 0.0, 10.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF14181B),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .textInputTextController5Validator
                                            .asValidator(context),
                                        inputFormatters: [
                                          if (!isAndroid && !isiOS)
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return TextEditingValue(
                                                selection: newValue.selection,
                                                text: newValue.text
                                                    .toCapitalization(
                                                        TextCapitalization
                                                            .words),
                                              );
                                            }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 2.0, 0.0),
                                    child: Container(
                                      width: 320.0,
                                      child: TextFormField(
                                        controller:
                                            _model.textInputTextController6 ??=
                                                TextEditingController(
                                          text: mRIMarsImagerMriRecord
                                              .imagerPCIRX1ModelSN,
                                        ),
                                        focusNode: _model.textInputFocusNode6,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Serial Number',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF14181B),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF0F7FF),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 0.0, 10.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF14181B),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .textInputTextController6Validator
                                            .asValidator(context),
                                        inputFormatters: [
                                          if (!isAndroid && !isiOS)
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return TextEditingValue(
                                                selection: newValue.selection,
                                                text: newValue.text
                                                    .toCapitalization(
                                                        TextCapitalization
                                                            .words),
                                              );
                                            }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(height: 16.0))
                                    .addToStart(SizedBox(height: 10.0))
                                    .addToEnd(SizedBox(height: 10.0)),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 100.0,
                              height: 194.0,
                              constraints: BoxConstraints(
                                minWidth: 330.0,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0x91F0F7FF),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 0.0, 10.0),
                                    child: Text(
                                      'PCIe - RX2',
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
                                            fontSize: 18.0,
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
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 2.0, 0.0),
                                    child: Container(
                                      width: 320.0,
                                      child: TextFormField(
                                        controller:
                                            _model.textInputTextController7 ??=
                                                TextEditingController(
                                          text: mRIMarsImagerMriRecord
                                              .imagerPCIRX2Model,
                                        ),
                                        focusNode: _model.textInputFocusNode7,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Model',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF14181B),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF0F7FF),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 0.0, 10.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF14181B),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .textInputTextController7Validator
                                            .asValidator(context),
                                        inputFormatters: [
                                          if (!isAndroid && !isiOS)
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return TextEditingValue(
                                                selection: newValue.selection,
                                                text: newValue.text
                                                    .toCapitalization(
                                                        TextCapitalization
                                                            .words),
                                              );
                                            }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 2.0, 0.0),
                                    child: Container(
                                      width: 320.0,
                                      child: TextFormField(
                                        controller:
                                            _model.textInputTextController8 ??=
                                                TextEditingController(
                                          text: mRIMarsImagerMriRecord
                                              .imagerPCIRX2ModelSN,
                                        ),
                                        focusNode: _model.textInputFocusNode8,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Serial Number',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF14181B),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF0F7FF),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 0.0, 10.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF14181B),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .textInputTextController8Validator
                                            .asValidator(context),
                                        inputFormatters: [
                                          if (!isAndroid && !isiOS)
                                            TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                              return TextEditingValue(
                                                selection: newValue.selection,
                                                text: newValue.text
                                                    .toCapitalization(
                                                        TextCapitalization
                                                            .words),
                                              );
                                            }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(height: 16.0))
                                    .addToStart(SizedBox(height: 10.0))
                                    .addToEnd(SizedBox(height: 10.0)),
                              ),
                            ),
                          ),
                        ]
                            .divide(SizedBox(height: 16.0))
                            .addToStart(SizedBox(height: 20.0))
                            .addToEnd(SizedBox(height: 20.0)),
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
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          )),
                      wrapWithModel(
                        model: _photoModel,
                        updateCallback: () => safeSetState(() {}),
                        child: PhotoUploadOutboxWidget(
                          collectionPath: 'MRI',
                          docId: widget.docRefImager!.id,
                          arrayFieldName: 'MarsImagerPicURL',
                          storagePathPrefix:
                              'users/$currentUserUid/mri/marsImager',
                          existingPhotoUrls:
                              mRIMarsImagerMriRecord.marsImagerPicURL.toList(),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await mRIMarsImagerMriRecord.reference
                            .update(createMriRecordData(
                          imagerModel: _model.textInputTextController1.text,
                          imagerModelSN: _model.textInputTextController2.text,
                          imagerDVStarModel:
                              _model.textInputTextController3.text,
                          imagerDVStarSN: _model.textInputTextController4.text,
                          imagerPCIRX1Model:
                              _model.textInputTextController5.text,
                          imagerPCIRX1ModelSN:
                              _model.textInputTextController6.text,
                          imagerPCIRX2Model:
                              _model.textInputTextController7.text,
                          imagerPCIRX2ModelSN:
                              _model.textInputTextController8.text,
                        ));

                        context.pushNamed(
                          MriWidget.routeName,
                          queryParameters: {
                            'docRefMRI': serializeParam(
                              widget.docRefImager,
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
