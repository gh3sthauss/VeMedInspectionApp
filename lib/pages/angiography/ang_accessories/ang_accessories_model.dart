import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'ang_accessories_widget.dart' show AngAccessoriesWidget;
import 'package:flutter/material.dart';

class AngAccessoriesModel extends FlutterFlowModel<AngAccessoriesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for logo component.
  late LogoModel logoModel;
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

  // Phantom 2 fields (Model / Model Number / Serial Number).
  FocusNode? textInputFocusNode6;
  TextEditingController? textInputTextController6;
  String? Function(BuildContext, String?)? textInputTextController6Validator;
  FocusNode? textInputFocusNode7;
  TextEditingController? textInputTextController7;
  String? Function(BuildContext, String?)? textInputTextController7Validator;
  FocusNode? textInputFocusNode8;
  TextEditingController? textInputTextController8;
  String? Function(BuildContext, String?)? textInputTextController8Validator;
  // Phantom 3 fields (Model / Model Number / Serial Number).
  FocusNode? textInputFocusNode9;
  TextEditingController? textInputTextController9;
  String? Function(BuildContext, String?)? textInputTextController9Validator;
  FocusNode? textInputFocusNode10;
  TextEditingController? textInputTextController10;
  String? Function(BuildContext, String?)? textInputTextController10Validator;
  FocusNode? textInputFocusNode11;
  TextEditingController? textInputTextController11;
  String? Function(BuildContext, String?)? textInputTextController11Validator;
  // Whether the optional extra phantom sections have been revealed.
  bool showPhantom2 = false;
  bool showPhantom3 = false;

  // State field(s) for the Notes widget.
  FocusNode? notesFocusNode;
  TextEditingController? notesTextController;
  String? Function(BuildContext, String?)? notesTextControllerValidator;

  @override
  void initState(BuildContext context) {
    logoModel = createModel(context, () => LogoModel());
  }

  @override
  void dispose() {
    logoModel.dispose();
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
    textInputFocusNode8?.dispose();
    textInputTextController8?.dispose();
    textInputFocusNode9?.dispose();
    textInputTextController9?.dispose();
    textInputFocusNode10?.dispose();
    textInputTextController10?.dispose();
    textInputFocusNode11?.dispose();
    textInputTextController11?.dispose();

    notesFocusNode?.dispose();
    notesTextController?.dispose();
  }
}
