// Google Drive photo links for the report PDFs.
//
// On export, the report's photo URLs are sent to the `drivePhotoSync` Cloud
// Function (firebase/functions/drive_sync.js), which copies them into a shared
// Drive folder per report with a sub-folder per section and returns the view
// links. The PDF then shows those links instead of embedding every photo.
// When the call fails (offline, timeout, Drive not configured) the exporter
// falls back to embedding photos as before.

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const _syncUrl =
    'https://us-central1-ve-med-on7ngs.cloudfunctions.net/drivePhotoSync';

class DrivePhotoLinks {
  const DrivePhotoLinks(this.reportUrl, this.sectionUrls);

  /// Folder holding every section folder for the report.
  final String reportUrl;

  /// Section name -> that section's folder.
  final Map<String, String> sectionUrls;
}

/// A named group of photo URLs that becomes one Drive sub-folder.
class DrivePhotoSection {
  const DrivePhotoSection(this.name, this.urls);
  final String name;
  final List<String> urls;
}

/// Drive folder name for a report: the name shown in the app's report list,
/// plus whichever identifying details (brand/model, serial number) are filled.
String driveReportTitle(String docName, List<String> details) => [
      docName,
      ...details.map((d) => d.trim()).where((d) => d.isNotEmpty),
    ].join(' - ');

/// Copies the uploaded photos to Drive and returns the links, or null when
/// Drive isn't reachable (caller then embeds the photos instead).
Future<DrivePhotoLinks?> syncReportPhotosToDrive({
  required String collection,
  required String docId,
  required String title,
  required List<DrivePhotoSection> sections,
}) async {
  final withPhotos = sections
      .map((s) => DrivePhotoSection(
          s.name, s.urls.where((u) => u.trim().isNotEmpty).toList()))
      .where((s) => s.urls.isNotEmpty)
      .toList();
  // The function keys its links by the folder-safe name (cleanName in
  // drive_sync.js); map them back to the names the exporter asked for.
  String folderName(String name) => name
      .replaceAll(RegExp(r'[\\/:*?"<>|\r\n\t]+'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  final requestedNames = {
    for (final s in withPhotos) folderName(s.name): s.name,
  };
  if (withPhotos.isEmpty) return null;
  try {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) return null;
    final res = await http
        .post(
          Uri.parse(_syncUrl),
          headers: {
            // Not "Authorization": Google's front end rejects Firebase ID
            // tokens there before the request reaches the function.
            'X-Firebase-Auth': idToken,
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'data': {
              'reportKey': '${collection}_$docId',
              'title': title,
              'sections': [
                for (final s in withPhotos) {'name': s.name, 'urls': s.urls},
              ],
            },
          }),
        )
        .timeout(const Duration(seconds: 150));
    if (res.statusCode != 200) {
      print('Drive photo sync failed: ${res.statusCode} ${res.body}');
      return null;
    }
    final result = (jsonDecode(res.body) as Map)['result'] as Map;
    return DrivePhotoLinks(
      result['reportUrl'] as String,
      (result['sections'] as Map).map((k, v) =>
          MapEntry(requestedNames[k as String] ?? k, v as String)),
    );
  } catch (e) {
    print('Drive photo sync failed: $e');
    return null;
  }
}

/// Banner for the start of the report: one link to the whole photo folder.
pw.Widget drivePhotosBanner(String url, {required PdfColor accent}) {
  return pw.UrlLink(
    destination: url,
    child: pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 4),
      padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: pw.BoxDecoration(
        // Light tint of the accent, blended by hand (the pdf package
        // ignores colour alpha on fills).
        color: PdfColor(1 - 0.06 * (1 - accent.red),
            1 - 0.06 * (1 - accent.green), 1 - 0.06 * (1 - accent.blue)),
        border: pw.Border.all(color: accent, width: 0.75),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('PHOTOS',
                    style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        color: accent,
                        letterSpacing: 0.6)),
                pw.SizedBox(height: 2),
                pw.Text(
                  'All full-resolution photos of this inspection, '
                  'organised in a folder per section.',
                  style: const pw.TextStyle(
                      fontSize: 8.5, color: PdfColors.grey700),
                ),
              ],
            ),
          ),
          pw.SizedBox(width: 12),
          pw.Text('Open photo folder  >',
              style: pw.TextStyle(
                  fontSize: 9.5,
                  fontWeight: pw.FontWeight.bold,
                  color: accent,
                  decoration: pw.TextDecoration.underline)),
        ],
      ),
    ),
  );
}

/// Link shown under a section in place of its photo grid.
pw.Widget driveSectionPhotosLink(String url, int count,
    {required PdfColor accent}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(top: 6),
    child: pw.UrlLink(
      destination: url,
      child: pw.Text(
        'View ${count == 1 ? '1 photo' : '$count photos'} of this section  >',
        style: pw.TextStyle(
            fontSize: 9,
            fontWeight: pw.FontWeight.bold,
            color: accent,
            decoration: pw.TextDecoration.underline),
      ),
    ),
  );
}
