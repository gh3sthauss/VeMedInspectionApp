import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// A reusable multi-line "Notes" input styled to match the app's form fields.
///
/// Subpages that previously had no free-text area use this so every category
/// (Gantry, Cooling System, Patient Table, …) can carry inspector notes that
/// also flow into the PDF report. Kept in one place so the styling and
/// behaviour stay identical across all modalities.
class NotesField extends StatelessWidget {
  const NotesField({
    super.key,
    required this.controller,
    this.focusNode,
    this.validator,
    this.label = 'Notes',
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(BuildContext, String?)? validator;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
      child: Container(
        width: 320.0,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          textCapitalization: TextCapitalization.sentences,
          obscureText: false,
          minLines: 3,
          maxLines: 6,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            labelText: label,
            alignLabelWithHint: true,
            hintText: ' ',
            labelStyle: theme.bodyMedium.override(
              font: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.normal,
                fontStyle: theme.bodyMedium.fontStyle,
              ),
              color: const Color(0xFF14181B),
              fontSize: 16.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.normal,
              fontStyle: theme.bodyMedium.fontStyle,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE0E3E7), width: 1.0),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF4B39EF), width: 1.0),
              borderRadius: BorderRadius.circular(16.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFF5963), width: 1.0),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFF5963), width: 1.0),
              borderRadius: BorderRadius.circular(16.0),
            ),
            filled: true,
            fillColor: const Color(0xFFF0F7FF),
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
          ),
          style: theme.bodyMedium.override(
            font: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.normal,
              fontStyle: theme.bodyMedium.fontStyle,
            ),
            color: const Color(0xFF14181B),
            fontSize: 16.0,
            letterSpacing: 0.0,
            fontWeight: FontWeight.normal,
            fontStyle: theme.bodyMedium.fontStyle,
          ),
          validator: validator?.asValidator(context),
          inputFormatters: [
            if (!isAndroid && !isiOS)
              TextInputFormatter.withFunction((oldValue, newValue) {
                return TextEditingValue(
                  selection: newValue.selection,
                  text: newValue.text
                      .toCapitalization(TextCapitalization.sentences),
                );
              }),
          ],
        ),
      ),
    );
  }
}
