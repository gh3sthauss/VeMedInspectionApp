// MANUALLY MIGRATED for offline photo upload (outbox pattern) — see
// lib/components/photo_upload_outbox/. If this page is re-synced from
// FlutterFlow, this migration must be reapplied.
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/compact_app_bar.dart';
import '/components/notes_field.dart';
import '/components/photo_upload_outbox/photo_upload_outbox_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'c_t_accessories_model.dart';
export 'c_t_accessories_model.dart';

class CTAccessoriesWidget extends StatefulWidget {
  const CTAccessoriesWidget({
    super.key,
    required this.docDataA,
  });

  final DocumentReference? docDataA;

  static String routeName = 'CT_Accessories';
  static String routePath = '/cTAccessories';

  @override
  State<CTAccessoriesWidget> createState() => _CTAccessoriesWidgetState();
}

class _CTAccessoriesWidgetState extends State<CTAccessoriesWidget> {
  late CTAccessoriesModel _model;
  late PhotoUploadOutboxModel _photoModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CTAccessoriesModel());
    _photoModel = createModel(context, () => PhotoUploadOutboxModel());

    _model.textInputFocusNode1 ??= FocusNode();

    _model.textInputFocusNode2 ??= FocusNode();

    _model.textInputFocusNode3 ??= FocusNode();

    _model.textInputFocusNode4 ??= FocusNode();

    _model.textInputFocusNode5 ??= FocusNode();

    _model.textInputFocusNode6 ??= FocusNode();

    _model.textInputFocusNode7 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    _photoModel.dispose();

    super.dispose();
  }

  /// One "Phantom N" card: Model / Model Number / Serial Number / Holders,
  /// styled to match the always-present Phantom 1 section.
  Widget _phantomSection({
    required String title,
    required TextEditingController modelController,
    required FocusNode? modelFocusNode,
    required String? Function(BuildContext, String?)? modelValidator,
    required TextEditingController modelNoController,
    required FocusNode? modelNoFocusNode,
    required String? Function(BuildContext, String?)? modelNoValidator,
    required TextEditingController snController,
    required FocusNode? snFocusNode,
    required String? Function(BuildContext, String?)? snValidator,
    required TextEditingController holdersController,
    required FocusNode? holdersFocusNode,
    required String? Function(BuildContext, String?)? holdersValidator,
  }) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 100.0,
        height: 330.0,
        constraints: BoxConstraints(minWidth: 330.0),
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
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 20.0),
              child: Text(
                title,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.readexPro(),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                    ),
              ),
            ),
            _phantomField(
              controller: modelController,
              focusNode: modelFocusNode,
              validator: modelValidator,
              label: 'Model',
            ),
            _phantomField(
              controller: modelNoController,
              focusNode: modelNoFocusNode,
              validator: modelNoValidator,
              label: 'Model Number',
            ),
            _phantomField(
              controller: snController,
              focusNode: snFocusNode,
              validator: snValidator,
              label: 'Serial Number',
            ),
            _phantomField(
              controller: holdersController,
              focusNode: holdersFocusNode,
              validator: holdersValidator,
              label: 'Holders',
            ),
          ].divide(SizedBox(height: 16.0)).addToStart(SizedBox(height: 10.0)).addToEnd(SizedBox(height: 10.0)),
        ),
      ),
    );
  }

  Widget _phantomField({
    required TextEditingController controller,
    required FocusNode? focusNode,
    required String? Function(BuildContext, String?)? validator,
    required String label,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 2.0, 0.0),
      child: Container(
        width: 320.0,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          onChanged: (_) => safeSetState(() {}),
          textCapitalization: TextCapitalization.words,
          obscureText: false,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.normal),
                  color: Color(0xFF14181B),
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                ),
            alignLabelWithHint: false,
            hintText: ' ',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE0E3E7), width: 1.0),
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4B39EF), width: 1.0),
              borderRadius: BorderRadius.circular(50.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF5963), width: 1.0),
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF5963), width: 1.0),
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            fillColor: Color(0xFFF0F7FF),
            contentPadding:
                EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 0.0, 10.0),
            suffixIcon: controller.text.isNotEmpty
                ? InkWell(
                    onTap: () async {
                      controller.clear();
                      safeSetState(() {});
                    },
                    child: Icon(Icons.clear, color: Color(0xFF757575), size: 22.0),
                  )
                : null,
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.normal),
                color: Color(0xFF14181B),
                fontSize: 16.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
              ),
          validator: validator?.asValidator(context),
          inputFormatters: [
            if (!isAndroid && !isiOS)
              TextInputFormatter.withFunction((oldValue, newValue) {
                return TextEditingValue(
                  selection: newValue.selection,
                  text: newValue.text
                      .toCapitalization(TextCapitalization.words),
                );
              }),
          ],
        ),
      ),
    );
  }

  /// The "+ Add phantom" button shown under the last visible phantom section.
  Widget _addPhantomButton(VoidCallback onPressed) {
    return FFButtonWidget(
      onPressed: onPressed,
      text: 'Add phantom',
      icon: Icon(Icons.add, size: 20.0),
      options: FFButtonOptions(
        width: 320.0,
        height: 44.0,
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: FlutterFlowTheme.of(context).secondaryBackground,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.readexPro(),
              color: FlutterFlowTheme.of(context).primary,
              fontSize: 16.0,
              letterSpacing: 0.0,
            ),
        iconColor: FlutterFlowTheme.of(context).primary,
        elevation: 0.0,
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).primary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CtRecord>(
      stream: CtRecord.getDocument(widget.docDataA!),
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

        final cTAccessoriesCtRecord = snapshot.data!;

        // Show an extra phantom section once the user taps "Add phantom", and
        // always show one that already holds saved data.
        final rec = cTAccessoriesCtRecord;
        final showPhantom2 = _model.showPhantom2 ||
            rec.accessoriesP2Modal.isNotEmpty ||
            rec.accessoriesP2ModelNo.isNotEmpty ||
            rec.accessoriesP2SN.isNotEmpty ||
            rec.accessoriesP2Holders.isNotEmpty;
        final showPhantom3 = _model.showPhantom3 ||
            rec.accessoriesP3Modal.isNotEmpty ||
            rec.accessoriesP3ModelNo.isNotEmpty ||
            rec.accessoriesP3SN.isNotEmpty ||
            rec.accessoriesP3Holders.isNotEmpty;

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
                  CompactAppBar(title: 'Accessories'),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 100.0,
                            height: 330.0,
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
                                      10.0, 10.0, 0.0, 20.0),
                                  child: Text(
                                    'Phantom 1',
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
                                        text: cTAccessoriesCtRecord
                                            .accessoriesPModal,
                                      ),
                                      focusNode: _model.textInputFocusNode1,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textInputTextController1',
                                        Duration(milliseconds: 2000),
                                        () => safeSetState(() {}),
                                      ),
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Model',
                                        labelStyle: FlutterFlowTheme.of(context)
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
                                        focusedErrorBorder: OutlineInputBorder(
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
                                        suffixIcon: _model
                                                .textInputTextController1!
                                                .text
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  _model
                                                      .textInputTextController1
                                                      ?.clear();
                                                  safeSetState(() {});
                                                },
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Color(0xFF757575),
                                                  size: 22.0,
                                                ),
                                              )
                                            : null,
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
                                                      TextCapitalization.words),
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
                                        text: cTAccessoriesCtRecord
                                            .accessoriesPModelNo,
                                      ),
                                      focusNode: _model.textInputFocusNode2,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textInputTextController2',
                                        Duration(milliseconds: 2000),
                                        () => safeSetState(() {}),
                                      ),
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Model Number',
                                        labelStyle: FlutterFlowTheme.of(context)
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
                                        focusedErrorBorder: OutlineInputBorder(
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
                                        suffixIcon: _model
                                                .textInputTextController2!
                                                .text
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  _model
                                                      .textInputTextController2
                                                      ?.clear();
                                                  safeSetState(() {});
                                                },
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Color(0xFF757575),
                                                  size: 22.0,
                                                ),
                                              )
                                            : null,
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
                                                      TextCapitalization.words),
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
                                          _model.textInputTextController3 ??=
                                              TextEditingController(
                                        text: cTAccessoriesCtRecord
                                            .accessoriesPSN,
                                      ),
                                      focusNode: _model.textInputFocusNode3,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textInputTextController3',
                                        Duration(milliseconds: 2000),
                                        () => safeSetState(() {}),
                                      ),
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Serial Number',
                                        labelStyle: FlutterFlowTheme.of(context)
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
                                        focusedErrorBorder: OutlineInputBorder(
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
                                        suffixIcon: _model
                                                .textInputTextController3!
                                                .text
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  _model
                                                      .textInputTextController3
                                                      ?.clear();
                                                  safeSetState(() {});
                                                },
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Color(0xFF757575),
                                                  size: 22.0,
                                                ),
                                              )
                                            : null,
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
                                                      TextCapitalization.words),
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
                                        text: cTAccessoriesCtRecord
                                            .accessoriesPHolders,
                                      ),
                                      focusNode: _model.textInputFocusNode4,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textInputTextController4',
                                        Duration(milliseconds: 2000),
                                        () => safeSetState(() {}),
                                      ),
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Holders',
                                        labelStyle: FlutterFlowTheme.of(context)
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
                                        focusedErrorBorder: OutlineInputBorder(
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
                                        suffixIcon: _model
                                                .textInputTextController4!
                                                .text
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  _model
                                                      .textInputTextController4
                                                      ?.clear();
                                                  safeSetState(() {});
                                                },
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Color(0xFF757575),
                                                  size: 22.0,
                                                ),
                                              )
                                            : null,
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
                                                      TextCapitalization.words),
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
                        if (showPhantom2)
                          _phantomSection(
                            title: 'Phantom 2',
                            modelController: _model.textInputTextController8 ??=
                                TextEditingController(
                                    text: rec.accessoriesP2Modal),
                            modelFocusNode: _model.textInputFocusNode8 ??=
                                FocusNode(),
                            modelValidator:
                                _model.textInputTextController8Validator,
                            modelNoController:
                                _model.textInputTextController9 ??=
                                    TextEditingController(
                                        text: rec.accessoriesP2ModelNo),
                            modelNoFocusNode: _model.textInputFocusNode9 ??=
                                FocusNode(),
                            modelNoValidator:
                                _model.textInputTextController9Validator,
                            snController: _model.textInputTextController10 ??=
                                TextEditingController(
                                    text: rec.accessoriesP2SN),
                            snFocusNode: _model.textInputFocusNode10 ??=
                                FocusNode(),
                            snValidator:
                                _model.textInputTextController10Validator,
                            holdersController:
                                _model.textInputTextController11 ??=
                                    TextEditingController(
                                        text: rec.accessoriesP2Holders),
                            holdersFocusNode: _model.textInputFocusNode11 ??=
                                FocusNode(),
                            holdersValidator:
                                _model.textInputTextController11Validator,
                          ),
                        if (showPhantom3)
                          _phantomSection(
                            title: 'Phantom 3',
                            modelController:
                                _model.textInputTextController12 ??=
                                    TextEditingController(
                                        text: rec.accessoriesP3Modal),
                            modelFocusNode: _model.textInputFocusNode12 ??=
                                FocusNode(),
                            modelValidator:
                                _model.textInputTextController12Validator,
                            modelNoController:
                                _model.textInputTextController13 ??=
                                    TextEditingController(
                                        text: rec.accessoriesP3ModelNo),
                            modelNoFocusNode: _model.textInputFocusNode13 ??=
                                FocusNode(),
                            modelNoValidator:
                                _model.textInputTextController13Validator,
                            snController: _model.textInputTextController14 ??=
                                TextEditingController(
                                    text: rec.accessoriesP3SN),
                            snFocusNode: _model.textInputFocusNode14 ??=
                                FocusNode(),
                            snValidator:
                                _model.textInputTextController14Validator,
                            holdersController:
                                _model.textInputTextController15 ??=
                                    TextEditingController(
                                        text: rec.accessoriesP3Holders),
                            holdersFocusNode: _model.textInputFocusNode15 ??=
                                FocusNode(),
                            holdersValidator:
                                _model.textInputTextController15Validator,
                          ),
                        if (!(showPhantom2 && showPhantom3))
                          _addPhantomButton(() {
                            safeSetState(() {
                              if (!showPhantom2) {
                                _model.showPhantom2 = true;
                              } else {
                                _model.showPhantom3 = true;
                              }
                            });
                          }),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 2.0, 0.0),
                          child: Container(
                            width: 320.0,
                            child: TextFormField(
                              controller: _model.textInputTextController5 ??=
                                  TextEditingController(
                                text: cTAccessoriesCtRecord.accessoriesCDs,
                              ),
                              focusNode: _model.textInputFocusNode5,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textInputTextController5',
                                Duration(milliseconds: 2000),
                                () => safeSetState(() {}),
                              ),
                              textCapitalization: TextCapitalization.words,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'CDs',
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
                                suffixIcon: _model.textInputTextController5!
                                        .text.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          _model.textInputTextController5
                                              ?.clear();
                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF757575),
                                          size: 22.0,
                                        ),
                                      )
                                    : null,
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
                              validator: _model
                                  .textInputTextController5Validator
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
                              0.0, 0.0, 2.0, 0.0),
                          child: Container(
                            width: 320.0,
                            child: TextFormField(
                              controller: _model.textInputTextController6 ??=
                                  TextEditingController(
                                text: cTAccessoriesCtRecord.accessoriesInjector,
                              ),
                              focusNode: _model.textInputFocusNode6,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textInputTextController6',
                                Duration(milliseconds: 2000),
                                () => safeSetState(() {}),
                              ),
                              textCapitalization: TextCapitalization.words,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Injector',
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
                                suffixIcon: _model.textInputTextController6!
                                        .text.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          _model.textInputTextController6
                                              ?.clear();
                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF757575),
                                          size: 22.0,
                                        ),
                                      )
                                    : null,
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
                              validator: _model
                                  .textInputTextController6Validator
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
                              0.0, 0.0, 2.0, 0.0),
                          child: Container(
                            width: 320.0,
                            child: TextFormField(
                              controller: _model.textInputTextController7 ??=
                                  TextEditingController(
                                text: cTAccessoriesCtRecord.accessoriesSpareP,
                              ),
                              focusNode: _model.textInputFocusNode7,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textInputTextController7',
                                Duration(milliseconds: 2000),
                                () => safeSetState(() {}),
                              ),
                              textCapitalization: TextCapitalization.words,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Spare Parts',
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
                                suffixIcon: _model.textInputTextController7!
                                        .text.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          _model.textInputTextController7
                                              ?.clear();
                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: Color(0xFF757575),
                                          size: 22.0,
                                        ),
                                      )
                                    : null,
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
                              validator: _model
                                  .textInputTextController7Validator
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
                                collectionPath: 'CT',
                                docId: widget.docDataA!.id,
                                arrayFieldName: 'AccessoriesPicURL',
                                storagePathPrefix:
                                    'users/$currentUserUid/ct/accessories',
                                existingPhotoUrls: cTAccessoriesCtRecord
                                    .accessoriesPicURL
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        NotesField(
                          controller: _model.notesTextController ??=
                              TextEditingController(
                            text: cTAccessoriesCtRecord.accessoriesNotes,
                          ),
                          focusNode: _model.notesFocusNode,
                          validator: _model.notesTextControllerValidator,
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              widget.docDataA!.update(createCtRecordData(
                                accessoriesPModal:
                                    _model.textInputTextController1.text,
                                accessoriesPModelNo:
                                    _model.textInputTextController2.text,
                                accessoriesPSN:
                                    _model.textInputTextController3.text,
                                accessoriesPHolders:
                                    _model.textInputTextController4.text,
                                // Phantom 2 & 3 are only written once opened;
                                // an unopened one keeps its stored value.
                                accessoriesP2Modal:
                                    _model.textInputTextController8?.text ??
                                        cTAccessoriesCtRecord.accessoriesP2Modal,
                                accessoriesP2ModelNo: _model
                                        .textInputTextController9?.text ??
                                    cTAccessoriesCtRecord.accessoriesP2ModelNo,
                                accessoriesP2SN:
                                    _model.textInputTextController10?.text ??
                                        cTAccessoriesCtRecord.accessoriesP2SN,
                                accessoriesP2Holders: _model
                                        .textInputTextController11?.text ??
                                    cTAccessoriesCtRecord.accessoriesP2Holders,
                                accessoriesP3Modal:
                                    _model.textInputTextController12?.text ??
                                        cTAccessoriesCtRecord.accessoriesP3Modal,
                                accessoriesP3ModelNo: _model
                                        .textInputTextController13?.text ??
                                    cTAccessoriesCtRecord.accessoriesP3ModelNo,
                                accessoriesP3SN:
                                    _model.textInputTextController14?.text ??
                                        cTAccessoriesCtRecord.accessoriesP3SN,
                                accessoriesP3Holders: _model
                                        .textInputTextController15?.text ??
                                    cTAccessoriesCtRecord.accessoriesP3Holders,
                                accessoriesCDs:
                                    _model.textInputTextController5.text,
                                accessoriesInjector:
                                    _model.textInputTextController6.text,
                                accessoriesSpareP:
                                    _model.textInputTextController7.text,
                                accessoriesNotes:
                                    _model.notesTextController.text,
                              ));

                              context.pushNamed(
                                CtWidget.routeName,
                                queryParameters: {
                                  'docData': serializeParam(
                                    widget.docDataA,
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
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
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
                      ]
                          .divide(SizedBox(height: 16.0))
                          .addToStart(SizedBox(height: 20.0)),
                    )),
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
