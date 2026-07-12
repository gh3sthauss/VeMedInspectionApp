import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/doc_actions_sheet.dart';
import '/components/doc_naming.dart';
import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'doc_list_d_r_model.dart';
export 'doc_list_d_r_model.dart';

class DocListDRWidget extends StatefulWidget {
  const DocListDRWidget({super.key});

  static String routeName = 'DocListDR';
  static String routePath = '/docListDR';

  @override
  State<DocListDRWidget> createState() => _DocListDRWidgetState();
}

class _DocListDRWidgetState extends State<DocListDRWidget> {
  late DocListDRModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DocListDRModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.logoModel,
                updateCallback: () => safeSetState(() {}),
                child: LogoWidget(),
              ),
              Flexible(
                child: StreamBuilder<List<DrRecord>>(
                  stream: queryDrRecord(
                    queryBuilder: (drRecord) => drRecord.where(
                      'userID',
                      isEqualTo: currentUserUid,
                    ),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    List<DrRecord> listViewDrRecordList = snapshot.data!;

                    return ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        20.0,
                        0,
                        20.0,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: listViewDrRecordList.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.0),
                      itemBuilder: (context, listViewIndex) {
                        final listViewDrRecord =
                            listViewDrRecordList[listViewIndex];
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 320.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFF0F7FF),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(16.0),
                                onTap: () async {
                                  context.pushNamed(
                                    DrWidget.routeName,
                                    queryParameters: {
                                      'docRefDR': serializeParam(
                                        listViewDrRecord.reference,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          smartDocName(
                                            listViewDrRecord.sysGenDocName,
                                            'DR',
                                            listViewDrRecord.reference.id,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.readexPro(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 12.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          showDocActionsSheet(
                                            context,
                                            title: smartDocName(
                                              listViewDrRecord.sysGenDocName,
                                              'DR',
                                              listViewDrRecord.reference.id,
                                            ),
                                            onDownload: () async {
                                              await actions.exportDrPDF(
                                                listViewDrRecord,
                                              );
                                            },
                                            onDelete: () async {
                                              await listViewDrRecord.reference
                                                  .delete();
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.more_vert_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
