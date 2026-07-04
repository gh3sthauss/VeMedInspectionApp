import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'c_t_console_and_workstations_widget.dart'
    show CTConsoleAndWorkstationsWidget;
import 'package:flutter/material.dart';

class CTConsoleAndWorkstationsModel
    extends FlutterFlowModel<CTConsoleAndWorkstationsWidget> {
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
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode6;
  TextEditingController? textInputTextController6;
  String? Function(BuildContext, String?)? textInputTextController6Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode7;
  TextEditingController? textInputTextController7;
  String? Function(BuildContext, String?)? textInputTextController7Validator;

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

    textInputFocusNode6?.dispose();
    textInputTextController6?.dispose();

    textInputFocusNode7?.dispose();
    textInputTextController7?.dispose();
  }
}
