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

// [includeSections] is the set of section keys (see kAngiographyPdfSections in
// lib/components/pdf_section_selector.dart) chosen in the export selector.
// null means "include everything" so existing callers keep the full report.
Future<void> exportAngiographyPDF(
  AngiographyRecord docRef, {
  Set<String>? includeSections,
}) async {
  bool inc(String key) =>
      includeSections == null || includeSections.contains(key);

  final pdf = pw.Document();

  // -------------------------------------------------------------------------
  // 1. LOAD IMAGES (binary data)
  // -------------------------------------------------------------------------
  // pw.MemoryImage decodes raster formats (PNG/JPEG) only — it cannot parse
  // SVG bytes. The pdf package has a dedicated widget for SVGs (pw.SvgImage)
  // which takes the raw SVG string, not bytes. We branch on file extension
  // so this works whether the bundled asset is an .svg or a raster image.
  // Original colour brand logo (cover + running header) and the modality
  // icon shown as the cover hero.
  pw.Widget? logoWidget;
  pw.Widget? modalityIcon;
  try {
    final logoBytes =
        await rootBundle.load('assets/images/logo_original.png');
    logoWidget = pw.Image(pw.MemoryImage(logoBytes.buffer.asUint8List()));
    final iconSvg = await rootBundle
        .loadString('assets/images/modality_icons/angiography.svg');
    modalityIcon = pw.SvgImage(svg: iconSvg);
  } catch (e) {
    logoWidget = null;
    modalityIcon = null;
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
        _buildCoverPage(logoWidget, heroImage, docRef, modalityIcon, 'Angiography'),
        pw.NewPage(),

        // ===================== SYSTEM GENERAL INFO ========================
        if (inc('system_general')) ...[
          _sectionHeader('System General Information'),
          _infoTable(rows: [
            ['Brand', docRef.sysGenBrand],
            ['Model', docRef.sysGenModal],
            ['Year of Manufacture', docRef.sysGenYOM],
            ['Serial Number', docRef.sysGenSN],
            ['Photos URL', docRef.photosURL],
          ]),
        ],

        // ============================ TUBE =================================
        if (inc('tube')) ...[
          _sectionHeader('Tube Information'),
          _infoTable(rows: [
            ['Model', docRef.tube1Model],
            ['Year of Manufacture', docRef.tube1YOM],
          ]),
          if (tubeGallery.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            _imageGrid(tubeGallery),
          ],
        ],

        // ========================== DETECTOR ================================
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
        ],

        // ========================== SOFTWARE ================================
        if (inc('software')) ...[
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
        ],

        // ================== CONSOLE AND WORKSTATION(S) ======================
        if (inc('console')) ...[
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
          if (consoleOptGallery.isNotEmpty ||
              workstationOptGallery.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            _imageGrid([...consoleOptGallery, ...workstationOptGallery]),
          ],
        ],

        // ====================== PATIENT TABLE ================================
        if (inc('patient_table')) ...[
          _sectionHeader('Patient Table Information'),
          _infoTable(rows: [
            ['Model', docRef.pTModal],
            // TODO: add any remaining Patient Table fields from your schema
            // here (e.g. Serial Number, Year of Manufacture) once confirmed.
          ]),
          if (patientTableGallery.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            _imageGrid(patientTableGallery),
          ],
        ],

        // ========================= ACCESSORIES ================================
        if (inc('accessories')) ...[
          _sectionHeader('Accessories'),
          _infoTable(rows: [
            ['CDs', docRef.accessoriesCDs],
            ['Spare Parts', docRef.accessoriesSpareP],
          ]),
          if (accessoriesGallery.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            _imageGrid(accessoriesGallery),
          ],
        ],

        // No hard page break here: sections flow continuously so the pages
        // stay filled and skipping sections never leaves a half-empty page.
        // MultiPage paginates on its own when content overflows.

        // ========================== PHANTOMS ==================================
        if (inc('phantoms')) ...[
          _sectionHeader('Phantoms'),
          _phantomsTable(docRef),
        ],

        // ====================== COSMETIC CONDITION =============================
        if (inc('cosmetic')) ...[
          _sectionHeader('Cosmetic Condition'),
          _infoTable(rows: [
            ['Notes', docRef.cosmeticText],
          ]),
          if (cosmeticGallery.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            _imageGrid(cosmeticGallery),
          ],
        ],

        // ================= DELIVERY & SITE ACCESS INFORMATION ==================
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
        ],

        // =========================== OTHER NOTES ================================
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
      pw.SizedBox(height: 40),
      // Hero: the actual device photo when one was captured, otherwise the
      // branded modality icon with its label.
      if (heroImage != null)
        pw.Center(
          child: pw.Container(
            width: double.infinity,
            height: 360,
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
        )
      else
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
