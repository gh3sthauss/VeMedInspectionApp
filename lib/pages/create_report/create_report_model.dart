import '/backend/backend.dart';
import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_report_widget.dart' show CreateReportWidget;
import 'package:flutter/material.dart';

class CreateReportModel extends FlutterFlowModel<CreateReportWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for logo component.
  late LogoModel logoModel;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  AngiographyRecord? newDocAngio;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CtRecord? newDocCT;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  UltrasoundRecord? newDocUltrasound;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MriRecord? newDocMRI;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  XRayRecord? newDocXRay;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  FluoroscopyRecord? newDocFL;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CArmRecord? newDocCArm;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MammographyRecord? newDocMamm;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PacsRecord? newDocPACS;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  DrRecord? newDocDR;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CrRecord? newDocCR;

  @override
  void initState(BuildContext context) {
    logoModel = createModel(context, () => LogoModel());
  }

  @override
  void dispose() {
    logoModel.dispose();
  }
}
