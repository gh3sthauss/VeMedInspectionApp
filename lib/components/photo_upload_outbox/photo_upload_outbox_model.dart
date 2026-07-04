import 'dart:typed_data';

import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_model.dart';
import 'photo_upload_outbox_widget.dart' show PhotoUploadOutboxWidget;

class PhotoUploadOutboxModel
    extends FlutterFlowModel<PhotoUploadOutboxWidget> {
  Uint8List? pendingLocalPreview;
  bool isEnqueuing = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
