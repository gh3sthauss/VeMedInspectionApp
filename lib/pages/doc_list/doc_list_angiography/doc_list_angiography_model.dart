import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'doc_list_angiography_widget.dart' show DocListAngiographyWidget;
import 'package:flutter/material.dart';

class DocListAngiographyModel
    extends FlutterFlowModel<DocListAngiographyWidget> {
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
