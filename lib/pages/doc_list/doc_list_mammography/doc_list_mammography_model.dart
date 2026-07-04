import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'doc_list_mammography_widget.dart' show DocListMammographyWidget;
import 'package:flutter/material.dart';

class DocListMammographyModel
    extends FlutterFlowModel<DocListMammographyWidget> {
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
