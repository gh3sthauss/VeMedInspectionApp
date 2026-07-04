import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '/custom_code/image_outbox/image_outbox_manager.dart';
import '/flutter_flow/flutter_flow_model.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/upload_data.dart';
import 'photo_upload_outbox_model.dart';
export 'photo_upload_outbox_model.dart';

/// Shared photo-upload component used by pages that attach photos to a
/// Firestore record. Owns only picking + queuing the photo for background
/// upload (via ImageOutboxManager) and showing a local preview while it's
/// pending - it does NOT save any of the host page's other fields. That way
/// a page's text fields keep saving immediately (via Firestore's own offline
/// persistence) even if the photo hasn't finished uploading yet.
class PhotoUploadOutboxWidget extends StatefulWidget {
  const PhotoUploadOutboxWidget({
    super.key,
    required this.collectionPath,
    required this.docId,
    required this.arrayFieldName,
    required this.storagePathPrefix,
    this.existingPhotoUrls = const [],
  });

  /// Firestore collection the target document lives in, e.g. 'CT'.
  final String collectionPath;

  /// Firestore document id to patch once the photo finishes uploading.
  final String docId;

  /// Array field on that document to append the download URL to.
  final String arrayFieldName;

  /// Firebase Storage path prefix new photos are uploaded under.
  final String storagePathPrefix;

  /// Photo URLs already saved on the document, passed down by the host's
  /// own StreamBuilder so newly-synced photos appear automatically.
  final List<String> existingPhotoUrls;

  @override
  State<PhotoUploadOutboxWidget> createState() =>
      _PhotoUploadOutboxWidgetState();
}

class _PhotoUploadOutboxWidgetState extends State<PhotoUploadOutboxWidget> {
  late PhotoUploadOutboxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhotoUploadOutboxModel());
  }

  @override
  void didUpdateWidget(PhotoUploadOutboxWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Once the doc's photo list grows, the background upload succeeded and
    // the real photo is now shown via existingPhotoUrls - drop the local
    // placeholder preview so it doesn't show twice.
    if (widget.existingPhotoUrls.length > oldWidget.existingPhotoUrls.length) {
      setState(() => _model.pendingLocalPreview = null);
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Future<void> _pickAndQueue() async {
    final selected = await selectMediaWithSourceBottomSheet(
      context: context,
      storageFolderPath: widget.storagePathPrefix,
      allowPhoto: true,
    );
    final file = selected?.firstOrNull;
    if (file == null) return;

    setState(() {
      _model.pendingLocalPreview = file.bytes;
      _model.isEnqueuing = true;
    });

    await ImageOutboxManager.instance.enqueue(
      bytes: file.bytes,
      storagePath: file.storagePath,
      collectionPath: widget.collectionPath,
      docId: widget.docId,
      arrayFieldName: widget.arrayFieldName,
    );

    if (mounted) {
      setState(() => _model.isEnqueuing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...widget.existingPhotoUrls.map(
          (url) => ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: url,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (_model.pendingLocalPreview != null)
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.memory(
                  _model.pendingLocalPreview!,
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                ),
              ),
              if (_model.isEnqueuing)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
            ],
          ),
        IconButton(
          onPressed: _pickAndQueue,
          icon: Icon(
            Icons.add_a_photo,
            color: FlutterFlowTheme.of(context).primary,
          ),
        ),
      ],
    );
  }
}
