// Automatic FlutterFlow imports
import '/backend/backend.dart';
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'dart:ui' show Rect;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// ---------------------------------------------------------------------------
// BRAND / STYLE CONSTANTS
// ---------------------------------------------------------------------------
final PdfColor _accent =
    PdfColor.fromInt(0x002D4B); // VeMed report navy
const PdfColor _textDark = PdfColor.fromInt(0xFF1F2937);
final PdfColor _textMuted = PdfColor.fromInt(0xFF6B7280);
final PdfColor _borderColor = PdfColor.fromInt(0xFFD1D5DB);
final PdfColor _zebraColor = PdfColor.fromInt(0xFFF7F9F9);

Future<void> exportDrPDF(
  DrRecord docRef, {
  Set<String>? includeSections,
}) async {
  bool inc(String key) =>
      includeSections == null || includeSections.contains(key);

  final pdf = pw.Document();

  // -------------------------------------------------------------------------
  // 1. LOAD IMAGES (binary data)
  // -------------------------------------------------------------------------
  // Original colour brand logo (cover + running header) and the modality
  // icon shown as the cover hero.
  pw.Widget? logoWidget;
  pw.Widget? modalityIcon;
  try {
    final logoSvg = await rootBundle.loadString('assets/images/logo.svg');
    logoWidget = pw.SvgImage(svg: logoSvg);
    final iconSvg = await rootBundle
        .loadString('assets/images/modality_icons/dr.svg');
    modalityIcon = pw.SvgImage(svg: iconSvg);
  } catch (e) {
    logoWidget = null;
    modalityIcon = null;
  }

  final results = await Future.wait([
    _loadImages(docRef.cosmeticPicURL),
    _loadImages(docRef.otherNotesPhotosURL),
    _loadImages(docRef.cnWWorkstationOptPURL),
    _loadImages(docRef.cnWCMOptPURL),
    _loadImages(docRef.deviceImg),
    _loadImages(docRef.accessoriesPicURL),
    _loadImages(docRef.cassettesPicURL),
    _loadImages(docRef.detectorPicURL),
    _loadImages(docRef.dnTPicURL),
  ]);
  final cosmeticGallery = results[0];
  final otherNotesGallery = results[1];
  final workstationOptGallery = results[2];
  final consoleOptGallery = results[3];
  final deviceImg = results[4];
  final accessoriesGallery = results[5];
  final cassettesGallery = results[6];
  final detectorGallery = results[7];
  final dnTGallery = results[8];

  // Hero image comes from the dedicated deviceImg field; falls back to the
  // first cosmetic photo if deviceImg wasn't populated for this record.
  final pw.ImageProvider? heroImage = deviceImg.isNotEmpty
      ? deviceImg.first
      : (cosmeticGallery.isNotEmpty ? cosmeticGallery.first : null);

  // -------------------------------------------------------------------------
  // 2. BUILD DOCUMENT
  // -------------------------------------------------------------------------
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(32, 24, 32, 24),
      header: (context) => context.pageNumber == 1
          ? pw.SizedBox()
          : _buildRunningHeader(logoWidget, docRef, context),
      footer: (context) => _buildFooter(context),
      build: (context) => [
        // =========================== COVER PAGE ===========================
        _buildCoverPage(logoWidget, heroImage, docRef, modalityIcon, 'DR'),
        pw.NewPage(),

        // ===================== SYSTEM GENERAL INFO ========================
        if (inc('system_general')) ...[
        _sectionHeader('System General Information'),
        _infoTable(rows: [
          ['Brand', docRef.sysGenBrand],
          ['Model', docRef.sysGenModal],
          ['Year of Manufacture', docRef.sysGenYOM],
          ['Serial Number', docRef.sysGenSN],
        ]),

        // ================== CONSOLE AND WORKSTATION ======================
        ],
        if (inc('console')) ...[
        _sectionHeader('Console and Workstation Information'),
        _infoTable(rows: [
          ['Console Serial Number', docRef.cnWConsoleMSN],
          ['Console Software Version', docRef.cnWConsoleMSW],
          ['Console Options', docRef.cnWConsoleMOptions],
          ['Workstation Serial Number', docRef.cnWWorkSSN],
          ['Workstation Software Version', docRef.cnWWorkSSW],
          ['Workstation Options', docRef.cnWWorkSOptions],
        ]),
        if (consoleOptGallery.isNotEmpty || workstationOptGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid([...consoleOptGallery, ...workstationOptGallery]),
        ],

        // ========================== DETECTOR ================================
        ],
        if (inc('detector')) ...[
        _sectionHeader('Detector Information'),
        _infoTable(rows: [
          ['Model', docRef.detectorModel],
          ['Size', docRef.detectorSize],
          ['Year of Manufacture', docRef.detectorYOM],
          ['Condition', docRef.detectorCondition],
        ]),
        if (detectorGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(detectorGallery),
        ],

        // ========================== CASSETTES ================================
        ],
        if (inc('cassettes')) ...[
        _sectionHeader('Cassettes'),
        _cassettesTable(docRef),
        if (cassettesGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(cassettesGallery),
        ],

        // ========================= ACCESSORIES ================================
        ],
        if (inc('accessories')) ...[
        _sectionHeader('Accessories'),
        _infoTable(rows: [
          ['Model', docRef.accessoriesPModal],
          ['Model No.', docRef.accessoriesPModelNo],
          ['Serial Number', docRef.accessoriesPSN],
          ['CDs', docRef.accessoriesCDs],
          ['Spare Parts', docRef.accessoriesSpareP],
        ]),
        if (accessoriesGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(accessoriesGallery),
        ],


        // ====================== COSMETIC CONDITION =============================
        ],
        if (inc('cosmetic')) ...[
        _sectionHeader('Cosmetic Condition'),
        _infoTable(rows: [
          ['Notes', docRef.cosmeticText],
        ]),
        if (cosmeticGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(cosmeticGallery),
        ],

        // ================= DELIVERY & SITE ACCESS INFORMATION ==================
        ],
        if (inc('delivery')) ...[
        _sectionHeader('Delivery & Site Access Information'),
        _infoTable(rows: [
          ['Address', docRef.dnTAddress],
          ['Floor', docRef.dnTFloor],
          ['Door Size', docRef.dnTDoorS],
          ['Dock Available', docRef.dnTDockAvailable],
          ['Need of Crane', docRef.dnTNeedOfCrane],
          ['Tools Required', docRef.dnTTools],
          ['Special Attention', docRef.dnTSpecialAttention],
        ]),
        if (dnTGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(dnTGallery),
        ],

        // =========================== OTHER NOTES ================================
        ],
        if (inc('other_notes')) ...[
        _sectionHeader('Other Notes'),
        _infoTable(rows: [
          ['Notes', docRef.otherNotes],
        ]),
        if (otherNotesGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(otherNotesGallery),
        ],
        ],
      ],
    ),
  );

  final pdfBytes = await pdf.save();
  final fileName = '${docRef.sysGenBrand}_${docRef.sysGenModal}_Report.pdf'
      .replaceAll(' ', '_');

  try {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(pdfBytes);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/pdf', name: fileName)],
        subject: fileName,
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100),
      ),
    );
  } catch (e) {
    print('PDF export failed: $e');
  }
}

// ---------------------------------------------------------------------------
// IMAGE LOADING HELPER
// ---------------------------------------------------------------------------
Future<pw.ImageProvider?> _loadSingleImage(
  String url, {
  Duration timeout = const Duration(seconds: 8),
}) async {
  final trimmed = url.trim();
  if (trimmed.isEmpty) return null;
  try {
    return await networkImage(trimmed).timeout(timeout);
  } catch (e) {
    return null;
  }
}

Future<List<pw.ImageProvider>> _loadImages(
  List<String> urls, {
  Duration timeout = const Duration(seconds: 8),
}) async {
  final futures = urls.map((u) => _loadSingleImage(u, timeout: timeout));
  final results = await Future.wait(futures);
  return results.whereType<pw.ImageProvider>().toList();
}

// ---------------------------------------------------------------------------
// VALUE DISPLAY HELPER
// ---------------------------------------------------------------------------
pw.Widget _valueText(
  String value, {
  double fontSize = 9,
  PdfColor color = _textDark,
  pw.FontWeight fontWeight = pw.FontWeight.normal,
}) {
  final isEmpty = value.trim().isEmpty;
  return pw.Text(
    isEmpty ? 'N/A' : value,
    style: pw.TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: isEmpty ? _textMuted : color,
      fontStyle: isEmpty ? pw.FontStyle.italic : pw.FontStyle.normal,
    ),
  );
}

// ---------------------------------------------------------------------------
// COVER PAGE
// ---------------------------------------------------------------------------
pw.Widget _buildCoverPage(
  pw.Widget? logoWidget,
  pw.ImageProvider? heroImage,
  dynamic docRef,
  pw.Widget? modalityIcon,
  String modalityLabel,
) {
  pw.Widget addr(String t, {bool bold = false}) => pw.Text(
        t,
        style: pw.TextStyle(
          fontSize: bold ? 12 : 10,
          color: bold ? _textDark : _textMuted,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      );
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (logoWidget != null)
            pw.Container(height: 58, child: logoWidget)
          else
            pw.Text('VeMed GmbH',
                style: pw.TextStyle(
                    color: _accent,
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold)),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              addr('VeMed GmbH', bold: true),
              pw.SizedBox(height: 6),
              addr('Leichtmetallstr. 24a'),
              addr('42781 Haan - Germany'),
              pw.SizedBox(height: 6),
              addr('+49 2104 141999-0'),
              addr('info@vemed.de'),
              addr('www.vemed.de'),
            ],
          ),
        ],
      ),
      pw.SizedBox(height: 64),
      pw.Text('INSPECTION',
          style: pw.TextStyle(
              fontSize: 42,
              fontWeight: pw.FontWeight.bold,
              color: _accent,
              height: 1.05)),
      pw.Text('REPORT',
          style: pw.TextStyle(
              fontSize: 42,
              fontWeight: pw.FontWeight.bold,
              color: _accent,
              height: 1.05)),
      pw.SizedBox(height: 48),
      pw.Center(
        child: pw.Stack(
          alignment: pw.Alignment.center,
          children: [
            if (modalityIcon != null)
              pw.Opacity(
                opacity: 0.5,
                child: pw.Container(
                    height: 300, width: 300, child: modalityIcon),
              ),
            pw.Text(modalityLabel,
                style: pw.TextStyle(
                    fontSize: 40,
                    fontWeight: pw.FontWeight.bold,
                    color: _accent)),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// RUNNING HEADER (pages 2+)
// ---------------------------------------------------------------------------
pw.Widget _buildRunningHeader(
  pw.Widget? logoWidget,
  DrRecord docRef,
  pw.Context context,
) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 14),
    padding: const pw.EdgeInsets.only(bottom: 8),
    decoration: const pw.BoxDecoration(
      border:
          pw.Border(bottom: pw.BorderSide(width: 1, color: PdfColors.grey400)),
    ),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        if (logoWidget != null)
          pw.Container(height: 20, child: logoWidget)
        else
          pw.Text('VeMed GMBH',
              style: pw.TextStyle(
                  fontSize: 9, fontWeight: pw.FontWeight.bold, color: _accent)),
        pw.Text(
          '${docRef.sysGenBrand} ${docRef.sysGenModal} System Report',
          style: pw.TextStyle(fontSize: 8, color: _textMuted),
        ),
        pw.Text('Page ${context.pageNumber}',
            style: pw.TextStyle(fontSize: 8, color: _textMuted)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// FOOTER
// ---------------------------------------------------------------------------
pw.Widget _buildFooter(pw.Context context) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(top: 10),
    padding: const pw.EdgeInsets.only(top: 8),
    decoration: const pw.BoxDecoration(
      border:
          pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColors.grey400)),
    ),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Text(
            'VeMed GMBH · Leichtmetallstr. 24a · 42781 Haan · www.vemed.de',
            style: pw.TextStyle(fontSize: 7, color: _textMuted),
          ),
        ),
        pw.Text(
          'Images are for reference only.',
          style: pw.TextStyle(
              fontSize: 7, color: _textMuted, fontStyle: pw.FontStyle.italic),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION HEADER
// ---------------------------------------------------------------------------
pw.Widget _sectionHeader(String title) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(top: 16, bottom: 6),
    padding: const pw.EdgeInsets.only(left: 8),
    decoration: pw.BoxDecoration(
      border: pw.Border(left: pw.BorderSide(width: 3, color: _accent)),
    ),
    child: pw.Text(
      title.toUpperCase(),
      style: pw.TextStyle(
        fontSize: 11,
        fontWeight: pw.FontWeight.bold,
        color: _textDark,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// INFO TABLE
// ---------------------------------------------------------------------------
pw.Widget _infoTable({required List<List<String>> rows}) {
  return pw.Table(
    columnWidths: {
      0: const pw.FractionColumnWidth(0.35),
      1: const pw.FractionColumnWidth(0.65),
    },
    border: pw.TableBorder(
      horizontalInside: pw.BorderSide(width: 0.5, color: _borderColor),
    ),
    children: List.generate(rows.length, (i) {
      final row = rows[i];
      final isEven = i % 2 == 0;
      return pw.TableRow(
        decoration:
            pw.BoxDecoration(color: isEven ? _zebraColor : PdfColors.white),
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: pw.Text(
              row[0],
              style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  color: _textDark),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: _valueText(row[1]),
          ),
        ],
      );
    }),
  );
}

// ---------------------------------------------------------------------------
// CASSETTES TABLE — CR1..CR8 (Model / Size / Condition), skips empty slots
// ---------------------------------------------------------------------------
pw.Widget _cassettesTable(DrRecord docRef) {
  final entries = <List<String>>[
    ['1', docRef.cR1Model, docRef.cR1Size, docRef.cR1Condition],
    ['2', docRef.cR2Model, docRef.cR2Size, docRef.cR2Condition],
    ['3', docRef.cR3Model, docRef.cR3Size, docRef.cR3Condition],
    ['4', docRef.cR4Model, docRef.cR4Size, docRef.cR4Condition],
    ['5', docRef.cR5Model, docRef.cR5Size, docRef.cR5Condition],
    ['6', docRef.cR6Model, docRef.cR6Size, docRef.cR6Condition],
    ['7', docRef.cR7Model, docRef.cR7Size, docRef.cR7Condition],
    ['8', docRef.cR8Model, docRef.cR8Size, docRef.cR8Condition],
  ]
      .where(
          (row) => row[1].isNotEmpty || row[2].isNotEmpty || row[3].isNotEmpty)
      .toList();

  if (entries.isEmpty) {
    return pw.Text('No cassettes recorded.',
        style: pw.TextStyle(fontSize: 9, color: _textMuted));
  }

  pw.Widget headerCell(String text) => pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: pw.BoxDecoration(color: _accent),
        child: pw.Text(
          text,
          style: pw.TextStyle(
              fontSize: 8.5,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white),
        ),
      );

  pw.Widget bodyCell(String text) => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: _valueText(text),
      );

  return pw.Table(
    columnWidths: {
      0: const pw.FractionColumnWidth(0.1),
      1: const pw.FractionColumnWidth(0.4),
      2: const pw.FractionColumnWidth(0.25),
      3: const pw.FractionColumnWidth(0.25),
    },
    border: pw.TableBorder.symmetric(
        inside: pw.BorderSide(width: 0.5, color: _borderColor)),
    children: [
      pw.TableRow(children: [
        headerCell('#'),
        headerCell('Model'),
        headerCell('Size'),
        headerCell('Condition'),
      ]),
      ...List.generate(entries.length, (i) {
        final row = entries[i];
        final isEven = i % 2 == 0;
        return pw.TableRow(
          decoration:
              pw.BoxDecoration(color: isEven ? _zebraColor : PdfColors.white),
          children: [
            bodyCell(row[0]),
            bodyCell(row[1]),
            bodyCell(row[2]),
            bodyCell(row[3]),
          ],
        );
      }),
    ],
  );
}

// ---------------------------------------------------------------------------
// IMAGE GRID
// ---------------------------------------------------------------------------
pw.Widget _imageGrid(List<pw.ImageProvider> images) {
  const int columns = 3;
  final List<pw.Widget> tiles = images
      .map(
        (img) => pw.Container(
          width: (PdfPageFormat.a4.availableWidth - 64 - (columns - 1) * 8) /
              columns,
          height: 100,
          margin: const pw.EdgeInsets.only(bottom: 8, right: 8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: _borderColor, width: 0.75),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
          ),
          child: pw.ClipRRect(
            horizontalRadius: 3,
            verticalRadius: 3,
            child: pw.Image(img, fit: pw.BoxFit.cover),
          ),
        ),
      )
      .toList();

  return pw.Wrap(children: tiles);
}
