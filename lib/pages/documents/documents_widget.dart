import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/logo_widget.dart';
import '/components/modality_icons.dart';
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

  /// Each modality: label, the count query for the current user, and the
  /// doc-list route to open on tap. Rendered as a grid of tiles below.
  List<_ModalitySpec> get _modalities => [
        _ModalitySpec(
          label: 'Angiography',
          countFuture: queryAngiographyRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () =>
              context.pushNamed(DocListAngiographyWidget.routeName),
        ),
        _ModalitySpec(
          label: 'CT',
          countFuture: queryCtRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () => context.pushNamed(DocListCTWidget.routeName),
        ),
        _ModalitySpec(
          label: 'Ultrasound',
          countFuture: queryUltrasoundRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () => context.pushNamed(DocListUltrasoundWidget.routeName),
        ),
        _ModalitySpec(
          label: 'MRI',
          countFuture: queryMriRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () => context.pushNamed(DocListMRIWidget.routeName),
        ),
        _ModalitySpec(
          label: 'X-Ray',
          countFuture: queryXRayRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () => context.pushNamed(DocListXrayWidget.routeName),
        ),
        _ModalitySpec(
          label: 'Fluoroscopy',
          countFuture: queryFluoroscopyRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () =>
              context.pushNamed(DocListFlouroscopyWidget.routeName),
        ),
        _ModalitySpec(
          label: 'C-Arm',
          countFuture: queryCArmRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () => context.pushNamed(DocListCArmWidget.routeName),
        ),
        _ModalitySpec(
          label: 'Mammography',
          countFuture: queryMammographyRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () =>
              context.pushNamed(DocListMammographyWidget.routeName),
        ),
        _ModalitySpec(
          label: 'PACS',
          countFuture: queryPacsRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () => context.pushNamed(DocListPACSWidget.routeName),
        ),
        _ModalitySpec(
          label: 'DR',
          countFuture: queryDrRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () => context.pushNamed(DocListDRWidget.routeName),
        ),
        _ModalitySpec(
          label: 'CR',
          countFuture: queryCrRecordCount(
            queryBuilder: (q) => q.where('userID', isEqualTo: currentUserUid),
          ),
          onTap: () => context.pushNamed(DocListCRWidget.routeName),
        ),
      ];

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
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 100.0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 0.74,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: _modalities
                        .map(
                          (m) => FutureBuilder<int>(
                            future: m.countFuture,
                            builder: (context, snapshot) => _ModalityTile(
                              label: m.label,
                              count: snapshot.data,
                              onTap: m.onTap,
                            ),
                          ),
                        )
                        .toList(),
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

/// Declarative description of one modality tile on the Documents grid.
class _ModalitySpec {
  const _ModalitySpec({
    required this.label,
    required this.countFuture,
    required this.onTap,
  });

  final String label;
  final Future<int> countFuture;
  final VoidCallback onTap;
}

/// A square card: modality icon centered, label beneath, and a small count
/// badge in the top-right corner. Shows a spinner while `count` is loading
/// (null) and dims itself when the count is zero ("nothing here yet").
class _ModalityTile extends StatelessWidget {
  const _ModalityTile({
    required this.label,
    required this.count,
    required this.onTap,
  });

  final String label;
  final int? count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isLoading = count == null;
    final isEmpty = count == 0;

    return Opacity(
      opacity: (!isLoading && isEmpty) ? 0.55 : 1.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Container(
            decoration: modalityCardDecoration(),
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with a small notification-style count badge pinned to
                // its top-right corner. The badge is hidden when the count is
                // zero — the dimmed card already signals "nothing here yet".
                SizedBox(
                  width: 64.0,
                  height: 64.0,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(child: ModalityIcon(label: label, size: 64.0)),
                      if (isLoading)
                        PositionedDirectional(
                          top: -2.0,
                          end: -4.0,
                          child: SizedBox(
                            width: 16.0,
                            height: 16.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.primary,
                              ),
                            ),
                          ),
                        )
                      else if (!isEmpty)
                        PositionedDirectional(
                          top: -4.0,
                          end: -6.0,
                          child: _CountBadge(count: count!),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.readexPro(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryText,
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

/// A small circular notification badge (like an app icon's unread count):
/// solid indigo pill with a white ring so it lifts off the icon. Renders a
/// circle for single digits and a short pill for larger counts.
class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 22.0, minHeight: 22.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFF2E54D6),
        borderRadius: BorderRadius.circular(11.0),
        border: Border.all(color: Colors.white, width: 2.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x332E54D6),
            blurRadius: 4.0,
            offset: Offset(0.0, 1.0),
          ),
        ],
      ),
      child: Text(
        count.toString(),
        style: GoogleFonts.readexPro(
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.0,
        ),
      ),
    );
  }
}
