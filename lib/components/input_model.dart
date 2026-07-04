import '/flutter_flow/flutter_flow_util.dart';
import 'input_widget.dart' show InputWidget;
import 'package:flutter/material.dart';

class InputModel extends FlutterFlowModel<InputWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for text widget.
  FocusNode? textFocusNode;
  TextEditingController? textTextController;
  String? Function(BuildContext, String?)? textTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFocusNode?.dispose();
    textTextController?.dispose();
  }
}
