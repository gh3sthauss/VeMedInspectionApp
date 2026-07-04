import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : SignInWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : SignInWidget(),
        ),
        FFRoute(
          name: CreateReportWidget.routeName,
          path: CreateReportWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'CreateReport')
              : CreateReportWidget(),
        ),
        FFRoute(
            name: DocumentsWidget.routeName,
            path: DocumentsWidget.routePath,
            builder: (context, params) => params.isEmpty
                ? NavBarPage(initialPage: 'Documents')
                : NavBarPage(
                    initialPage: 'Documents',
                    page: DocumentsWidget(),
                  )),
        FFRoute(
            name: MriWidget.routeName,
            path: MriWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: MriWidget(
                    docRefMRI: params.getParam(
                      'docRefMRI',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['MRI'],
                    ),
                  ),
                )),
        FFRoute(
            name: CtWidget.routeName,
            path: CtWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: CtWidget(
                    docData: params.getParam(
                      'docData',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['CT'],
                    ),
                  ),
                )),
        FFRoute(
            name: XRayWidget.routeName,
            path: XRayWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: XRayWidget(
                    docRefXRay: params.getParam(
                      'docRefXRay',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['XRay'],
                    ),
                  ),
                )),
        FFRoute(
            name: FlouroscopyWidget.routeName,
            path: FlouroscopyWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: FlouroscopyWidget(
                    docRefFL: params.getParam(
                      'docRefFL',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['Fluoroscopy'],
                    ),
                  ),
                )),
        FFRoute(
            name: CArmWidget.routeName,
            path: CArmWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: CArmWidget(
                    docRefCArm: params.getParam(
                      'docRefCArm',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['CArm'],
                    ),
                  ),
                )),
        FFRoute(
            name: MammographyWidget.routeName,
            path: MammographyWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: MammographyWidget(
                    docRefMamm: params.getParam(
                      'docRefMamm',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['Mammography'],
                    ),
                  ),
                )),
        FFRoute(
            name: PacsWidget.routeName,
            path: PacsWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: PacsWidget(
                    docRefPACS: params.getParam(
                      'docRefPACS',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['PACS'],
                    ),
                  ),
                )),
        FFRoute(
            name: DrWidget.routeName,
            path: DrWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DrWidget(
                    docRefDR: params.getParam(
                      'docRefDR',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['DR'],
                    ),
                  ),
                )),
        FFRoute(
            name: CrWidget.routeName,
            path: CrWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: CrWidget(
                    docRefCR: params.getParam(
                      'docRefCR',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['CR'],
                    ),
                  ),
                )),
        FFRoute(
          name: CTSystemGeneralWidget.routeName,
          path: CTSystemGeneralWidget.routePath,
          builder: (context, params) => CTSystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CT'],
            ),
          ),
        ),
        FFRoute(
          name: CTGantryWidget.routeName,
          path: CTGantryWidget.routePath,
          builder: (context, params) => CTGantryWidget(
            docDataGantry: params.getParam(
              'docDataGantry',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CT'],
            ),
          ),
        ),
        FFRoute(
          name: CTCoolingSystemWidget.routeName,
          path: CTCoolingSystemWidget.routePath,
          builder: (context, params) => CTCoolingSystemWidget(
            docDataCS: params.getParam(
              'docDataCS',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CT'],
            ),
          ),
        ),
        FFRoute(
          name: CTPatientTableWidget.routeName,
          path: CTPatientTableWidget.routePath,
          builder: (context, params) => CTPatientTableWidget(
            docDataPT: params.getParam(
              'docDataPT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CT'],
            ),
          ),
        ),
        FFRoute(
          name: CTConsoleAndWorkstationsWidget.routeName,
          path: CTConsoleAndWorkstationsWidget.routePath,
          builder: (context, params) => CTConsoleAndWorkstationsWidget(
            docDataCW: params.getParam(
              'docDataCW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CT'],
            ),
          ),
        ),
        FFRoute(
          name: CTCosmeticConditionWidget.routeName,
          path: CTCosmeticConditionWidget.routePath,
          builder: (context, params) => CTCosmeticConditionWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CT'],
            ),
          ),
        ),
        FFRoute(
          name: CTAccessoriesWidget.routeName,
          path: CTAccessoriesWidget.routePath,
          builder: (context, params) => CTAccessoriesWidget(
            docDataA: params.getParam(
              'docDataA',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CT'],
            ),
          ),
        ),
        FFRoute(
          name: CTDismantlingNTransportWidget.routeName,
          path: CTDismantlingNTransportWidget.routePath,
          builder: (context, params) => CTDismantlingNTransportWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CT'],
            ),
          ),
        ),
        FFRoute(
          name: CTOtherNotesWidget.routeName,
          path: CTOtherNotesWidget.routePath,
          builder: (context, params) => CTOtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CT'],
            ),
          ),
        ),
        FFRoute(
          name: SignInWidget.routeName,
          path: SignInWidget.routePath,
          builder: (context, params) => SignInWidget(),
        ),
        FFRoute(
          name: ProfileWidget.routeName,
          path: ProfileWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Profile')
              : ProfileWidget(),
        ),
        FFRoute(
            name: DocListUltrasoundWidget.routeName,
            path: DocListUltrasoundWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListUltrasoundWidget(),
                )),
        FFRoute(
            name: UltrasoundWidget.routeName,
            path: UltrasoundWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: UltrasoundWidget(
                    docData: params.getParam(
                      'docData',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['Ultrasound'],
                    ),
                  ),
                )),
        FFRoute(
          name: USAccesoriesWidget.routeName,
          path: USAccesoriesWidget.routePath,
          builder: (context, params) => USAccesoriesWidget(
            docDataA: params.getParam(
              'docDataA',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Ultrasound'],
            ),
          ),
        ),
        FFRoute(
          name: USCosmeticWidget.routeName,
          path: USCosmeticWidget.routePath,
          builder: (context, params) => USCosmeticWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Ultrasound'],
            ),
          ),
        ),
        FFRoute(
          name: USDismantleNTransportWidget.routeName,
          path: USDismantleNTransportWidget.routePath,
          builder: (context, params) => USDismantleNTransportWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Ultrasound'],
            ),
          ),
        ),
        FFRoute(
          name: USOtherNotesWidget.routeName,
          path: USOtherNotesWidget.routePath,
          builder: (context, params) => USOtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Ultrasound'],
            ),
          ),
        ),
        FFRoute(
          name: USSoftwareWidget.routeName,
          path: USSoftwareWidget.routePath,
          builder: (context, params) => USSoftwareWidget(
            docRefSoft: params.getParam(
              'docRefSoft',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Ultrasound'],
            ),
          ),
        ),
        FFRoute(
          name: USProbesWidget.routeName,
          path: USProbesWidget.routePath,
          builder: (context, params) => USProbesWidget(
            docRefProbes: params.getParam(
              'docRefProbes',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Ultrasound'],
            ),
          ),
        ),
        FFRoute(
          name: MRISystemGeneralWidget.routeName,
          path: MRISystemGeneralWidget.routePath,
          builder: (context, params) => MRISystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: DRSystemGeneralWidget.routeName,
          path: DRSystemGeneralWidget.routePath,
          builder: (context, params) => DRSystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['DR'],
            ),
          ),
        ),
        FFRoute(
          name: DROtherNotesWidget.routeName,
          path: DROtherNotesWidget.routePath,
          builder: (context, params) => DROtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['DR'],
            ),
          ),
        ),
        FFRoute(
          name: DRDnTWidget.routeName,
          path: DRDnTWidget.routePath,
          builder: (context, params) => DRDnTWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['DR'],
            ),
          ),
        ),
        FFRoute(
          name: DRCosmeticWidget.routeName,
          path: DRCosmeticWidget.routePath,
          builder: (context, params) => DRCosmeticWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['DR'],
            ),
          ),
        ),
        FFRoute(
          name: DRAccessoriesWidget.routeName,
          path: DRAccessoriesWidget.routePath,
          builder: (context, params) => DRAccessoriesWidget(
            docDataA: params.getParam(
              'docDataA',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['DR'],
            ),
          ),
        ),
        FFRoute(
          name: DRCassettesWidget.routeName,
          path: DRCassettesWidget.routePath,
          builder: (context, params) => DRCassettesWidget(
            docRefProbes: params.getParam(
              'docRefProbes',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['DR'],
            ),
          ),
        ),
        FFRoute(
          name: DRConsoleNWorkstationsWidget.routeName,
          path: DRConsoleNWorkstationsWidget.routePath,
          builder: (context, params) => DRConsoleNWorkstationsWidget(
            docDataCW: params.getParam(
              'docDataCW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['DR'],
            ),
          ),
        ),
        FFRoute(
          name: DRDetectorWidget.routeName,
          path: DRDetectorWidget.routePath,
          builder: (context, params) => DRDetectorWidget(
            docDataDetector: params.getParam(
              'docDataDetector',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['DR'],
            ),
          ),
        ),
        FFRoute(
          name: CRAccessoriesWidget.routeName,
          path: CRAccessoriesWidget.routePath,
          builder: (context, params) => CRAccessoriesWidget(
            docDataA: params.getParam(
              'docDataA',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CR'],
            ),
          ),
        ),
        FFRoute(
          name: CRCassettesWidget.routeName,
          path: CRCassettesWidget.routePath,
          builder: (context, params) => CRCassettesWidget(
            docRefProbes: params.getParam(
              'docRefProbes',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CR'],
            ),
          ),
        ),
        FFRoute(
          name: CRConsoleNWorkstationsWidget.routeName,
          path: CRConsoleNWorkstationsWidget.routePath,
          builder: (context, params) => CRConsoleNWorkstationsWidget(
            docDataCW: params.getParam(
              'docDataCW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CR'],
            ),
          ),
        ),
        FFRoute(
          name: CRCosmeticWidget.routeName,
          path: CRCosmeticWidget.routePath,
          builder: (context, params) => CRCosmeticWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CR'],
            ),
          ),
        ),
        FFRoute(
          name: CRDetectorWidget.routeName,
          path: CRDetectorWidget.routePath,
          builder: (context, params) => CRDetectorWidget(
            docDataDetector: params.getParam(
              'docDataDetector',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CR'],
            ),
          ),
        ),
        FFRoute(
          name: CRDnTWidget.routeName,
          path: CRDnTWidget.routePath,
          builder: (context, params) => CRDnTWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CR'],
            ),
          ),
        ),
        FFRoute(
          name: CROtherNotesWidget.routeName,
          path: CROtherNotesWidget.routePath,
          builder: (context, params) => CROtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CR'],
            ),
          ),
        ),
        FFRoute(
          name: CRSystemGeneralWidget.routeName,
          path: CRSystemGeneralWidget.routePath,
          builder: (context, params) => CRSystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CR'],
            ),
          ),
        ),
        FFRoute(
          name: PACSAccessoriesWidget.routeName,
          path: PACSAccessoriesWidget.routePath,
          builder: (context, params) => PACSAccessoriesWidget(
            docDataA: params.getParam(
              'docDataA',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['PACS'],
            ),
          ),
        ),
        FFRoute(
          name: PACSCassettesWidget.routeName,
          path: PACSCassettesWidget.routePath,
          builder: (context, params) => PACSCassettesWidget(
            docRefProbes: params.getParam(
              'docRefProbes',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['PACS'],
            ),
          ),
        ),
        FFRoute(
          name: PACSConsoleNWorkstationsWidget.routeName,
          path: PACSConsoleNWorkstationsWidget.routePath,
          builder: (context, params) => PACSConsoleNWorkstationsWidget(
            docDataCW: params.getParam(
              'docDataCW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['PACS'],
            ),
          ),
        ),
        FFRoute(
          name: PACSCosmeticWidget.routeName,
          path: PACSCosmeticWidget.routePath,
          builder: (context, params) => PACSCosmeticWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['PACS'],
            ),
          ),
        ),
        FFRoute(
          name: PACSDnTWidget.routeName,
          path: PACSDnTWidget.routePath,
          builder: (context, params) => PACSDnTWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['PACS'],
            ),
          ),
        ),
        FFRoute(
          name: PACSOtherNotesWidget.routeName,
          path: PACSOtherNotesWidget.routePath,
          builder: (context, params) => PACSOtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['PACS'],
            ),
          ),
        ),
        FFRoute(
          name: PACSSystemGeneralWidget.routeName,
          path: PACSSystemGeneralWidget.routePath,
          builder: (context, params) => PACSSystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['PACS'],
            ),
          ),
        ),
        FFRoute(
          name: MMAccessoriesWidget.routeName,
          path: MMAccessoriesWidget.routePath,
          builder: (context, params) => MMAccessoriesWidget(
            docDataA: params.getParam(
              'docDataA',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Mammography'],
            ),
          ),
        ),
        FFRoute(
          name: MMConsoleNWorkstationsWidget.routeName,
          path: MMConsoleNWorkstationsWidget.routePath,
          builder: (context, params) => MMConsoleNWorkstationsWidget(
            docDataCW: params.getParam(
              'docDataCW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Mammography'],
            ),
          ),
        ),
        FFRoute(
          name: MMCosmeticWidget.routeName,
          path: MMCosmeticWidget.routePath,
          builder: (context, params) => MMCosmeticWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Mammography'],
            ),
          ),
        ),
        FFRoute(
          name: MMDnTWidget.routeName,
          path: MMDnTWidget.routePath,
          builder: (context, params) => MMDnTWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Mammography'],
            ),
          ),
        ),
        FFRoute(
          name: MMOtherNotesWidget.routeName,
          path: MMOtherNotesWidget.routePath,
          builder: (context, params) => MMOtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Mammography'],
            ),
          ),
        ),
        FFRoute(
          name: MMSystemGeneralWidget.routeName,
          path: MMSystemGeneralWidget.routePath,
          builder: (context, params) => MMSystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Mammography'],
            ),
          ),
        ),
        FFRoute(
          name: MMTubeWidget.routeName,
          path: MMTubeWidget.routePath,
          builder: (context, params) => MMTubeWidget(
            docRefSoft: params.getParam(
              'docRefSoft',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Mammography'],
            ),
          ),
        ),
        FFRoute(
          name: MMDetectorWidget.routeName,
          path: MMDetectorWidget.routePath,
          builder: (context, params) => MMDetectorWidget(
            docDataDetector: params.getParam(
              'docDataDetector',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Mammography'],
            ),
          ),
        ),
        FFRoute(
          name: PACSDetectorWidget.routeName,
          path: PACSDetectorWidget.routePath,
          builder: (context, params) => PACSDetectorWidget(
            docDataDetector: params.getParam(
              'docDataDetector',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['PACS'],
            ),
          ),
        ),
        FFRoute(
          name: FLAccessoriesWidget.routeName,
          path: FLAccessoriesWidget.routePath,
          builder: (context, params) => FLAccessoriesWidget(
            docDataA: params.getParam(
              'docDataA',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Fluoroscopy'],
            ),
          ),
        ),
        FFRoute(
          name: FLConsoleNWorkstationsWidget.routeName,
          path: FLConsoleNWorkstationsWidget.routePath,
          builder: (context, params) => FLConsoleNWorkstationsWidget(
            docDataCW: params.getParam(
              'docDataCW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Fluoroscopy'],
            ),
          ),
        ),
        FFRoute(
          name: FLCosmeticWidget.routeName,
          path: FLCosmeticWidget.routePath,
          builder: (context, params) => FLCosmeticWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Fluoroscopy'],
            ),
          ),
        ),
        FFRoute(
          name: FLDetectorWidget.routeName,
          path: FLDetectorWidget.routePath,
          builder: (context, params) => FLDetectorWidget(
            docDataDetector: params.getParam(
              'docDataDetector',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Fluoroscopy'],
            ),
          ),
        ),
        FFRoute(
          name: FLDnTWidget.routeName,
          path: FLDnTWidget.routePath,
          builder: (context, params) => FLDnTWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Fluoroscopy'],
            ),
          ),
        ),
        FFRoute(
          name: FLOtherNotesWidget.routeName,
          path: FLOtherNotesWidget.routePath,
          builder: (context, params) => FLOtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Fluoroscopy'],
            ),
          ),
        ),
        FFRoute(
          name: FLSystemGeneralWidget.routeName,
          path: FLSystemGeneralWidget.routePath,
          builder: (context, params) => FLSystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Fluoroscopy'],
            ),
          ),
        ),
        FFRoute(
          name: FLTubeWidget.routeName,
          path: FLTubeWidget.routePath,
          builder: (context, params) => FLTubeWidget(
            docRefSoft: params.getParam(
              'docRefSoft',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Fluoroscopy'],
            ),
          ),
        ),
        FFRoute(
          name: FLTableWidget.routeName,
          path: FLTableWidget.routePath,
          builder: (context, params) => FLTableWidget(
            docRefSoft: params.getParam(
              'docRefSoft',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Fluoroscopy'],
            ),
          ),
        ),
        FFRoute(
          name: CASystemGeneralWidget.routeName,
          path: CASystemGeneralWidget.routePath,
          builder: (context, params) => CASystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CArm'],
            ),
          ),
        ),
        FFRoute(
          name: CADetectorWidget.routeName,
          path: CADetectorWidget.routePath,
          builder: (context, params) => CADetectorWidget(
            docDataDetector: params.getParam(
              'docDataDetector',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CArm'],
            ),
          ),
        ),
        FFRoute(
          name: CATubeWidget.routeName,
          path: CATubeWidget.routePath,
          builder: (context, params) => CATubeWidget(
            docRefSoft: params.getParam(
              'docRefSoft',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CArm'],
            ),
          ),
        ),
        FFRoute(
          name: CASoftwareWidget.routeName,
          path: CASoftwareWidget.routePath,
          builder: (context, params) => CASoftwareWidget(
            docRefSoft: params.getParam(
              'docRefSoft',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CArm'],
            ),
          ),
        ),
        FFRoute(
          name: CAAccessoriesWidget.routeName,
          path: CAAccessoriesWidget.routePath,
          builder: (context, params) => CAAccessoriesWidget(
            docDataA: params.getParam(
              'docDataA',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CArm'],
            ),
          ),
        ),
        FFRoute(
          name: CACosmeticWidget.routeName,
          path: CACosmeticWidget.routePath,
          builder: (context, params) => CACosmeticWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CArm'],
            ),
          ),
        ),
        FFRoute(
          name: CADnTWidget.routeName,
          path: CADnTWidget.routePath,
          builder: (context, params) => CADnTWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CArm'],
            ),
          ),
        ),
        FFRoute(
          name: CAOtherNotesWidget.routeName,
          path: CAOtherNotesWidget.routePath,
          builder: (context, params) => CAOtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['CArm'],
            ),
          ),
        ),
        FFRoute(
          name: XRAccessoriesWidget.routeName,
          path: XRAccessoriesWidget.routePath,
          builder: (context, params) => XRAccessoriesWidget(
            docDataA: params.getParam(
              'docDataA',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['XRay'],
            ),
          ),
        ),
        FFRoute(
          name: XRConsoleNWorkstationsWidget.routeName,
          path: XRConsoleNWorkstationsWidget.routePath,
          builder: (context, params) => XRConsoleNWorkstationsWidget(
            docDataCW: params.getParam(
              'docDataCW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['XRay'],
            ),
          ),
        ),
        FFRoute(
          name: XRCosmeticWidget.routeName,
          path: XRCosmeticWidget.routePath,
          builder: (context, params) => XRCosmeticWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['XRay'],
            ),
          ),
        ),
        FFRoute(
          name: XRDetectorWidget.routeName,
          path: XRDetectorWidget.routePath,
          builder: (context, params) => XRDetectorWidget(
            docDataDetector: params.getParam(
              'docDataDetector',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['XRay'],
            ),
          ),
        ),
        FFRoute(
          name: XRDnTWidget.routeName,
          path: XRDnTWidget.routePath,
          builder: (context, params) => XRDnTWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['XRay'],
            ),
          ),
        ),
        FFRoute(
          name: XROtherNotesWidget.routeName,
          path: XROtherNotesWidget.routePath,
          builder: (context, params) => XROtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['XRay'],
            ),
          ),
        ),
        FFRoute(
          name: XRSystemGeneralWidget.routeName,
          path: XRSystemGeneralWidget.routePath,
          builder: (context, params) => XRSystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['XRay'],
            ),
          ),
        ),
        FFRoute(
          name: XRTubeWidget.routeName,
          path: XRTubeWidget.routePath,
          builder: (context, params) => XRTubeWidget(
            docRefSoft: params.getParam(
              'docRefSoft',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['XRay'],
            ),
          ),
        ),
        FFRoute(
          name: XRTableWidget.routeName,
          path: XRTableWidget.routePath,
          builder: (context, params) => XRTableWidget(
            docRefSoft: params.getParam(
              'docRefSoft',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['XRay'],
            ),
          ),
        ),
        FFRoute(
          name: MRIPatientTableWidget.routeName,
          path: MRIPatientTableWidget.routePath,
          builder: (context, params) => MRIPatientTableWidget(
            docDataPT: params.getParam(
              'docDataPT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRIMagnetWidget.routeName,
          path: MRIMagnetWidget.routePath,
          builder: (context, params) => MRIMagnetWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRIConsoleNWorkstationsWidget.routeName,
          path: MRIConsoleNWorkstationsWidget.routePath,
          builder: (context, params) => MRIConsoleNWorkstationsWidget(
            docDataCW: params.getParam(
              'docDataCW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRICoilsWidget.routeName,
          path: MRICoilsWidget.routePath,
          builder: (context, params) => MRICoilsWidget(
            docRefCoil: params.getParam(
              'docRefCoil',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRICoolingSystemWidget.routeName,
          path: MRICoolingSystemWidget.routePath,
          builder: (context, params) => MRICoolingSystemWidget(
            docRefCooling: params.getParam(
              'docRefCooling',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRIMarsImagerWidget.routeName,
          path: MRIMarsImagerWidget.routePath,
          builder: (context, params) => MRIMarsImagerWidget(
            docRefImager: params.getParam(
              'docRefImager',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRIDnTWidget.routeName,
          path: MRIDnTWidget.routePath,
          builder: (context, params) => MRIDnTWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MriEcgperuWidget.routeName,
          path: MriEcgperuWidget.routePath,
          builder: (context, params) => MriEcgperuWidget(
            docDataPT: params.getParam(
              'docDataPT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRIPowerstagesWidget.routeName,
          path: MRIPowerstagesWidget.routePath,
          builder: (context, params) => MRIPowerstagesWidget(
            docDataPT: params.getParam(
              'docDataPT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRITalesLastReplacementWidget.routeName,
          path: MRITalesLastReplacementWidget.routePath,
          builder: (context, params) => MRITalesLastReplacementWidget(
            docDataPT: params.getParam(
              'docDataPT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRICosmeticWidget.routeName,
          path: MRICosmeticWidget.routePath,
          builder: (context, params) => MRICosmeticWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRILocalServiceWidget.routeName,
          path: MRILocalServiceWidget.routePath,
          builder: (context, params) => MRILocalServiceWidget(
            docDataPT: params.getParam(
              'docDataPT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRIOtherNotesWidget.routeName,
          path: MRIOtherNotesWidget.routePath,
          builder: (context, params) => MRIOtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
          name: MRIAccessoriesWidget.routeName,
          path: MRIAccessoriesWidget.routePath,
          builder: (context, params) => MRIAccessoriesWidget(
            docDataA: params.getParam(
              'docDataA',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['MRI'],
            ),
          ),
        ),
        FFRoute(
            name: DocListXrayWidget.routeName,
            path: DocListXrayWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListXrayWidget(),
                )),
        FFRoute(
            name: DocListCTWidget.routeName,
            path: DocListCTWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListCTWidget(),
                )),
        FFRoute(
            name: DocListPACSWidget.routeName,
            path: DocListPACSWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListPACSWidget(),
                )),
        FFRoute(
            name: DocListDRWidget.routeName,
            path: DocListDRWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListDRWidget(),
                )),
        FFRoute(
            name: DocListCRWidget.routeName,
            path: DocListCRWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListCRWidget(),
                )),
        FFRoute(
            name: DocListCArmWidget.routeName,
            path: DocListCArmWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListCArmWidget(),
                )),
        FFRoute(
            name: DocListFlouroscopyWidget.routeName,
            path: DocListFlouroscopyWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListFlouroscopyWidget(),
                )),
        FFRoute(
            name: DocListMammographyWidget.routeName,
            path: DocListMammographyWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListMammographyWidget(),
                )),
        FFRoute(
            name: DocListMRIWidget.routeName,
            path: DocListMRIWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListMRIWidget(),
                )),
        FFRoute(
            name: TestWidget.routeName,
            path: TestWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: TestWidget(),
                )),
        FFRoute(
            name: AngiographyWidget.routeName,
            path: AngiographyWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: AngiographyWidget(
                    docData: params.getParam(
                      'docData',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['Angiography'],
                    ),
                  ),
                )),
        FFRoute(
          name: AngSystemGeneralWidget.routeName,
          path: AngSystemGeneralWidget.routePath,
          builder: (context, params) => AngSystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Angiography'],
            ),
          ),
        ),
        FFRoute(
          name: AngAccessoriesWidget.routeName,
          path: AngAccessoriesWidget.routePath,
          builder: (context, params) => AngAccessoriesWidget(
            docDataAng: params.getParam(
              'docDataAng',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Angiography'],
            ),
          ),
        ),
        FFRoute(
          name: AngCosmeticWidget.routeName,
          path: AngCosmeticWidget.routePath,
          builder: (context, params) => AngCosmeticWidget(
            docDataCC: params.getParam(
              'docDataCC',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Angiography'],
            ),
          ),
        ),
        FFRoute(
          name: AngDnTWidget.routeName,
          path: AngDnTWidget.routePath,
          builder: (context, params) => AngDnTWidget(
            docDataDT: params.getParam(
              'docDataDT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Angiography'],
            ),
          ),
        ),
        FFRoute(
          name: AngOtherNotesWidget.routeName,
          path: AngOtherNotesWidget.routePath,
          builder: (context, params) => AngOtherNotesWidget(
            docDataON: params.getParam(
              'docDataON',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Angiography'],
            ),
          ),
        ),
        FFRoute(
          name: AngSoftwareWidget.routeName,
          path: AngSoftwareWidget.routePath,
          builder: (context, params) => AngSoftwareWidget(
            docRefSoft: params.getParam(
              'docRefSoft',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Angiography'],
            ),
          ),
        ),
        FFRoute(
          name: AngTubeWidget.routeName,
          path: AngTubeWidget.routePath,
          builder: (context, params) => AngTubeWidget(
            docRefSoft: params.getParam(
              'docRefSoft',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Angiography'],
            ),
          ),
        ),
        FFRoute(
          name: AngPatientTableWidget.routeName,
          path: AngPatientTableWidget.routePath,
          builder: (context, params) => AngPatientTableWidget(
            docDataPT: params.getParam(
              'docDataPT',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Angiography'],
            ),
          ),
        ),
        FFRoute(
          name: AngConsoleAndWorkstationWidget.routeName,
          path: AngConsoleAndWorkstationWidget.routePath,
          builder: (context, params) => AngConsoleAndWorkstationWidget(
            docDataCW: params.getParam(
              'docDataCW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Angiography'],
            ),
          ),
        ),
        FFRoute(
          name: AngDetectorWidget.routeName,
          path: AngDetectorWidget.routePath,
          builder: (context, params) => AngDetectorWidget(
            docDataAng: params.getParam(
              'docDataAng',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Angiography'],
            ),
          ),
        ),
        FFRoute(
            name: DocListAngiographyWidget.routeName,
            path: DocListAngiographyWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: DocListAngiographyWidget(),
                )),
        FFRoute(
          name: USSystemGeneralWidget.routeName,
          path: USSystemGeneralWidget.routePath,
          builder: (context, params) => USSystemGeneralWidget(
            docDataSysGen: params.getParam(
              'docDataSysGen',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Ultrasound'],
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/signIn';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/SPLASH.png',
                    fit: BoxFit.cover,
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
