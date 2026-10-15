import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/components/photo_upload_outbox/photo_upload_outbox_widget.dart';
import '/custom_code/subsection_photos.dart';
import '/flutter_flow/flutter_flow_theme.dart';

/// "Pictures" for one card on a page (IRS, a coil, a cassette, ...), stored
/// in that card's own photo field.
class SubsectionPhotosField extends StatelessWidget {
  const SubsectionPhotosField({
    super.key,
    required this.field,
    required this.data,
    required this.collectionPath,
    required this.docId,
    required this.storagePathPrefix,
  });

  final SubsectionPhotoField field;

  /// The record's raw Firestore data (record.snapshotData).
  final Map<String, dynamic> data;
  final String collectionPath;
  final String docId;
  final String storagePathPrefix;

  @override
  Widget build(BuildContext context) {
    // Laid out like the existing in-card "Pictures" (Console / Workstation).
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
          child: Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Text(
              'Pictures',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.readexPro(),
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 8.0, 10.0, 0.0),
          child: PhotoUploadOutboxWidget(
            key: ValueKey(field.key),
            collectionPath: collectionPath,
            docId: docId,
            arrayFieldName: field.key,
            storagePathPrefix: storagePathPrefix,
            existingPhotoUrls: subsectionPhotos(data, field.key),
          ),
        ),
      ],
    );
  }
}
