import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Slim header for sub-pages: back arrow + title, replacing the full
/// logo lockup that used to be pinned to the top of every category page.
class CompactAppBar extends StatelessWidget {
  const CompactAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(4.0, 12.0, 16.0, 12.0),
      child: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.arrow_back_rounded,
                color: theme.primaryText,
                size: 22.0,
              ),
            ),
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: theme.primaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
