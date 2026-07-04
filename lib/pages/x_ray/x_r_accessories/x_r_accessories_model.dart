import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'x_r_accessories_widget.dart' show XRAccessoriesWidget;
import 'package:flutter/material.dart';

class XRAccessoriesModel extends FlutterFlowModel<XRAccessoriesWidget> {
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
  }
}
