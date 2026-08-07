import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '/custom_code/image_outbox/image_outbox_manager.dart';
import '/flutter_flow/flutter_flow_model.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/upload_data.dart';
import 'photo_gallery_view.dart';
import 'photo_upload_outbox_model.dart';
export 'photo_upload_outbox_model.dart';

/// Shared photo-upload component used by pages that attach photos to a
/// Firestore record. Owns picking + queuing the photo for background upload
/// (via ImageOutboxManager), rendering both uploaded and still-pending
/// photos, and per-photo / bulk removal. It does NOT save any of the host
/// page's other fields, so a page's text fields keep saving immediately.
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

/// A photo still queued for upload, with its locally-cached bytes for preview.
class _PendingPhoto {
  const _PendingPhoto(this.id, this.bytes);
  final int id;
  final Uint8List bytes;
}

class _PhotoUploadOutboxWidgetState extends State<PhotoUploadOutboxWidget> {
  late PhotoUploadOutboxModel _model;

  List<_PendingPhoto> _pending = [];
  bool _isPicking = false;
  bool _selectionMode = false;
  final Set<String> _selectedUrls = {};
  final Set<int> _selectedPendingIds = {};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhotoUploadOutboxModel());
    ImageOutboxManager.instance.changes.addListener(_onOutboxChanged);
    _loadPending();
  }

  @override
  void didUpdateWidget(PhotoUploadOutboxWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.docId != widget.docId ||
        oldWidget.collectionPath != widget.collectionPath ||
        oldWidget.arrayFieldName != widget.arrayFieldName) {
      _loadPending();
    }
  }

  @override
  void dispose() {
    ImageOutboxManager.instance.changes.removeListener(_onOutboxChanged);
    _model.maybeDispose();
    super.dispose();
  }

  void _onOutboxChanged() => _loadPending();

  /// Rebuilds the local-preview list from the outbox: the durable source of
  /// truth for photos queued offline. This is what makes a just-added photo
  /// show up immediately with no signal, and vanish once it has uploaded.
  Future<void> _loadPending() async {
    if (kIsWeb) return;
    final items = await ImageOutboxManager.instance.pendingFor(
      collectionPath: widget.collectionPath,
      docId: widget.docId,
      arrayFieldName: widget.arrayFieldName,
    );
    final loaded = <_PendingPhoto>[];
    for (final item in items) {
      final bytes = await ImageOutboxManager.instance.readPendingBytes(item);
      if (bytes != null) loaded.add(_PendingPhoto(item.id, bytes));
    }
    if (!mounted) return;
    setState(() {
      _pending = loaded;
      // Drop selections whose photos no longer exist.
      final liveIds = loaded.map((p) => p.id).toSet();
      _selectedPendingIds.retainWhere(liveIds.contains);
      _selectedUrls.retainWhere(widget.existingPhotoUrls.contains);
      if (_selectedUrls.isEmpty && _selectedPendingIds.isEmpty) {
        _selectionMode = false;
      }
    });
  }

  Future<void> _pickAndQueue() async {
    final selected = await selectMediaWithSourceBottomSheet(
      context: context,
      storageFolderPath: widget.storagePathPrefix,
      allowPhoto: true,
    );
    final file = selected?.firstOrNull;
    if (file == null) return;

    setState(() => _isPicking = true);
    await ImageOutboxManager.instance.enqueue(
      bytes: file.bytes,
      storagePath: file.storagePath,
      collectionPath: widget.collectionPath,
      docId: widget.docId,
      arrayFieldName: widget.arrayFieldName,
    );
    if (mounted) setState(() => _isPicking = false);
  }

  List<GalleryPhoto> _galleryPhotos() => [
        ...widget.existingPhotoUrls.map(GalleryPhoto.url),
        ..._pending.map((p) => GalleryPhoto.bytes(p.bytes)),
      ];

  void _toggle({String? url, _PendingPhoto? pending}) {
    setState(() {
      if (pending != null) {
        _selectedPendingIds.contains(pending.id)
            ? _selectedPendingIds.remove(pending.id)
            : _selectedPendingIds.add(pending.id);
      } else if (url != null) {
        _selectedUrls.contains(url)
            ? _selectedUrls.remove(url)
            : _selectedUrls.add(url);
      }
      if (_selectedUrls.isEmpty && _selectedPendingIds.isEmpty) {
        _selectionMode = false;
      }
    });
  }

  void _enterSelection({String? url, _PendingPhoto? pending}) {
    setState(() => _selectionMode = true);
    _toggle(url: url, pending: pending);
  }

  /// Detaches an uploaded photo from the record and queues its Storage file
  /// for deletion. The Firestore write is NOT awaited: offline it persists to
  /// the local cache immediately (so the thumbnail disappears at once) and
  /// syncs on reconnect, while awaiting it would hang with no signal.
  void _removeUploaded(String url) {
    FirebaseFirestore.instance
        .collection(widget.collectionPath)
        .doc(widget.docId)
        .update({
      widget.arrayFieldName: FieldValue.arrayRemove([url]),
    });
    ImageOutboxManager.instance.enqueueDeletion(url);
  }

  Future<void> _removeSelected() async {
    final count = _selectedUrls.length + _selectedPendingIds.length;
    if (count == 0) return;
    final confirmed = await _confirmRemove(count);
    if (confirmed != true) return;

    for (final url in _selectedUrls.toList()) {
      _removeUploaded(url);
    }
    for (final id in _selectedPendingIds.toList()) {
      await ImageOutboxManager.instance.removePending(id);
    }
    if (!mounted) return;
    setState(() {
      _selectedUrls.clear();
      _selectedPendingIds.clear();
      _selectionMode = false;
    });
  }

  Future<void> _removeSingle({String? url, _PendingPhoto? pending}) async {
    final confirmed = await _confirmRemove(1);
    if (confirmed != true) return;
    if (pending != null) {
      await ImageOutboxManager.instance.removePending(pending.id);
    } else if (url != null) {
      _removeUploaded(url);
    }
  }

  Future<bool?> _confirmRemove(int count) => showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(count == 1 ? 'Remove photo?' : 'Remove $count photos?'),
          content: const Text(
              'This permanently deletes the photo and can\'t be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Remove'),
            ),
          ],
        ),
      );

  Future<void> _shareSelected() async {
    if (_selectedUrls.isEmpty && _selectedPendingIds.isEmpty) return;
    final tempDir = await getTemporaryDirectory();
    final files = <XFile>[];

    for (final id in _selectedPendingIds) {
      final p = _pending.firstWhereOrNull((e) => e.id == id);
      if (p == null) continue;
      final f = File('${tempDir.path}/photo_$id.jpg');
      await f.writeAsBytes(p.bytes, flush: true);
      files.add(XFile(f.path, mimeType: 'image/jpeg'));
    }
    for (final url in _selectedUrls) {
      try {
        final cached = await DefaultCacheManager().getSingleFile(url);
        files.add(XFile(cached.path));
      } catch (_) {
        // Not cached and can't download (offline) — skip this one.
      }
    }

    if (files.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Photos aren\'t available to share offline yet.'),
        ));
      }
      return;
    }
    await SharePlus.instance.share(ShareParams(
      files: files,
      sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100),
    ));
    if (mounted) {
      setState(() {
        _selectedUrls.clear();
        _selectedPendingIds.clear();
        _selectionMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final urls = widget.existingPhotoUrls;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_selectionMode) _selectionBar(context),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ...urls.mapIndexed((i, url) => _thumb(
                  context,
                  galleryIndex: i,
                  url: url,
                )),
            ..._pending.mapIndexed((j, p) => _thumb(
                  context,
                  galleryIndex: urls.length + j,
                  pending: p,
                )),
            if (!_selectionMode) _addButton(context),
          ],
        ),
      ],
    );
  }

  Widget _selectionBar(BuildContext context) {
    final count = _selectedUrls.length + _selectedPendingIds.length;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Cancel',
            onPressed: () => setState(() {
              _selectionMode = false;
              _selectedUrls.clear();
              _selectedPendingIds.clear();
            }),
          ),
          Text(
            '$count selected',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.ios_share),
            tooltip: 'Share',
            onPressed: count == 0 ? null : _shareSelected,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Remove',
            color: Colors.red,
            onPressed: count == 0 ? null : _removeSelected,
          ),
        ],
      ),
    );
  }

  Widget _thumb(
    BuildContext context, {
    required int galleryIndex,
    String? url,
    _PendingPhoto? pending,
  }) {
    final isPending = pending != null;
    final selected = isPending
        ? _selectedPendingIds.contains(pending.id)
        : _selectedUrls.contains(url);
    final primary = FlutterFlowTheme.of(context).primary;

    return GestureDetector(
      onTap: () {
        if (_selectionMode) {
          _toggle(url: url, pending: pending);
        } else {
          showPhotoGallery(
            context,
            photos: _galleryPhotos(),
            initialIndex: galleryIndex,
          );
        }
      },
      onLongPress: () => _enterSelection(url: url, pending: pending),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: selected ? Border.all(color: primary, width: 3.0) : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                width: 80.0,
                height: 80.0,
                child: isPending
                    ? Image.memory(pending.bytes, fit: BoxFit.cover)
                    : CachedNetworkImage(
                        imageUrl: url!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                        errorWidget: (_, __, ___) => const Icon(
                          Icons.broken_image_outlined,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
          ),
          // "Waiting to upload" badge for pending photos.
          if (isPending)
            Positioned(
              left: 4.0,
              bottom: 4.0,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  Icons.cloud_upload_outlined,
                  color: Colors.white,
                  size: 13.0,
                ),
              ),
            ),
          // Selection tick, or a remove (x) button in normal mode.
          if (_selectionMode)
            Positioned(
              top: 2.0,
              left: 2.0,
              child: Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? primary : Colors.white,
                size: 22.0,
              ),
            )
          else
            Positioned(
              top: -6.0,
              right: -6.0,
              child: GestureDetector(
                onTap: () => _removeSingle(url: url, pending: pending),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(2.0),
                  child: const Icon(Icons.close, color: Colors.white, size: 16.0),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    if (_isPicking) {
      return SizedBox(
        width: 48.0,
        height: 48.0,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              FlutterFlowTheme.of(context).primary,
            ),
          ),
        ),
      );
    }
    return IconButton(
      onPressed: _pickAndQueue,
      icon: Icon(
        Icons.add_a_photo,
        color: FlutterFlowTheme.of(context).primary,
      ),
    );
  }
}
