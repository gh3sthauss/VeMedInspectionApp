import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'c_r_console_n_workstations_widget.dart'
    show CRConsoleNWorkstationsWidget;
import 'package:flutter/material.dart';

class CRConsoleNWorkstationsModel
    extends FlutterFlowModel<CRConsoleNWorkstationsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for logo component.
  late LogoModel logoModel;
  // State field(s) for CTConsoleModelSN widget.
  FocusNode? cTConsoleModelSNFocusNode;
  TextEditingController? cTConsoleModelSNTextController;
  String? Function(BuildContext, String?)?
      cTConsoleModelSNTextControllerValidator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode1;
  TextEditingController? textInputTextController1;
  String? Function(BuildContext, String?)? textInputTextController1Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode2;
  TextEditingController? textInputTextController2;
  String? Function(BuildContext, String?)? textInputTextController2Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode3;
  TextEditingController? textInputTextController3;
  String? Function(BuildContext, String?)? textInputTextController3Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode4;
  TextEditingController? textInputTextController4;
  String? Function(BuildContext, String?)? textInputTextController4Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode5;
  TextEditingController? textInputTextController5;
  String? Function(BuildContext, String?)? textInputTextController5Validator;

  @override
  void initState(BuildContext context) {
    logoModel = createModel(context, () => LogoModel());
  }

  @override
  void dispose() {
    logoModel.dispose();
    cTConsoleModelSNFocusNode?.dispose();
    cTConsoleModelSNTextController?.dispose();

    textInputFocusNode1?.dispose();
    textInputTextController1?.dispose();

    textInputFocusNode2?.dispose();
    textInputTextController2?.dispose();

    textInputFocusNode3?.dispose();
    textInputTextController3?.dispose();

    textInputFocusNode4?.dispose();
    textInputTextController4?.dispose();

    textInputFocusNode5?.dispose();
    textInputTextController5?.dispose();
  }
}
