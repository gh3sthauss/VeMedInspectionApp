import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/custom_code/doc_sharing.dart';
import '/flutter_flow/flutter_flow_theme.dart';

/// A report row's name, plus a small "Shared by …" / "Shared with N" line
/// when the report is shared.
class DocRowTitle extends StatelessWidget {
  const DocRowTitle({super.key, required this.title, required this.data});

  final String title;

  /// The report's raw Firestore data (record.snapshotData).
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final people = sharedWithOf(data);
    final String? subtitle;
    if (!isReportOwner(data)) {
      final by = reportOwnerEmail(data);
      subtitle = by.isEmpty ? 'Shared with you' : 'Shared by $by';
    } else if (people.isNotEmpty) {
      subtitle = people.length == 1
          ? 'Shared with ${people.first}'
          : 'Shared with ${people.length} people';
    } else {
      subtitle = null;
    }

    final name = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.readexPro(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: theme.primaryText,
      ),
    );
    if (subtitle == null) return name;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        name,
        const SizedBox(height: 2.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_alt_outlined, size: 14.0, color: theme.primary),
            const SizedBox(width: 4.0),
            Flexible(
              child: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.readexPro(
                    fontSize: 12.0, color: theme.secondaryText),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
