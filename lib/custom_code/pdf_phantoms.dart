// Phantoms table for the report PDFs (Angiography, MRI, CT): one row per
// filled phantom slot, with a Photos column linking to that phantom's Drive
// folder (or pointing at the embedded photos when Drive isn't available).

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '/custom_code/drive_photo_links.dart';
import '/custom_code/phantoms.dart';

/// Drive folder / section name for phantom [slot].
String phantomPhotoSectionName(int slot) => 'Phantom $slot';

/// Slots (1-based) that have any text or photos.
List<int> filledPhantomSlots(PhantomSchema schema, Map<String, dynamic> data) =>
    [
      for (var n = 1; n <= kMaxPhantoms; n++)
        if (schema.slotHasData(data, n)) n,
    ];

/// One Drive photo section per phantom that has photos.
List<DrivePhotoSection> phantomPhotoSections(
        PhantomSchema schema, Map<String, dynamic> data) =>
    [
      for (var n = 1; n <= kMaxPhantoms; n++)
        if (schema.photos(data, n).isNotEmpty)
          DrivePhotoSection(phantomPhotoSectionName(n), schema.photos(data, n)),
    ];

pw.Widget phantomsPdfTable({
  required PhantomSchema schema,
  required Map<String, dynamic> data,
  required DrivePhotoLinks? drive,
  required PdfColor accent,
  required PdfColor borderColor,
  required PdfColor mutedColor,
  required pw.Widget Function(String value) valueText,
  List<String>? legacyRow,
}) {
  final slots = filledPhantomSlots(schema, data);
  final hasLegacy =
      legacyRow != null && legacyRow.any((v) => v.trim().isNotEmpty);
  if (slots.isEmpty && !hasLegacy) {
    return pw.Text('No phantoms recorded.',
        style: pw.TextStyle(fontSize: 9, color: mutedColor));
  }

  pw.Widget headerCell(String text) => pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: pw.BoxDecoration(color: accent),
        child: pw.Text(
          text,
          style: pw.TextStyle(
              fontSize: 8.5,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white),
        ),
      );

  pw.Widget cell(pw.Widget child) => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        child: child,
      );

  pw.Widget muted(String text) => pw.Text(text,
      style: pw.TextStyle(
          fontSize: 9, color: mutedColor, fontStyle: pw.FontStyle.italic));

  pw.Widget photosCell(int slot) {
    final count = schema.photos(data, slot).length;
    if (count == 0) return muted('-');
    final link = drive?.sectionUrls[phantomPhotoSectionName(slot)];
    if (link == null) return muted('See below');
    return pw.UrlLink(
      destination: link,
      child: pw.Text(
        'View $count >',
        style: pw.TextStyle(
            fontSize: 9,
            fontWeight: pw.FontWeight.bold,
            color: accent,
            decoration: pw.TextDecoration.underline),
      ),
    );
  }

  final fieldCount = schema.fields.length;
  // '#' and Photos are narrow; the text fields share the rest.
  const numberWidth = 0.07;
  const photosWidth = 0.15;
  final fieldWidth = (1 - numberWidth - photosWidth) / fieldCount;

  final rows = <pw.TableRow>[
    pw.TableRow(children: [
      headerCell('#'),
      for (final f in schema.fields) headerCell(f.pdfLabel),
      headerCell('Photos'),
    ]),
    if (hasLegacy)
      pw.TableRow(children: [
        cell(muted('-')),
        for (final v in legacyRow) cell(valueText(v)),
        cell(muted('-')),
      ]),
    for (final n in slots)
      pw.TableRow(children: [
        cell(pw.Text('$n', style: const pw.TextStyle(fontSize: 9))),
        for (final f in schema.fields) cell(valueText(schema.text(data, n, f))),
        cell(photosCell(n)),
      ]),
  ];

  return pw.Table(
    columnWidths: {
      0: const pw.FractionColumnWidth(numberWidth),
      for (var i = 0; i < fieldCount; i++)
        i + 1: pw.FractionColumnWidth(fieldWidth),
      fieldCount + 1: const pw.FractionColumnWidth(photosWidth),
    },
    border: pw.TableBorder.symmetric(
        inside: pw.BorderSide(width: 0.5, color: borderColor)),
    children: [
      for (var i = 0; i < rows.length; i++)
        i == 0 || i.isEven
            ? rows[i]
            : pw.TableRow(
                decoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFFF7F9F9)),
                children: rows[i].children),
    ],
  );
}
