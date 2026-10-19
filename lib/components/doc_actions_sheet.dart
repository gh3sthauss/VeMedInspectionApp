import '/components/share_doc_sheet.dart';
import '/custom_code/doc_sharing.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Bottom sheet with Download / Share / Delete actions for a single document
/// row, replacing the pair of icon buttons previously placed directly on the
/// card face. Given the report's [reference] and raw [data], it offers
/// sharing, and for a report someone else shared with you it shows "Leave"
/// instead of "Delete".
Future<void> showDocActionsSheet(
  BuildContext context, {
  required String title,
  required Future<void> Function() onDownload,
  required Future<void> Function() onDelete,
  DocumentReference? reference,
  Map<String, dynamic>? data,
}) {
  final owner = data == null || isReportOwner(data);
  final theme = FlutterFlowTheme.of(context);
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return Container(
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 28.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.0,
                height: 4.0,
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: theme.alternate,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Readex Pro',
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: theme.secondaryText,
              ),
            ),
            const SizedBox(height: 8.0),
            _ActionRow(
              icon: Icons.download_rounded,
              label: 'Download',
              iconColor: theme.primary,
              onTap: () async {
                Navigator.of(sheetContext).pop();
                await onDownload();
              },
            ),
            if (reference != null)
              _ActionRow(
                icon: Icons.person_add_alt_1_rounded,
                label: 'Share',
                iconColor: theme.primary,
                onTap: () async {
                  Navigator.of(sheetContext).pop();
                  await showShareDocSheet(context,
                      reference: reference, title: title);
                },
              ),
            if (owner)
              _ActionRow(
                icon: Icons.delete_outline_rounded,
                label: 'Delete',
                iconColor: theme.error,
                labelColor: theme.error,
                onTap: () async {
                  Navigator.of(sheetContext).pop();
                  await onDelete();
                },
              )
            else
              _ActionRow(
                icon: Icons.logout_rounded,
                label: 'Leave (remove from my list)',
                iconColor: theme.error,
                labelColor: theme.error,
                onTap: () async {
                  Navigator.of(sheetContext).pop();
                  leaveReport(reference!);
                },
              ),
          ],
        ),
      );
    },
  );
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
    this.labelColor,
  });

  final IconData icon;
  final String label;
  final Color iconColor;
  final Color? labelColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22.0),
            const SizedBox(width: 16.0),
            Text(
              label,
              style: GoogleFonts.readexPro(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: labelColor ?? theme.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
