import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart';

/// One photo in the gallery: either an uploaded Storage [url] or the local
/// [bytes] of a photo still queued for upload.
class GalleryPhoto {
  const GalleryPhoto.url(this.url) : bytes = null;
  const GalleryPhoto.bytes(this.bytes) : url = null;

  final String? url;
  final Uint8List? bytes;

  bool get isPending => bytes != null;
}

/// Opens the fullscreen swipeable gallery for [photos], starting at
/// [initialIndex]. Supports swipe between photos and pinch-to-zoom.
Future<void> showPhotoGallery(
  BuildContext context, {
  required List<GalleryPhoto> photos,
  int initialIndex = 0,
}) {
  if (photos.isEmpty) return Future.value();
  return Navigator.of(context, rootNavigator: true).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => _PhotoGalleryView(
        photos: photos,
        initialIndex: initialIndex.clamp(0, photos.length - 1),
      ),
    ),
  );
}

class _PhotoGalleryView extends StatefulWidget {
  const _PhotoGalleryView({required this.photos, required this.initialIndex});

  final List<GalleryPhoto> photos;
  final int initialIndex;

  @override
  State<_PhotoGalleryView> createState() => _PhotoGalleryViewState();
}

class _PhotoGalleryViewState extends State<_PhotoGalleryView> {
  late final PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          '${_index + 1} / ${widget.photos.length}',
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.photos.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (context, i) {
          final photo = widget.photos[i];
          return Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 5.0,
                  child: photo.isPending
                      ? Image.memory(photo.bytes!, fit: BoxFit.contain)
                      : CachedNetworkImage(
                          imageUrl: photo.url!,
                          fit: BoxFit.contain,
                          placeholder: (_, __) => const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          errorWidget: (_, __, ___) => const Icon(
                            Icons.broken_image_outlined,
                            color: Colors.white54,
                            size: 48.0,
                          ),
                        ),
                ),
              ),
              if (photo.isPending)
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 24.0,
                  child: _PendingBadge(),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _PendingBadge extends StatelessWidget {
  const _PendingBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_upload_outlined, color: Colors.white, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              'Waiting to upload',
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            ),
          ],
        ),
      ),
    );
  }
}
