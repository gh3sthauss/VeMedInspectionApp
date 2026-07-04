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

Future sharePDFUltrasound(UltrasoundRecord docRef) async {
  // Add your function code here!

  final pdf = pw.Document();

  pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Column(
            children: [
              pw.Text('System General'),
              pw.Divider(thickness: 2),
              pw.Text('Modal : ' + docRef.sysGenModal),
              pw.Text('Brand : ' + docRef.sysGenBrand),
              pw.Text('Serial Number : ' + docRef.sysGenSN),
              pw.Text('Year of Manufacture : ' + docRef.sysGenYOM),
            ],
          )));

  await Printing.sharePdf(
      bytes: await pdf.save(), filename: docRef.sysGenDocName);
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
