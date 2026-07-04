// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future exportPDF(CtRecord docRef) async {
  // Add your function code here!

  final pdf = pw.Document();
  // final netImage = await networkImage(docRef.cosmeticPicURL.first);

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
            level: 0,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Text("System Report: " + "CT Siemens Perspective",
                    textScaleFactor: 1.2), // Title of the PDF
              ],
            ),
          ),
        ];
      },
    ),
  );

  pdf.addPage(
//The pw.MultiPage() function in the PDF library is like a smart assistant that automatically handles long content in your PDF by creating multiple pages, making it easy to organize and present your information neatly.

    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 1,
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              text:
                  "System General Information"), // Header for the second section
          pw.Table(
            columnWidths: {
              0: pw.FractionColumnWidth(0.3),
              1: pw.FractionColumnWidth(0.7),
            },
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
            border: pw.TableBorder.symmetric(
                inside: pw.BorderSide(width: 1, color: PdfColors.black),
                outside: pw.BorderSide(width: 1)),
            children: [
              pw.TableRow(
                children: [
                  pw.Text(' Brand:'),
                  pw.Text(' ' + docRef.sysGenBrand),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Text(' Model:'),
                  pw.Text(' ' + docRef.sysGenModal),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Text(' Year of Manufacture:'),
                  pw.Text(' ' + docRef.sysGenYOM),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Text(' Serial Number:'),
                  pw.Text(' ' + docRef.sysGenSN),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Text(' Number of Slices:'),
                  pw.Text(' ' + docRef.sysGenSlices),
                ],
              ),
            ],
          ),
          pw.Header(
              level: 1,
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              text: "Gantry"), // Header for the second section
          pw.Table(
            columnWidths: {
              0: pw.FractionColumnWidth(0.3),
              1: pw.FractionColumnWidth(0.7),
            },
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
            border: pw.TableBorder.symmetric(
                inside: pw.BorderSide(width: 1, color: PdfColors.black),
                outside: pw.BorderSide(width: 1)),
            children: [
              pw.TableRow(
                children: [
                  pw.Text(' Brand:'),
                  pw.Text(' ' + docRef.sysGenBrand),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Text(' Model:'),
                  pw.Text(' ' + docRef.sysGenModal),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Text(' Year of Manufacture:'),
                  pw.Text(' ' + docRef.sysGenYOM),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Text(' Serial Number:'),
                  pw.Text(' ' + docRef.sysGenSN),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Text(' Number of Slices:'),
                  pw.Text(' ' + docRef.sysGenSlices),
                ],
              ),
            ],
          ),
        ];
      },
    ),
  );

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
