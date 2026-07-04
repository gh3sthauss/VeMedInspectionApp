import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'x_r_dn_t_widget.dart' show XRDnTWidget;
import 'package:flutter/material.dart';

class XRDnTModel extends FlutterFlowModel<XRDnTWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for logo component.
  late LogoModel logoModel;
  // State field(s) for text widget.
  FocusNode? textFocusNode1;
  TextEditingController? textTextController1;
  String? Function(BuildContext, String?)? textTextController1Validator;
  // State field(s) for text widget.
  FocusNode? textFocusNode2;
  TextEditingController? textTextController2;
  String? Function(BuildContext, String?)? textTextController2Validator;
  // State field(s) for text widget.
  FocusNode? textFocusNode3;
  TextEditingController? textTextController3;
  String? Function(BuildContext, String?)? textTextController3Validator;
  // State field(s) for text widget.
  FocusNode? textFocusNode4;
  TextEditingController? textTextController4;
  String? Function(BuildContext, String?)? textTextController4Validator;
  // State field(s) for text widget.
  FocusNode? textFocusNode5;
  TextEditingController? textTextController5;
  String? Function(BuildContext, String?)? textTextController5Validator;
  // State field(s) for text widget.
  FocusNode? textFocusNode6;
  TextEditingController? textTextController6;
  String? Function(BuildContext, String?)? textTextController6Validator;
  // State field(s) for text widget.
  FocusNode? textFocusNode7;
  TextEditingController? textTextController7;
  String? Function(BuildContext, String?)? textTextController7Validator;

  @override
  void initState(BuildContext context) {
    logoModel = createModel(context, () => LogoModel());
  }

  @override
  void dispose() {
    logoModel.dispose();
    textFocusNode1?.dispose();
    textTextController1?.dispose();

    textFocusNode2?.dispose();
    textTextController2?.dispose();

    textFocusNode3?.dispose();
    textTextController3?.dispose();

    textFocusNode4?.dispose();
    textTextController4?.dispose();

    textFocusNode5?.dispose();
    textTextController5?.dispose();

    textFocusNode6?.dispose();
    textTextController6?.dispose();

    textFocusNode7?.dispose();
    textTextController7?.dispose();
  }
}
