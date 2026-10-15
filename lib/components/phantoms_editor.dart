import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '/components/photo_upload_outbox/photo_upload_outbox_widget.dart';
import '/custom_code/image_outbox/image_outbox_manager.dart';
import '/custom_code/phantoms.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

/// Holds the phantom text controllers for a page, so the page's Save button
/// can write them. Owned (and disposed) by the page model.
class PhantomsController {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};

  /// Slots the user revealed with "Add phantom" (slots holding data always
  /// show regardless).
  int revealed = 1;

  TextEditingController controllerFor(String key, String initialText) =>
      _controllers.putIfAbsent(
          key, () => TextEditingController(text: initialText));

  FocusNode focusNodeFor(String key) =>
      _focusNodes.putIfAbsent(key, () => FocusNode());

  /// Field values to save. Only fields that have been shown are included, so
  /// a phantom that was never opened keeps whatever is stored.
  Map<String, dynamic> updates() =>
      {for (final e in _controllers.entries) e.key: e.value.text};

  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    for (final f in _focusNodes.values) {
      f.dispose();
    }
  }
}

/// The phantom cards on an Accessories page: "Phantom 1" always, more on
/// demand with "Add phantom" (up to [kMaxPhantoms]), each with its own
/// text fields and photos.
class PhantomsEditor extends StatefulWidget {
  const PhantomsEditor({
    super.key,
    required this.schema,
    required this.data,
    required this.controller,
    required this.collectionPath,
    required this.docId,
    required this.storagePathPrefix,
  });

  final PhantomSchema schema;

  /// The record's raw Firestore data (record.snapshotData).
  final Map<String, dynamic> data;
  final PhantomsController controller;
  final String collectionPath;
  final String docId;

  /// Storage prefix for the page's photos; phantom N uploads under
  /// '$storagePathPrefix/phantomN'.
  final String storagePathPrefix;

  @override
  State<PhantomsEditor> createState() => _PhantomsEditorState();
}

class _PhantomsEditorState extends State<PhantomsEditor> {
  /// Highest slot with photos still queued in the offline outbox, so a
  /// phantom whose only content is not-yet-uploaded photos stays visible.
  int _pendingSlot = 0;

  @override
  void initState() {
    super.initState();
    ImageOutboxManager.instance.changes.addListener(_loadPendingSlot);
    _loadPendingSlot();
  }

  @override
  void dispose() {
    ImageOutboxManager.instance.changes.removeListener(_loadPendingSlot);
    super.dispose();
  }

  Future<void> _loadPendingSlot() async {
    if (kIsWeb) return;
    var highest = 0;
    for (var n = 1; n <= kMaxPhantoms; n++) {
      final pending = await ImageOutboxManager.instance.pendingFor(
        collectionPath: widget.collectionPath,
        docId: widget.docId,
        arrayFieldName: widget.schema.photoKey(n),
      );
      if (pending.isNotEmpty) highest = n;
    }
    if (mounted && highest != _pendingSlot) {
      setState(() => _pendingSlot = highest);
    }
  }

  @override
  Widget build(BuildContext context) {
    final schema = widget.schema;
    final count = [
      1,
      widget.controller.revealed,
      schema.lastUsedSlot(widget.data),
      _pendingSlot,
    ].reduce((a, b) => a > b ? a : b).clamp(1, kMaxPhantoms);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var n = 1; n <= count; n++) _phantomCard(n),
        if (count < kMaxPhantoms)
          _addPhantomButton(() {
            setState(() => widget.controller.revealed = count + 1);
          }),
      ].divide(SizedBox(height: 16.0)),
    );
  }

  Widget _phantomCard(int n) {
    final schema = widget.schema;
    return Container(
      width: 330.0,
      decoration: BoxDecoration(
        color: Color(0x91F0F7FF),
        borderRadius: BorderRadius.circular(24.0),
      ),
      padding: EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 5.0, 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 4.0),
            child: Text(
              'Phantom $n',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.readexPro(),
                    fontSize: 18.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          for (final field in schema.fields)
            _phantomField(
              controller: widget.controller.controllerFor(
                  field.key(n), schema.text(widget.data, n, field)),
              focusNode: widget.controller.focusNodeFor(field.key(n)),
              label: field.label,
            ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
            child: Text(
              'Photos',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.readexPro(),
                    fontSize: 15.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
            child: PhotoUploadOutboxWidget(
              key: ValueKey(schema.photoKey(n)),
              collectionPath: widget.collectionPath,
              docId: widget.docId,
              arrayFieldName: schema.photoKey(n),
              storagePathPrefix: '${widget.storagePathPrefix}/phantom$n',
              existingPhotoUrls: schema.photos(widget.data, n),
            ),
          ),
        ].divide(SizedBox(height: 16.0)),
      ),
    );
  }

  Widget _phantomField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
  }) {
    return SizedBox(
      width: 320.0,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (_) => setState(() {}),
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
          contentPadding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 0.0, 10.0),
          suffixIcon: controller.text.isNotEmpty
              ? InkWell(
                  onTap: () {
                    controller.clear();
                    setState(() {});
                  },
                  child:
                      Icon(Icons.clear, color: Color(0xFF757575), size: 22.0),
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
        inputFormatters: [
          if (!isAndroid && !isiOS)
            TextInputFormatter.withFunction((oldValue, newValue) {
              return TextEditingValue(
                selection: newValue.selection,
                text: newValue.text.toCapitalization(TextCapitalization.words),
              );
            }),
        ],
      ),
    );
  }

  /// The "+ Add phantom" button shown under the last phantom card.
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
}
