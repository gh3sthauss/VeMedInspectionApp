import '/components/logo_widget.dart';
import '/components/phantoms_editor.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'c_t_accessories_widget.dart' show CTAccessoriesWidget;
import 'package:flutter/material.dart';

class CTAccessoriesModel extends FlutterFlowModel<CTAccessoriesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for logo component.
  late LogoModel logoModel;
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
    textInputFocusNode5?.dispose();
    textInputTextController5?.dispose();

    textInputFocusNode6?.dispose();
    textInputTextController6?.dispose();

    textInputFocusNode7?.dispose();
    textInputTextController7?.dispose();

    phantoms.dispose();

    notesFocusNode?.dispose();
    notesTextController?.dispose();
  }
}
