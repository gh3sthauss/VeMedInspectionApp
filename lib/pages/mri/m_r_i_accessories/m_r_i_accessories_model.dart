import '/components/logo_widget.dart';
import '/components/phantoms_editor.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'm_r_i_accessories_widget.dart' show MRIAccessoriesWidget;
import 'package:flutter/material.dart';

class MRIAccessoriesModel extends FlutterFlowModel<MRIAccessoriesWidget> {
  ///  State fields for stateful widgets in this page.

  // Phantom 1-10 text fields (see PhantomsEditor).
  final phantoms = PhantomsController();

  // Model for logo component.
  late LogoModel logoModel;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode10;
  TextEditingController? textInputTextController10;
  String? Function(BuildContext, String?)? textInputTextController10Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode11;
  TextEditingController? textInputTextController11;
  String? Function(BuildContext, String?)? textInputTextController11Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode12;
  TextEditingController? textInputTextController12;
  String? Function(BuildContext, String?)? textInputTextController12Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode13;
  TextEditingController? textInputTextController13;
  String? Function(BuildContext, String?)? textInputTextController13Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode14;
  TextEditingController? textInputTextController14;
  String? Function(BuildContext, String?)? textInputTextController14Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode15;
  TextEditingController? textInputTextController15;
  String? Function(BuildContext, String?)? textInputTextController15Validator;

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
    phantoms.dispose();

    textInputFocusNode10?.dispose();
    textInputTextController10?.dispose();

    textInputFocusNode11?.dispose();
    textInputTextController11?.dispose();

    textInputFocusNode12?.dispose();
    textInputTextController12?.dispose();

    textInputFocusNode13?.dispose();
    textInputTextController13?.dispose();

    textInputFocusNode14?.dispose();
    textInputTextController14?.dispose();

    textInputFocusNode15?.dispose();
    textInputTextController15?.dispose();

    notesFocusNode?.dispose();
    notesTextController?.dispose();
  }
}
