import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode1;
  TextEditingController? textInputTextController1;
  String? Function(BuildContext, String?)? textInputTextController1Validator;
  // State field(s) for textInput widget.
  FocusNode? textInputFocusNode2;
  TextEditingController? textInputTextController2;
  String? Function(BuildContext, String?)? textInputTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textInputFocusNode1?.dispose();
    textInputTextController1?.dispose();

    textInputFocusNode2?.dispose();
    textInputTextController2?.dispose();
  }
}
