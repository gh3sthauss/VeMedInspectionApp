import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:video_player/video_player.dart';

import '../auth/firebase_auth/auth_util.dart';
import '/components/photo_upload_outbox/multi_capture_camera_page.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow_util.dart';

const allowedFormats = {'image/png', 'image/jpeg', 'video/mp4', 'image/gif'};

class SelectedFile {
  const SelectedFile({
    this.storagePath = '',
    this.filePath,
    required this.bytes,
    this.dimensions,
    this.blurHash,
    this.originalFilename = '',
  });
  final String storagePath;
  final String? filePath;
  final Uint8List bytes;
  final MediaDimensions? dimensions;
  final String? blurHash;
  final String originalFilename;
}

class MediaDimensions {
  const MediaDimensions({
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
}

enum MediaSource {
  photoGallery,
  videoGallery,
  camera,
}

Future<List<SelectedFile>?> selectMediaWithSourceBottomSheet({
  required BuildContext context,
  String? storageFolderPath,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  required bool allowPhoto,
  bool allowVideo = false,
  String pickerFontFamily = 'Roboto',
  Color textColor = const Color(0xFF111417),
  Color backgroundColor = const Color(0xFFF5F5F5),
  bool includeDimensions = false,
  bool includeBlurHash = false,
}) async {
  final createUploadMediaListTile =
      (String label, MediaSource mediaSource) => ListTile(
            title: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                pickerFontFamily,
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            tileColor: backgroundColor,
            dense: false,
            onTap: () => Navigator.pop(
              context,
              mediaSource,
            ),
          );
  final mediaSource = await showModalBottomSheet<MediaSource>(
      context: context,
      backgroundColor: backgroundColor,
      builder: (context) {
        return SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!kIsWeb) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: ListTile(
                    title: Text(
                      'Choose Source',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        pickerFontFamily,
                        color: textColor.applyAlpha(0.65),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    tileColor: backgroundColor,
                    dense: false,
                  ),
                ),
                const Divider(),
              ],
              if (allowPhoto && allowVideo) ...[
                createUploadMediaListTile(
                  'Gallery (Photo)',
                  MediaSource.photoGallery,
                ),
                const Divider(),
                createUploadMediaListTile(
                  'Gallery (Video)',
                  MediaSource.videoGallery,
                ),
              ] else if (allowPhoto)
                createUploadMediaListTile(
                  'Gallery',
                  MediaSource.photoGallery,
                )
              else
                createUploadMediaListTile(
                  'Gallery',
                  MediaSource.videoGallery,
                ),
              if (!kIsWeb) ...[
                const Divider(),
                createUploadMediaListTile('Camera', MediaSource.camera),
                const Divider(),
              ],
              const SizedBox(height: 10),
            ],
          ),
        );
      });
  if (mediaSource == null) {
    return null;
  }
  // Camera (photo): open a live multi-capture camera so the user can take
  // several photos in one session and confirm them all at once, instead of
  // image_picker's one-shot flow that forces a "Use Photo" tap after every
  // single picture.
  if (mediaSource == MediaSource.camera && allowPhoto && !allowVideo) {
    if (!context.mounted) return null;
    final shots = await Navigator.of(context).push<List<XFile>>(
      MaterialPageRoute(builder: (_) => const MultiCaptureCameraPage()),
    );
    if (shots == null || shots.isEmpty) return null;
    return _selectedFilesFromCapturedPhotos(
      shots,
      storageFolderPath: storageFolderPath,
      includeDimensions: includeDimensions,
    );
  }
  return selectMedia(
    storageFolderPath: storageFolderPath,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
    isVideo: mediaSource == MediaSource.videoGallery ||
        (mediaSource == MediaSource.camera && allowVideo && !allowPhoto),
    mediaSource: mediaSource,
    // Let the gallery return several photos at once, matching the camera's
    // multi-capture behaviour.
    multiImage: mediaSource == MediaSource.photoGallery,
    includeDimensions: includeDimensions,
    includeBlurHash: includeBlurHash,
  );
}

/// Turns the photos captured by [MultiCaptureCameraPage] into [SelectedFile]s.
/// Reads them one at a time so several full-resolution shots don't all sit in
/// memory at once.
Future<List<SelectedFile>?> _selectedFilesFromCapturedPhotos(
  List<XFile> shots, {
  String? storageFolderPath,
  bool includeDimensions = false,
}) async {
  final captured = <SelectedFile>[];
  for (final shot in shots) {
    final bytes = await shot.readAsBytes();
    final path =
        _getStoragePath(storageFolderPath, shot.name, false, captured.length);
    final dimensions =
        includeDimensions ? await _getImageDimensions(bytes) : null;
    captured.add(SelectedFile(
      storagePath: path,
      filePath: shot.path,
      bytes: bytes,
      dimensions: dimensions,
      originalFilename: shot.name,
    ));
  }
  return captured.isEmpty ? null : captured;
}

Future<List<SelectedFile>?> selectMedia({
  String? storageFolderPath,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  bool isVideo = false,
  MediaSource mediaSource = MediaSource.camera,
  bool multiImage = false,
  bool includeDimensions = false,
  bool includeBlurHash = false,
}) async {
  final picker = ImagePicker();

  if (multiImage) {
    final pickedMediaFuture = picker.pickMultiImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    final pickedMedia = await pickedMediaFuture;
    if (pickedMedia.isEmpty) {
      return null;
    }
    // Read each picked photo one at a time rather than all at once. Reading
    // several full-resolution photos into memory in parallel spikes RAM hard
    // enough for iOS to jetsam-kill the app; sequential reads keep the peak to
    // a single photo's worth.
    final selectedFiles = <SelectedFile>[];
    for (final entry in pickedMedia.asMap().entries) {
      final index = entry.key;
      final media = entry.value;
      final mediaBytes = await media.readAsBytes();
      final path = _getStoragePath(storageFolderPath, media.name, false, index);
      final dimensions = includeDimensions
          ? isVideo
              ? await _getVideoDimensions(media.path)
              : await _getImageDimensions(mediaBytes)
          : null;

      selectedFiles.add(SelectedFile(
        storagePath: path,
        filePath: media.path,
        bytes: mediaBytes,
        dimensions: dimensions,
        originalFilename: media.name,
      ));
    }
    return selectedFiles;
  }

  final source = mediaSource == MediaSource.camera
      ? ImageSource.camera
      : ImageSource.gallery;
  final pickedMediaFuture = isVideo
      ? picker.pickVideo(source: source)
      : picker.pickImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: imageQuality,
          source: source,
        );
  final pickedMedia = await pickedMediaFuture;
  final mediaBytes = await pickedMedia?.readAsBytes();
  if (mediaBytes == null) {
    return null;
  }
  final path = _getStoragePath(storageFolderPath, pickedMedia!.name, isVideo);
  final dimensions = includeDimensions
      ? isVideo
          ? _getVideoDimensions(pickedMedia.path)
          : _getImageDimensions(mediaBytes)
      : null;

  return [
    SelectedFile(
      storagePath: path,
      filePath: pickedMedia.path,
      bytes: mediaBytes,
      dimensions: await dimensions,
      originalFilename: pickedMedia.name,
    ),
  ];
}

bool validateFileFormat(String filePath, BuildContext context) {
  if (allowedFormats.contains(mime(filePath))) {
    return true;
  }
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text('Invalid file format: ${mime(filePath)}'),
    ));
  return false;
}

Future<SelectedFile?> selectFile({
  String? storageFolderPath,
  List<String>? allowedExtensions,
}) =>
    selectFiles(
      storageFolderPath: storageFolderPath,
      allowedExtensions: allowedExtensions,
      multiFile: false,
    ).then((value) => value?.first);

Future<List<SelectedFile>?> selectFiles({
  String? storageFolderPath,
  List<String>? allowedExtensions,
  bool multiFile = false,
}) async {
  final pickedFiles = await FilePicker.platform.pickFiles(
    type: allowedExtensions != null ? FileType.custom : FileType.any,
    allowedExtensions: allowedExtensions,
    withData: true,
    allowMultiple: multiFile,
  );
  if (pickedFiles == null || pickedFiles.files.isEmpty) {
    return null;
  }
  if (multiFile) {
    return Future.wait(pickedFiles.files.asMap().entries.map((e) async {
      final index = e.key;
      final file = e.value;
      final storagePath =
          _getStoragePath(storageFolderPath, file.name, false, index);
      return SelectedFile(
        storagePath: storagePath,
        filePath: isWeb ? null : file.path,
        bytes: file.bytes!,
        originalFilename: file.name,
      );
    }));
  }
  final file = pickedFiles.files.first;
  if (file.bytes == null) {
    return null;
  }
  final storagePath = _getStoragePath(storageFolderPath, file.name, false);
  return [
    SelectedFile(
      storagePath: storagePath,
      filePath: isWeb ? null : file.path,
      bytes: file.bytes!,
      originalFilename: file.name,
    )
  ];
}

List<SelectedFile> selectedFilesFromUploadedFiles(
  List<FFUploadedFile> uploadedFiles, {
  String? storageFolderPath,
  bool isMultiData = false,
}) =>
    uploadedFiles.asMap().entries.map(
      (entry) {
        final index = entry.key;
        final file = entry.value;
        return SelectedFile(
            storagePath: _getStoragePath(
              storageFolderPath != null ? storageFolderPath : null,
              file.name!,
              false,
              isMultiData ? index : null,
            ),
            bytes: file.bytes!,
            originalFilename: file.originalFilename);
      },
    ).toList();

Future<MediaDimensions> _getImageDimensions(Uint8List mediaBytes) async {
  final image = await decodeImageFromList(mediaBytes);
  return MediaDimensions(
    width: image.width.toDouble(),
    height: image.height.toDouble(),
  );
}

Future<MediaDimensions> _getVideoDimensions(String path) async {
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset(path);
  await videoPlayerController.initialize();
  final size = videoPlayerController.value.size;
  return MediaDimensions(width: size.width, height: size.height);
}

String _getStoragePath(
  String? pathPrefix,
  String filePath,
  bool isVideo, [
  int? index,
]) {
  pathPrefix ??= _firebasePathPrefix();
  pathPrefix = _removeTrailingSlash(pathPrefix);
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  // Workaround fixed by https://github.com/flutter/plugins/pull/3685
  // (not yet in stable).
  final ext = isVideo ? 'mp4' : filePath.split('.').last;
  final indexStr = index != null ? '_$index' : '';
  return '$pathPrefix/$timestamp$indexStr.$ext';
}

String getSignatureStoragePath([String? pathPrefix]) {
  pathPrefix ??= _firebasePathPrefix();
  pathPrefix = _removeTrailingSlash(pathPrefix);
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  return '$pathPrefix/signature_$timestamp.png';
}

void showUploadMessage(
  BuildContext context,
  String message, {
  bool showLoading = false,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsetsDirectional.only(end: 10.0),
                child: CircularProgressIndicator(
                  valueColor: Theme.of(context).brightness == Brightness.dark
                      ? AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).accent4)
                      : null,
                ),
              ),
            Text(message),
          ],
        ),
        duration: showLoading ? Duration(days: 1) : Duration(seconds: 4),
      ),
    );
}

String? _removeTrailingSlash(String? path) => path != null && path.endsWith('/')
    ? path.substring(0, path.length - 1)
    : path;

String _firebasePathPrefix() => 'users/$currentUserUid/uploads';
