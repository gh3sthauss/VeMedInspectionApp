import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'ang_patient_table_widget.dart' show AngPatientTableWidget;
import 'package:flutter/material.dart';

class AngPatientTableModel extends FlutterFlowModel<AngPatientTableWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for logo component.
  late LogoModel logoModel;
  // State field(s) for text widget.
  FocusNode? textFocusNode1;
  TextEditingController? textTextController1;
  String? Function(BuildContext, String?)? textTextController1Validator;
  // State field(s) for text widget.
  FocusNode? textFocusNode2;
  TextEditingController? textTextController2;
  String? Function(BuildContext, String?)? textTextController2Validator;
  // State field(s) for text widget.
  FocusNode? textFocusNode3;
  TextEditingController? textTextController3;
  String? Function(BuildContext, String?)? textTextController3Validator;

  @override
  void initState(BuildContext context) {
    logoModel = createModel(context, () => LogoModel());
  }

  @override
  void dispose() {
    logoModel.dispose();
    textFocusNode1?.dispose();
    textTextController1?.dispose();

    textFocusNode2?.dispose();
    textTextController2?.dispose();

    textFocusNode3?.dispose();
    textTextController3?.dispose();
  }
}
