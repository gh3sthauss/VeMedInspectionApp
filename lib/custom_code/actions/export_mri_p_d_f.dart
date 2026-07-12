// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
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
    PdfColor.fromInt(0x0033A0); // adjust to exact brand hex
final PdfColor _accentLight = PdfColor.fromInt(0x8F99FB);
const PdfColor _textDark = PdfColor.fromInt(0xFF1F2937);
final PdfColor _textMuted = PdfColor.fromInt(0xFF6B7280);
final PdfColor _borderColor = PdfColor.fromInt(0xFFD1D5DB);
final PdfColor _zebraColor = PdfColor.fromInt(0xFFF7F9F9);

Future<void> exportMriPDF(MriRecord docRef) async {
  final pdf = pw.Document();

  // -------------------------------------------------------------------------
  // 1. LOAD IMAGES (binary data)
  // -------------------------------------------------------------------------
  pw.Widget? logoWidget;
  try {
    if ('assets/images/logo.svg'.toLowerCase().endsWith('.svg')) {
      final svgString =
          await rootBundle.loadString('assets/images/vemedLogoDarkBGsvg.svg');
      logoWidget = pw.SvgImage(svg: svgString);
    } else {
      final logoBytes = await rootBundle.load('assets/images/logo.svg');
      logoWidget = pw.Image(pw.MemoryImage(logoBytes.buffer.asUint8List()));
    }
  } catch (e) {
    logoWidget = null;
  }

  final results = await Future.wait([
    _loadImages(docRef.cosmeticPicURL),
    _loadImages(docRef.otherNotesPhotosURL),
    _loadImages(docRef.cnWConsoleOptionsPicsURL),
    _loadImages(docRef.cnWWSOptionsPicsURL),
  ]);
  final cosmeticGallery = results[0];
  final otherNotesGallery = results[1];
  final consoleOptGallery = results[2];
  final wsOptGallery = results[3];

  // MriRecord has no dedicated hero/device image field, so the cover photo
  // falls back to the first cosmetic photo when available.
  final pw.ImageProvider? heroImage =
      cosmeticGallery.isNotEmpty ? cosmeticGallery.first : null;

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
        _buildCoverPage(logoWidget, heroImage, docRef),
        pw.NewPage(),

        // ===================== SYSTEM GENERAL INFO ========================
        _sectionHeader('System General Information'),
        _infoTable(rows: [
          ['Brand', docRef.sysGenBrand],
          ['Model', docRef.sysGenModal],
          ['Year of Manufacture', docRef.sysGenYOM],
          ['Serial Number', docRef.sysGenSN],
        ]),

        // ============================ MAGNET =================================
        _sectionHeader('Magnet'),
        _infoTable(rows: [
          ['Model', docRef.magnetModel],
          ['Serial Number', docRef.magnetSN],
          ['Year of Manufacture', docRef.magnetYOM],
          ['Pressure', docRef.magnetPressure],
          ['Shield Temperature', docRef.magnetShieldTemp],
          ['Helium Level', docRef.magnetHELevel],
        ]),

        // ==================== COOLER / COMPRESSOR ===========================
        _sectionHeader('Cooler / Compressor'),
        _infoTable(rows: [
          ['Model', docRef.coolerCompModel],
          ['Year of Manufacture', docRef.coolerCompYOM],
          ['Hours', docRef.coolerCompHours],
          ['Pressure', docRef.coolerCompPressure],
          ['LAR', docRef.coolerCompLAR],
        ]),

        // ========================== COLD HEAD ================================
        _sectionHeader('Cold Head'),
        _infoTable(rows: [
          ['Model', docRef.coldHeadModel],
          ['Last Replacement', docRef.coldHeadLastR],
        ]),

        // ============================ IMAGER =================================
        _sectionHeader('Imager'),
        _infoTable(rows: [
          ['Model', docRef.imagerModel],
          ['Serial Number', docRef.imagerModelSN],
          ['DV Star Model', docRef.imagerDVStarModel],
          ['DV Star Serial Number', docRef.imagerDVStarSN],
          ['PCI RX1 Model', docRef.imagerPCIRX1Model],
          ['PCI RX1 Serial Number', docRef.imagerPCIRX1ModelSN],
          ['PCI RX2 Model', docRef.imagerPCIRX2Model],
          ['PCI RX2 Serial Number', docRef.imagerPCIRX2ModelSN],
        ]),

        pw.NewPage(),

        // ============================= ECG ===================================
        _sectionHeader('ECG'),
        _infoTable(rows: [
          ['Model', docRef.eCGModel],
          ['Serial Number', docRef.ecgsn],
          ['Function Checked', docRef.eCGFuncChecked],
        ]),

        // ========================= POWER STAGES ================================
        _sectionHeader('Power Stages'),
        _infoTable(rows: [
          ['Power Stage 1 Serial Number', docRef.powerStages1SN],
          ['Power Stage 2 Serial Number', docRef.powerStages2SN],
          ['Power Stage 3 Serial Number', docRef.powerStages3SN],
          ['Tales Last Replacement', docRef.talesLastReplacement],
        ]),

        // ====================== PATIENT TABLE ================================
        _sectionHeader('Patient Table'),
        _infoTable(rows: [
          ['Model', docRef.patientTableModel],
          ['Serial Number', docRef.patientTableSN],
          ['Move Tests', docRef.patientTableMoveTests],
        ]),

        // ================== CONSOLE AND WORKSTATION ======================
        _sectionHeader('Console and Workstation Information'),
        _infoTable(rows: [
          ['Console Serial Number', docRef.cnWConsoleSN],
          ['Console Software Version', docRef.cnWConsoleSW],
          ['Console Options', docRef.cnWConsoleOptionsText],
          ['Workstation Serial Number', docRef.cnWWSSN],
          ['Workstation Software Version', docRef.cnWWSSW],
          ['Workstation Options', docRef.cnWWSOptionsText],
          ['CD Available', docRef.cnWCDAvailable],
        ]),
        if (consoleOptGallery.isNotEmpty || wsOptGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid([...consoleOptGallery, ...wsOptGallery]),
        ],

        pw.NewPage(),

        // ========================= LOCAL SERVICE ================================
        _sectionHeader('Local Service'),
        _infoTable(rows: [
          ['Measurement Settings', docRef.localSMeasSettings],
          ['Tune-Up Page', docRef.localSTuneUpPage],
          ['QA', docRef.localSQA],
          ['Magnet Status', docRef.localSMagnetStatus],
          ['Cooling System Page', docRef.localSCoolingSPage],
          ['QA Spike Test Date', docRef.localSQASpikeTestDate],
          ['QA Spike Test OK', docRef.localSQASpikeTestOK],
          ['General QA Test', docRef.localSGeneralQATest],
          ['ICS Cabinet Active', docRef.iCSCabinetActive],
        ]),

        // ============================ COILS ==================================
        _sectionHeader('Coils'),
        _coilsTable(docRef),

        pw.NewPage(),

        // ========================== PHANTOMS ==================================
        _sectionHeader('Phantoms'),
        _phantomsTable(docRef),

        // ========================= ACCESSORIES ================================
        _sectionHeader('Accessories'),
        _infoTable(rows: [
          ['Injector', docRef.accInjector],
          ['Spare Parts', docRef.accSpareParts],
          ['Smoke Detector', docRef.accSmokeDet],
          ['Squeeze Ball', docRef.accSqueezeBall],
          ['Headphone', docRef.accHeadphone],
          ['Magnet Spare Bag', docRef.accMagnetSpareBag],
        ]),

        // ====================== COSMETIC CONDITION =============================
        _sectionHeader('Cosmetic Condition'),
        _infoTable(rows: [
          ['Condition', docRef.cosmeticCondition],
          ['Notes', docRef.cosmeticText],
        ]),
        if (cosmeticGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(cosmeticGallery),
        ],

        // ================= DELIVERY & SITE ACCESS INFORMATION ==================
        _sectionHeader('Delivery & Site Access Information'),
        _infoTable(rows: [
          ['Address', docRef.dnTAddress],
          ['Floor', docRef.dntFloor],
          ['Doors', docRef.dntDoors],
          ['Dock Available', docRef.dntDockAvailable],
          ['Need of Crane', docRef.dntNeedOfCrane],
          ['Tools Required', docRef.dntTools],
          ['Special Attention', docRef.dntSpecialAttention],
        ]),

        // =========================== OTHER NOTES ================================
        _sectionHeader('Other Notes'),
        _infoTable(rows: [
          ['Notes', docRef.otherNotes],
        ]),
        if (otherNotesGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(otherNotesGallery),
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

    await Share.shareXFiles(
      [XFile(file.path, mimeType: 'application/pdf', name: fileName)],
      subject: fileName,
      sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100),
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
  MriRecord docRef,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: pw.BoxDecoration(color: _accent),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            if (logoWidget != null)
              pw.Container(height: 34, child: logoWidget)
            else
              pw.Text(
                'VeMed GMBH',
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            pw.Text(
              'MRI SYSTEM REPORT',
              style: pw.TextStyle(
                color: PdfColors.white,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
      pw.SizedBox(height: 28),
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 4),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              '${docRef.sysGenBrand} ${docRef.sysGenModal}',
              style: pw.TextStyle(
                fontSize: 26,
                fontWeight: pw.FontWeight.bold,
                color: _textDark,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'System Pre-Delivery Inspection Report',
              style: pw.TextStyle(fontSize: 12, color: _textMuted),
            ),
          ],
        ),
      ),
      pw.SizedBox(height: 20),
      if (heroImage != null)
        pw.Center(
          child: pw.Container(
            width: double.infinity,
            height: 380,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: _borderColor, width: 1),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            ),
            child: pw.ClipRRect(
              horizontalRadius: 6,
              verticalRadius: 6,
              child: pw.Image(heroImage,
                  fit: pw.BoxFit.cover, alignment: pw.Alignment.center),
            ),
          ),
        ),
      pw.SizedBox(height: 20),
      pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.all(14),
        decoration: pw.BoxDecoration(
          color: _accentLight,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          border: pw.Border.all(color: _accent, width: 0.75),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            _summaryStat('SERIAL NUMBER', docRef.sysGenSN),
            _summaryStat('YEAR OF MANUFACTURE', docRef.sysGenYOM),
            _summaryStat('MODAL', docRef.sysGenModal),
          ],
        ),
      ),
    ],
  );
}

pw.Widget _summaryStat(String label, String value) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        label,
        style: pw.TextStyle(
          fontSize: 7.5,
          color: _textMuted,
          fontWeight: pw.FontWeight.bold,
          letterSpacing: 0.6,
        ),
      ),
      pw.SizedBox(height: 2),
      _valueText(value, fontSize: 11, fontWeight: pw.FontWeight.bold),
    ],
  );
}

// ---------------------------------------------------------------------------
// RUNNING HEADER (pages 2+)
// ---------------------------------------------------------------------------
pw.Widget _buildRunningHeader(
  pw.Widget? logoWidget,
  MriRecord docRef,
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
// COILS TABLE — Coil1..Coil8 (Model / Serial Number / YOM / QA Check), skips
// empty slots.
// ---------------------------------------------------------------------------
pw.Widget _coilsTable(MriRecord docRef) {
  final entries = <List<String>>[
    ['1', docRef.coil1Model, docRef.coil1SN, docRef.coil1YOM, docRef.coil1QACheck],
    ['2', docRef.coil2Model, docRef.coil2SN, docRef.coil2YOM, docRef.coil2QACheck],
    ['3', docRef.coil3Model, docRef.coil3SN, docRef.coil3YOM, docRef.coil3QACheck],
    ['4', docRef.coil4Model, docRef.coil4SN, docRef.coil4YOM, docRef.coil4QACheck],
    ['5', docRef.coil5Model, docRef.coil5SN, docRef.coil5YOM, docRef.coil5QACheck],
    ['6', docRef.coil6Model, docRef.coil6SN, docRef.coil6YOM, docRef.coil6QACheck],
    ['7', docRef.coil7Model, docRef.coil7SN, docRef.coil7YOM, docRef.coil7QACheck],
    ['8', docRef.coil8Model, docRef.coil8SN, docRef.coil8YOM, docRef.coil8QACheck],
  ]
      .where((row) =>
          row[1].isNotEmpty ||
          row[2].isNotEmpty ||
          row[3].isNotEmpty ||
          row[4].isNotEmpty)
      .toList();

  if (entries.isEmpty) {
    return pw.Text('No coils recorded.',
        style: pw.TextStyle(fontSize: 9, color: _textMuted));
  }

  pw.Widget headerCell(String text) => pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: pw.BoxDecoration(color: _accent),
        child: pw.Text(
          text,
          style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white),
        ),
      );

  pw.Widget bodyCell(String text) => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        child: _valueText(text, fontSize: 8),
      );

  return pw.Table(
    columnWidths: {
      0: const pw.FractionColumnWidth(0.07),
      1: const pw.FractionColumnWidth(0.35),
      2: const pw.FractionColumnWidth(0.23),
      3: const pw.FractionColumnWidth(0.17),
      4: const pw.FractionColumnWidth(0.18),
    },
    border: pw.TableBorder.symmetric(
        inside: pw.BorderSide(width: 0.5, color: _borderColor)),
    children: [
      pw.TableRow(children: [
        headerCell('#'),
        headerCell('Model'),
        headerCell('Serial Number'),
        headerCell('YOM'),
        headerCell('QA Check'),
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
            bodyCell(row[4]),
          ],
        );
      }),
    ],
  );
}

// ---------------------------------------------------------------------------
// PHANTOMS TABLE — main phantom 1..3, skips empty rows
// ---------------------------------------------------------------------------
pw.Widget _phantomsTable(MriRecord docRef) {
  final entries = <List<String>>[
    [
      '1',
      docRef.accPhantom1Model,
      docRef.accPhantom1ModelNo,
      docRef.accPhantom1ModelSN
    ],
    [
      '2',
      docRef.accPhantom2Model,
      docRef.accPhantom2ModelNo,
      docRef.accPhantom2ModelSN
    ],
    [
      '3',
      docRef.accPhantom3Model,
      docRef.accPhantom3ModelNo,
      docRef.accPhantom3ModelSN
    ],
  ]
      .where(
          (row) => row[1].isNotEmpty || row[2].isNotEmpty || row[3].isNotEmpty)
      .toList();

  if (entries.isEmpty) {
    return pw.Text('No phantoms recorded.',
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
      1: const pw.FractionColumnWidth(0.35),
      2: const pw.FractionColumnWidth(0.275),
      3: const pw.FractionColumnWidth(0.275),
    },
    border: pw.TableBorder.symmetric(
        inside: pw.BorderSide(width: 0.5, color: _borderColor)),
    children: [
      pw.TableRow(children: [
        headerCell('#'),
        headerCell('Model'),
        headerCell('Model No.'),
        headerCell('Serial No.'),
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
