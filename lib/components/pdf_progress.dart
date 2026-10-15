import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';

BuildContext? _progressContext;
// False once closing was requested, even if the dialog hadn't built yet.
bool _progressWanted = false;

/// Shows a blocking "Preparing PDF…" overlay while [task] runs. The exporter
/// closes it with [closePdfProgress] right before the share sheet opens; it
/// is also closed when [task] ends or fails.
Future<void> withPdfProgress(
  BuildContext context,
  Future<void> Function() task,
) async {
  closePdfProgress();
  _progressWanted = true;
  showDialog<void>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (dialogContext) {
      _progressContext = dialogContext;
      if (!_progressWanted) {
        // Closed before it got on screen: take it straight down again.
        WidgetsBinding.instance
            .addPostFrameCallback((_) => closePdfProgress());
      }
      return PopScope(
        canPop: false,
        child: Center(
          child: Material(
            color: FlutterFlowTheme.of(dialogContext).secondaryBackground,
            borderRadius: BorderRadius.circular(20.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 28.0, vertical: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 36.0,
                    height: 36.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(dialogContext).primary),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Preparing PDF…',
                    style: FlutterFlowTheme.of(dialogContext)
                        .bodyMedium
                        .override(
                          font: GoogleFonts.readexPro(),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'This can take a few seconds',
                    style: FlutterFlowTheme.of(dialogContext)
                        .bodySmall
                        .override(
                          font: GoogleFonts.readexPro(),
                          color:
                              FlutterFlowTheme.of(dialogContext).secondaryText,
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  try {
    await task();
  } finally {
    closePdfProgress();
  }
}

/// Closes the "Preparing PDF…" overlay if it is showing.
void closePdfProgress() {
  _progressWanted = false;
  final ctx = _progressContext;
  _progressContext = null;
  // Only while the overlay is still the top route, so a rebuild during its
  // closing animation can never pop the page underneath.
  if (ctx != null && ctx.mounted && (ModalRoute.of(ctx)?.isCurrent ?? false)) {
    Navigator.of(ctx).pop();
  }
}
