import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '/components/doc_naming.dart';
import '/custom_code/drive_photo_links.dart';
import '/custom_code/video_outbox/video_upload_queue.dart';
import '/flutter_flow/flutter_flow_theme.dart';

/// "Videos" on a System General page. Videos upload straight to the
/// report's Google Drive folder (see VideoUploadQueue); the app keeps only
/// their Drive ids and names.
class SystemGeneralVideosField extends StatefulWidget {
  const SystemGeneralVideosField({
    super.key,
    required this.collectionPath,
    required this.docId,
    required this.modalityLabel,
    required this.data,
  });

  final String collectionPath;
  final String docId;

  /// "CT", "MRI", ... - used for the Drive folder name like the PDF export.
  final String modalityLabel;

  /// The record's raw Firestore data (record.snapshotData).
  final Map<String, dynamic> data;

  @override
  State<SystemGeneralVideosField> createState() =>
      _SystemGeneralVideosFieldState();
}

class _SystemGeneralVideosFieldState extends State<SystemGeneralVideosField> {
  List<PendingVideo> _pending = const [];

  VideoUploadQueue get _queue => VideoUploadQueue.instance;

  @override
  void initState() {
    super.initState();
    _queue.changes.addListener(_load);
    _load();
  }

  @override
  void dispose() {
    _queue.changes.removeListener(_load);
    super.dispose();
  }

  Future<void> _load() async {
    final items = await _queue.pendingFor(widget.collectionPath, widget.docId);
    if (mounted) setState(() => _pending = items);
  }

  String get _title {
    final d = widget.data;
    String s(String k) => d[k] is String ? d[k] as String : '';
    return driveReportTitle(
      smartDocName(s('SysGenDocName'), widget.modalityLabel, widget.docId),
      [
        '${s('SysGenBrand')} ${s('SysGenModal')}',
        if (s('SysGenSN').trim().isNotEmpty) 'SN ${s('SysGenSN').trim()}',
      ],
    );
  }

  List<Map<String, dynamic>> get _uploaded {
    final v = widget.data[kVideosField];
    return v is List
        ? v.whereType<Map>().map((m) => Map<String, dynamic>.from(m)).toList()
        : const [];
  }

  Future<void> _add(ImageSource source) async {
    final picked = await ImagePicker().pickVideo(source: source);
    if (picked == null) return;
    await _queue.enqueue(
      collection: widget.collectionPath,
      docId: widget.docId,
      title: _title,
      sourcePath: picked.path,
    );
  }

  void _chooseSource() {
    showModalBottomSheet(
      context: context,
      builder: (sheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.videocam_rounded),
              title: const Text('Record video'),
              onTap: () {
                Navigator.pop(sheet);
                _add(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library_rounded),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(sheet);
                _add(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _remove(Map<String, dynamic> video) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Remove video?'),
        content: Text('"${video['name']}" will be removed from the report '
            'and moved to the Drive trash.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(d, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(d, true),
              child: const Text('Remove')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await _queue.deleteUploaded(
          collection: widget.collectionPath, docId: widget.docId, video: video);
    } on VideoRequestError catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  String _size(num bytes) {
    final mb = bytes / (1024 * 1024);
    return mb >= 1000
        ? '${(mb / 1024).toStringAsFixed(1)} GB'
        : '${mb.toStringAsFixed(mb < 10 ? 1 : 0)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final label = GoogleFonts.readexPro(fontSize: 14.5, color: theme.primaryText);
    final sub = GoogleFonts.readexPro(fontSize: 12.0, color: theme.secondaryText);

    Widget tile({
      required Widget leading,
      required String title,
      required Widget subtitle,
      Widget? trailing,
      VoidCallback? onTap,
    }) =>
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.0),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            padding: const EdgeInsets.fromLTRB(12.0, 10.0, 4.0, 10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7FF),
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Row(
              children: [
                leading,
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: label),
                      const SizedBox(height: 2.0),
                      subtitle,
                    ],
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
        );

    return SizedBox(
      width: 320.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 8.0),
            child: Text('Videos',
                style: GoogleFonts.readexPro(
                    fontSize: 16.0, color: theme.primaryText)),
          ),
          for (final v in _uploaded)
            tile(
              leading: Icon(Icons.play_circle_fill_rounded,
                  color: theme.primary, size: 30.0),
              title: '${v['name'] ?? 'Video'}',
              subtitle: Text(
                  '${v['size'] is num ? _size(v['size'] as num) : ''}'
                  ' · On Google Drive',
                  style: sub),
              onTap: () => launchUrl(
                  Uri.parse('https://drive.google.com/file/d/${v['id']}/view'),
                  mode: LaunchMode.externalApplication),
              trailing: IconButton(
                tooltip: 'Remove video',
                icon: Icon(Icons.close_rounded, color: theme.secondaryText),
                onPressed: () => _remove(v),
              ),
            ),
          for (final job in _pending)
            tile(
              leading: Icon(Icons.cloud_upload_rounded,
                  color: theme.secondaryText, size: 28.0),
              title: job.fileName,
              subtitle: ValueListenableBuilder<Map<int, double>>(
                valueListenable: _queue.progress,
                builder: (_, p, __) {
                  final value = p[job.id];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value == null
                            ? '${_size(job.size)} · Waiting for connection'
                            : '${_size(job.size)} · Uploading '
                                '${(value * 100).round()}%',
                        style: sub,
                      ),
                      if (value != null) ...[
                        const SizedBox(height: 4.0),
                        LinearProgressIndicator(
                          value: value,
                          minHeight: 3.0,
                          color: theme.primary,
                          backgroundColor: theme.alternate,
                        ),
                      ],
                    ],
                  );
                },
              ),
              trailing: IconButton(
                tooltip: 'Cancel upload',
                icon: Icon(Icons.close_rounded, color: theme.secondaryText),
                onPressed: () => _queue.cancel(job.id),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _chooseSource,
              icon: Icon(Icons.video_call_rounded, color: theme.primary),
              label: Text('Add video',
                  style: GoogleFonts.readexPro(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: theme.primary)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: theme.primary, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 6.0),
            child: Text(
                'Videos upload straight to Google Drive (not the app), '
                'continuing when you have signal.',
                style: sub),
          ),
        ],
      ),
    );
  }
}
