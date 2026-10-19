import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/custom_code/doc_sharing.dart';
import '/flutter_flow/flutter_flow_theme.dart';

/// Bottom sheet for sharing a report: the owner adds / removes people by
/// email; someone it's shared with sees who has access and can leave.
Future<void> showShareDocSheet(
  BuildContext context, {
  required DocumentReference reference,
  required String title,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _ShareDocSheet(reference: reference, title: title),
  );
}

class _ShareDocSheet extends StatefulWidget {
  const _ShareDocSheet({required this.reference, required this.title});

  final DocumentReference reference;
  final String title;

  @override
  State<_ShareDocSheet> createState() => _ShareDocSheetState();
}

class _ShareDocSheetState extends State<_ShareDocSheet> {
  final _email = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _add(Map<String, dynamic> data) {
    final problem = shareEmailProblem(_email.text, data);
    if (problem != null) {
      setState(() => _error = problem);
      return;
    }
    shareReport(widget.reference, _email.text);
    _email.clear();
    setState(() => _error = null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    TextStyle text(double size,
            {FontWeight weight = FontWeight.w400, Color? color}) =>
        GoogleFonts.readexPro(
            fontSize: size, fontWeight: weight, color: color ?? theme.primaryText);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 28.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: widget.reference.snapshots(),
          builder: (context, snapshot) {
            final data =
                (snapshot.data?.data() as Map<String, dynamic>?) ?? const {};
            final owner = isReportOwner(data);
            final people = sharedWithOf(data);
            final ownerEmail = reportOwnerEmail(data);

            return Column(
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
                Text('Share report', style: text(18.0, weight: FontWeight.w600)),
                const SizedBox(height: 2.0),
                Text(widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text(13.0, color: theme.secondaryText)),
                const SizedBox(height: 16.0),
                if (owner) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _add(data),
                          style: text(15.0),
                          decoration: InputDecoration(
                            hintText: 'Email address',
                            errorText: _error,
                            errorMaxLines: 2,
                            filled: true,
                            fillColor: const Color(0xFFF0F7FF),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide:
                                  const BorderSide(color: Color(0xFFE0E3E7)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide:
                                  const BorderSide(color: Color(0xFFE0E3E7)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        height: 46.0,
                        child: ElevatedButton(
                          onPressed: () => _add(data),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                          ),
                          child: Text('Share',
                              style: text(15.0,
                                  weight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'They\'ll see this report in their list when they sign in '
                    'with that email, and can edit it with you.',
                    style: text(12.5, color: theme.secondaryText),
                  ),
                ] else if (ownerEmail.isNotEmpty)
                  Text('Shared with you by $ownerEmail',
                      style: text(14.0, color: theme.secondaryText)),
                const SizedBox(height: 16.0),
                Text('People with access',
                    style: text(14.0, weight: FontWeight.w600)),
                const SizedBox(height: 4.0),
                _PersonRow(
                  email: owner ? '$myShareEmail (you)' : ownerEmail,
                  role: 'Owner',
                ),
                for (final p in people)
                  _PersonRow(
                    email: p == myShareEmail ? '$p (you)' : p,
                    role: 'Can edit',
                    onRemove: owner ? () => unshareReport(widget.reference, p) : null,
                  ),
                if (!owner) ...[
                  const SizedBox(height: 12.0),
                  TextButton.icon(
                    onPressed: () {
                      leaveReport(widget.reference);
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.logout_rounded, color: theme.error),
                    label: Text('Leave this report',
                        style: text(15.0,
                            weight: FontWeight.w500, color: theme.error)),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PersonRow extends StatelessWidget {
  const _PersonRow({required this.email, required this.role, this.onRemove});

  final String email;
  final String role;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16.0,
            backgroundColor: const Color(0xFFF0F7FF),
            child: Text(
              email.isEmpty ? '?' : email[0].toUpperCase(),
              style: GoogleFonts.readexPro(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: theme.primary),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(email.isEmpty ? 'Unknown' : email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.readexPro(
                        fontSize: 14.5, color: theme.primaryText)),
                Text(role,
                    style: GoogleFonts.readexPro(
                        fontSize: 12.0, color: theme.secondaryText)),
              ],
            ),
          ),
          if (onRemove != null)
            IconButton(
              tooltip: 'Remove access',
              icon: Icon(Icons.close_rounded, color: theme.secondaryText),
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}
