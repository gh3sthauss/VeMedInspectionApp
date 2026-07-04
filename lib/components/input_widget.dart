import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'input_model.dart';
export 'input_model.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({super.key});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late InputModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InputModel());

    _model.textTextController ??= TextEditingController();
    _model.textFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 16.0),
          child: TextFormField(
            controller: _model.textTextController,
            focusNode: _model.textFocusNode,
            textCapitalization: TextCapitalization.words,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'dasddasddasda',
              alignLabelWithHint: false,
              hintText: 'dasdasd',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFE0E3E7),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF4B39EF),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF5963),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF5963),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              filled: true,
              fillColor: Color(0xFFF0F7FF),
              contentPadding:
                  EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 0.0, 10.0),
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: Color(0xFF14181B),
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
            validator: _model.textTextControllerValidator.asValidator(context),
            inputFormatters: [
              if (!isAndroid && !isiOS)
                TextInputFormatter.withFunction((oldValue, newValue) {
                  return TextEditingValue(
                    selection: newValue.selection,
                    text: newValue.text
                        .toCapitalization(TextCapitalization.words),
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}
