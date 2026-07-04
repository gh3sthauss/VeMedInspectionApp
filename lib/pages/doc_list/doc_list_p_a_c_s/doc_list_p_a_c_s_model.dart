import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'doc_list_p_a_c_s_widget.dart' show DocListPACSWidget;
import 'package:flutter/material.dart';

class DocListPACSModel extends FlutterFlowModel<DocListPACSWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for logo component.
  late LogoModel logoModel;

  @override
  void initState(BuildContext context) {
    logoModel = createModel(context, () => LogoModel());
  }

  @override
  void dispose() {
    logoModel.dispose();
  }
}
