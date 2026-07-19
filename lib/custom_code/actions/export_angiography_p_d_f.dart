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
    PdfColor.fromInt(0x0033A0); // adjust to exact brand hex
final PdfColor _accentLight = PdfColor.fromInt(0x8F99FB);
const PdfColor _textDark = PdfColor.fromInt(0xFF1F2937);
final PdfColor _textMuted = PdfColor.fromInt(0xFF6B7280);
final PdfColor _borderColor = PdfColor.fromInt(0xFFD1D5DB);
final PdfColor _zebraColor = PdfColor.fromInt(0xFFF7F9F9);

// TODO: rename to match your actual generated FlutterFlow class for this
// collection (e.g. AngiographyRecord) if it differs.
Future<void> exportAngiographyPDF(AngiographyRecord docRef) async {
  final pdf = pw.Document();

  // -------------------------------------------------------------------------
  // 1. LOAD IMAGES (binary data)
  // -------------------------------------------------------------------------
  // pw.MemoryImage decodes raster formats (PNG/JPEG) only — it cannot parse
  // SVG bytes. The pdf package has a dedicated widget for SVGs (pw.SvgImage)
  // which takes the raw SVG string, not bytes. We branch on file extension
  // so this works whether the bundled asset is an .svg or a raster image.
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

  // Hero / device photo (first image only, for the cover page)
  // networkImage() from the `printing` package already returns a
  // pw.ImageProvider — no need to unwrap bytes from it.
  //
  // Full image galleries for sections that support multiple photos.
  // Loaded in parallel (not one-by-one) and each fetch has a timeout, so a
  // single bad/slow URL can't stall the whole export — which is what was
  // causing the iOS preview to open and hang indefinitely.
  final results = await Future.wait([
    _loadImages(docRef.cosmeticPicURL),
    _loadImages(docRef.otherNotesPhotosURL),
    _loadImages(docRef.softwareOptPicsURL),
    _loadImages(docRef.cnWCMOptPURL),
    _loadImages(docRef.deviceImg),
    _loadImages(docRef.accessoriesPicURL),
    _loadImages(docRef.detectorPicURL),
    _loadImages(docRef.dnTPicURL),
    _loadImages(docRef.patientTablePicURL),
    _loadImages(docRef.tubePicURL),
    _loadImages(docRef.cnWWorkstationOptPURL),
  ]);
  final cosmeticGallery = results[0];
  final otherNotesGallery = results[1];
  final softwareOptGallery = results[2];
  final consoleOptGallery = results[3];
  final deviceImg = results[4];
  final accessoriesGallery = results[5];
  final detectorGallery = results[6];
  final dnTGallery = results[7];
  final patientTableGallery = results[8];
  final tubeGallery = results[9];
  final workstationOptGallery = results[10];

  // Hero image comes from the dedicated deviceImg field.
  final pw.ImageProvider? heroImage =
      deviceImg.isNotEmpty ? deviceImg.first : null;

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
          ['Photos URL', docRef.photosURL],
        ]),

        // ============================ TUBE =================================
        _sectionHeader('Tube Information'),
        _infoTable(rows: [
          ['Model', docRef.tube1Model],
          ['Year of Manufacture', docRef.tube1YOM],
        ]),
        if (tubeGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(tubeGallery),
        ],

        // ========================== DETECTOR ================================
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

        // ========================== SOFTWARE ================================
        _sectionHeader('Software Information'),
        _infoTable(rows: [
          ['Serial Number', docRef.softwareSN],
          ['Version', docRef.softwareVersion],
          ['Options', docRef.softwareOptionsText],
        ]),
        if (softwareOptGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(softwareOptGallery),
        ],

        // ================== CONSOLE AND WORKSTATION(S) ======================
        _sectionHeader('Console and Workstation(s) Information'),
        _infoTable(rows: [
          ['Console Options', docRef.cnWConsoleMOptions],
          ['Console Serial Number', docRef.cnWConsoleMSN],
          ['Console Software Version', docRef.cnWConsoleMSW],
          ['Injection Review Station Serial Number', docRef.cnWIRSSN],
          ['Injection Review Station Software Version', docRef.cnWIRSSW],
          ['Workstation Options', docRef.cnWWorkSOptions],
          ['Workstation Serial Number', docRef.cnWWorkSSN],
          ['Workstation Software Version', docRef.cnWWorkSSW],
        ]),
        if (consoleOptGallery.isNotEmpty || workstationOptGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid([...consoleOptGallery, ...workstationOptGallery]),
        ],

        // ====================== PATIENT TABLE ================================
        _sectionHeader('Patient Table Information'),
        _infoTable(rows: [
          ['Model', docRef.pTModal],
          // TODO: add any remaining Patient Table fields from your schema here
          // (e.g. Serial Number, Year of Manufacture) once confirmed.
        ]),
        if (patientTableGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(patientTableGallery),
        ],

        // ========================= ACCESSORIES ================================
        _sectionHeader('Accessories'),
        _infoTable(rows: [
          ['CDs', docRef.accessoriesCDs],
          ['Spare Parts', docRef.accessoriesSpareP],
        ]),
        if (accessoriesGallery.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          _imageGrid(accessoriesGallery),
        ],

        pw.NewPage(),

        // ========================== PHANTOMS ==================================
        _sectionHeader('Phantoms'),
        _phantomsTable(docRef),

        // ====================== COSMETIC CONDITION =============================
        _sectionHeader('Cosmetic Condition'),
        _infoTable(rows: [
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

  // Printing.sharePdf() has been unreliable in this flow on iOS — it can
  // fail silently with no error and no UI. Writing the bytes to a real file
  // first (via path_provider) and handing that file path to share_plus is
  // the more robust pattern: it reliably surfaces the native share/save
  // sheet, including "Save to Files", and gives us something to inspect
  // if it still doesn't work.
  try {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(pdfBytes);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/pdf', name: fileName)],
        subject: fileName,
        // Required on iOS 26+ (even for iPhone — previously only iPad needed
        // this for the popover anchor) and always required on iPad. A rough
        // rect is fine; it just needs to be non-zero.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100),
      ),
    );
  } catch (e) {
    // TODO: surface this to the user (e.g. via a FlutterFlow snackbar
    // action) instead of a silent catch — if the export is still failing,
    // this is the error message you want to see.
    print('PDF export failed: $e');
  }
}

// ---------------------------------------------------------------------------
// IMAGE LOADING HELPER — converts a List<String> of URLs into pw.ImageProvider
// instances (via the `printing` package's networkImage helper).
//
// Every fetch has a timeout, so one bad/slow URL can't hang the whole
// export, and all URLs in a list are fetched concurrently rather than one
// at a time.
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
    // skip broken/unreachable/slow image rather than failing or stalling
    // the whole PDF export
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
// VALUE DISPLAY HELPER — renders a field value, or a styled "N/A" placeholder
// for empty ones. Previously an em dash ("—") was used for empty fields,
// which rendered as a missing-glyph box in some PDF viewers depending on the
// font fallback — plain ASCII "N/A" avoids that entirely.
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
  AngiographyRecord docRef,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // Top accent band with logo
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
              'ANGIOGRAPHY SYSTEM REPORT',
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

      // Title block
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

      // Hero photo — enlarged and centered
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

      // Summary card
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
// RUNNING HEADER (pages 2+) — small logo + document title + page number
// ---------------------------------------------------------------------------
pw.Widget _buildRunningHeader(
  pw.Widget? logoWidget,
  AngiographyRecord docRef,
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
// FOOTER — disclaimer + company info, every page
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
// SECTION HEADER — accent-colored bar with left rule, professional look
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
// INFO TABLE — zebra-striped label/value rows, blank values render as "—"
// Rows with an empty value are still shown (keeps layout predictable);
// remove the filter below if you'd rather hide blank fields entirely.
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
// PHANTOMS TABLE — main phantom + up to 3 additional, skips empty rows
// ---------------------------------------------------------------------------
pw.Widget _phantomsTable(AngiographyRecord docRef) {
  final entries = <List<String>>[
    [
      '1',
      docRef.accPhantomModel,
      docRef.accPhantomModelNo,
      docRef.accPhantomSN
    ],
    [
      '2',
      docRef.accPhantom1Model,
      docRef.accPhantom1ModelNo,
      docRef.accPhantom1ModelSN
    ],
    [
      '3',
      docRef.accPhantom2Model,
      docRef.accPhantom2ModelNo,
      docRef.accPhantom2ModelSN
    ],
    [
      '4',
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

  pw.Widget bodyCell(String text, {bool isEven = false}) => pw.Padding(
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
// IMAGE GRID — wraps a list of images into a 3-per-row grid, used for any of
// the List<Image Path> fields (cosmetic photos, option screenshots...)
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
