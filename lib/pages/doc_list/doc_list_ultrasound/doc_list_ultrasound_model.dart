import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'doc_list_ultrasound_widget.dart' show DocListUltrasoundWidget;
import 'package:flutter/material.dart';

class DocListUltrasoundModel extends FlutterFlowModel<DocListUltrasoundWidget> {
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
