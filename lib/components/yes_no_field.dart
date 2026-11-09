import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';

/// A labelled Yes/No selection. [value] is 'Yes', 'No' or '' (not answered);
/// tapping the selected option again clears it.
class YesNoField extends StatelessWidget {
  const YesNoField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    Widget option(String text) {
      final selected = value == text;
      return Expanded(
        child: Semantics(
          button: true,
          selected: selected,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onChanged(selected ? '' : text),
            child: Container(
              height: 40.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? theme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Text(
                text,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : const Color(0xFF14181B),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: 320.0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F7FF),
          border: Border.all(color: const Color(0xFFE0E3E7)),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.0, color: const Color(0xFF14181B)),
              ),
            ),
            SizedBox(
              width: 130.0,
              child: Row(children: [option('Yes'), option('No')]),
            ),
          ],
        ),
      ),
    );
  }
}
