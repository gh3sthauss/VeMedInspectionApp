// Report PDF output for sub-section photos (IRS, gantry parts, each coil /
// cassette / probe, ...): a Drive folder per sub-section with a link under
// the section, or - when Drive isn't available - the photos embedded with a
// caption per sub-section.

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '/custom_code/drive_photo_links.dart';
import '/custom_code/subsection_photos.dart';

/// One Drive photo section per sub-section that has photos.
List<DrivePhotoSection> subsectionDriveSections(
        List<SubsectionPhotoField> fields, Map<String, dynamic> data) =>
    [
      for (final f in fields)
        if (subsectionPhotos(data, f.key).isNotEmpty)
          DrivePhotoSection(f.label, subsectionPhotos(data, f.key)),
    ];

/// Loads the photos to embed (only used when Drive isn't available).
Future<Map<String, List<pw.ImageProvider>>> loadSubsectionGalleries(
  List<SubsectionPhotoField> fields,
  Map<String, dynamic> data,
  Future<List<pw.ImageProvider>> Function(List<String> urls) load,
) async =>
    {
      for (final f in fields)
        if (subsectionPhotos(data, f.key).isNotEmpty)
          f.key: await load(subsectionPhotos(data, f.key)),
    };

/// Under a section: links to each sub-section's photo folder, or the
/// embedded photos per sub-section when [drive] is null.
List<pw.Widget> subsectionPhotosPdf({
  required List<SubsectionPhotoField> fields,
  required Map<String, dynamic> data,
  required DrivePhotoLinks? drive,
  required Map<String, List<pw.ImageProvider>> galleries,
  required PdfColor accent,
  required PdfColor textColor,
  required pw.Widget Function(List<pw.ImageProvider> images) grid,
}) {
  final withPhotos =
      fields.where((f) => subsectionPhotos(data, f.key).isNotEmpty).toList();
  if (withPhotos.isEmpty) return const [];

  // "Gantry - Tube" reads as just "Tube" under the Gantry section.
  String shortLabel(String label) =>
      label.contains(' - ') ? label.substring(label.indexOf(' - ') + 3) : label;

  if (drive != null) {
    final links = <pw.Widget>[
      for (final f in withPhotos)
        if (drive.sectionUrls[f.label] != null)
          drivePhotoButton(
            '${shortLabel(f.label)} photos '
                '(${subsectionPhotos(data, f.key).length})',
            drive.sectionUrls[f.label]!,
            accent: accent,
          ),
    ];
    if (links.isEmpty) return const [];
    return [
      pw.SizedBox(height: 6),
      pw.Wrap(spacing: 8, runSpacing: 6, children: links),
    ];
  }

  return [
    for (final f in withPhotos)
      if ((galleries[f.key] ?? const []).isNotEmpty) ...[
        pw.SizedBox(height: 8),
        pw.Text('${shortLabel(f.label)} photos',
            style: pw.TextStyle(
                fontSize: 9, fontWeight: pw.FontWeight.bold, color: textColor)),
        pw.SizedBox(height: 4),
        grid(galleries[f.key]!),
      ],
  ];
}
