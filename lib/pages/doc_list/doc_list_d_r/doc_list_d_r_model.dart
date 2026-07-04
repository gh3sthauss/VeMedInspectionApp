import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'doc_list_d_r_widget.dart' show DocListDRWidget;
import 'package:flutter/material.dart';

class DocListDRModel extends FlutterFlowModel<DocListDRWidget> {
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
