import '/components/logo_widget.dart';
import '/components/phantoms_editor.dart';
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
  // Phantom 1-10 text fields (see PhantomsEditor).
  final phantoms = PhantomsController();

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

    phantoms.dispose();

    notesFocusNode?.dispose();
    notesTextController?.dispose();
  }
}
