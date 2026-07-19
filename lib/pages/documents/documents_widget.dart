import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/logo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'documents_model.dart';
export 'documents_model.dart';

class DocumentsWidget extends StatefulWidget {
  const DocumentsWidget({super.key});

  static String routeName = 'Documents';
  static String routePath = '/documents';

  @override
  State<DocumentsWidget> createState() => _DocumentsWidgetState();
}

class _DocumentsWidgetState extends State<DocumentsWidget> {
  late DocumentsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DocumentsModel());
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryAngiographyRecordCount(
                            queryBuilder: (angiographyRecord) =>
                                angiographyRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'Angiography',
                              count: snapshot.data,
                              onTap: () => context.pushNamed(
                                  DocListAngiographyWidget.routeName),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryCtRecordCount(
                            queryBuilder: (ctRecord) => ctRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'CT',
                              count: snapshot.data,
                              onTap: () =>
                                  context.pushNamed(DocListCTWidget.routeName),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryUltrasoundRecordCount(
                            queryBuilder: (ultrasoundRecord) =>
                                ultrasoundRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'Ultrasound',
                              count: snapshot.data,
                              onTap: () => context
                                  .pushNamed(DocListUltrasoundWidget.routeName),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryMriRecordCount(
                            queryBuilder: (mriRecord) => mriRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'MRI',
                              count: snapshot.data,
                              onTap: () =>
                                  context.pushNamed(DocListMRIWidget.routeName),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryXRayRecordCount(
                            queryBuilder: (xRayRecord) => xRayRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'X-Ray',
                              count: snapshot.data,
                              onTap: () => context
                                  .pushNamed(DocListXrayWidget.routeName),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryFluoroscopyRecordCount(
                            queryBuilder: (fluoroscopyRecord) =>
                                fluoroscopyRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'Fluoroscopy',
                              count: snapshot.data,
                              onTap: () => context.pushNamed(
                                  DocListFlouroscopyWidget.routeName),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryCArmRecordCount(
                            queryBuilder: (cArmRecord) => cArmRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'C-Arm',
                              count: snapshot.data,
                              onTap: () => context
                                  .pushNamed(DocListCArmWidget.routeName),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryMammographyRecordCount(
                            queryBuilder: (mammographyRecord) =>
                                mammographyRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'Mammography',
                              count: snapshot.data,
                              onTap: () => context.pushNamed(
                                  DocListMammographyWidget.routeName),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryPacsRecordCount(
                            queryBuilder: (pacsRecord) => pacsRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'PACS',
                              count: snapshot.data,
                              onTap: () => context
                                  .pushNamed(DocListPACSWidget.routeName),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryDrRecordCount(
                            queryBuilder: (drRecord) => drRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'DR',
                              count: snapshot.data,
                              onTap: () =>
                                  context.pushNamed(DocListDRWidget.routeName),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<int>(
                          future: queryCrRecordCount(
                            queryBuilder: (crRecord) => crRecord.where(
                              'userID',
                              isEqualTo: currentUserUid,
                            ),
                          ),
                          builder: (context, snapshot) {
                            return _ModalityCountRow(
                              label: 'CR',
                              count: snapshot.data,
                              onTap: () =>
                                  context.pushNamed(DocListCRWidget.routeName),
                            );
                          },
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 12.0))
                        .addToStart(SizedBox(height: 20.0))
                        .addToEnd(SizedBox(height: 100.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single modality row: left-aligned name (semibold), right-aligned count
/// in a rounded badge. Shows a spinner while `count` is still loading (null),
/// and dims itself when the count is zero to signal "nothing here yet".
class _ModalityCountRow extends StatelessWidget {
  const _ModalityCountRow({
    required this.label,
    required this.count,
    required this.onTap,
  });

  final String label;
  final int? count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (count == null) {
      return Center(
        child: SizedBox(
          width: 36.0,
          height: 36.0,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              FlutterFlowTheme.of(context).primary,
            ),
          ),
        ),
      );
    }

    final theme = FlutterFlowTheme.of(context);
    final isEmpty = count == 0;

    return Opacity(
      opacity: isEmpty ? 0.55 : 1.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Container(
            width: 330.0,
            height: 56.0,
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 12.0, 0.0),
            decoration: BoxDecoration(
              color: Color(0xFFF0F7FF),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.readexPro(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryText,
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minWidth: 28.0),
                  height: 28.0,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFDEE7F0),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Text(
                    count.toString(),
                    style: GoogleFonts.readexPro(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: theme.secondaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
