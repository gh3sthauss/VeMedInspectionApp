import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'p_a_c_s_other_notes_widget.dart' show PACSOtherNotesWidget;
import 'package:flutter/material.dart';

class PACSOtherNotesModel extends FlutterFlowModel<PACSOtherNotesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for logo component.
  late LogoModel logoModel;
  // State field(s) for text widget.
  FocusNode? textFocusNode;
  TextEditingController? textTextController;
  String? Function(BuildContext, String?)? textTextControllerValidator;

  @override
  void initState(BuildContext context) {
    logoModel = createModel(context, () => LogoModel());
  }

  @override
  void dispose() {
    logoModel.dispose();
    textFocusNode?.dispose();
    textTextController?.dispose();
  }
}
