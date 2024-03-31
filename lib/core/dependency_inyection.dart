import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/core/global_state.dart';
import 'package:skyradio_mobile/core/http.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/core/storage.dart';
import 'package:skyradio_mobile/repository/apps.dart';
import 'package:skyradio_mobile/repository/auth.dart';
import 'package:skyradio_mobile/repository/clients.dart';
import 'package:skyradio_mobile/repository/common.dart';
import 'package:skyradio_mobile/repository/consoles.dart';
import 'package:skyradio_mobile/repository/license.dart';
import 'package:skyradio_mobile/repository/radios.dart';
import 'package:skyradio_mobile/repository/sims.dart';
import 'package:skyradio_mobile/services/apps.dart';
import 'package:skyradio_mobile/services/auth.dart';
import 'package:skyradio_mobile/services/auth_storage.dart';
import 'package:skyradio_mobile/services/clients.dart';
import 'package:skyradio_mobile/services/common.dart';
import 'package:skyradio_mobile/services/consoles.dart';
import 'package:skyradio_mobile/services/license.dart';
import 'package:skyradio_mobile/services/radios.dart';
import 'package:skyradio_mobile/services/sims.dart';

class DI extends InheritedWidget {
  final GlobalState state = GlobalState();

  late final SkStorage storage;
  late final SkHttp http;

  late final AuthStorageService authStorageService;

  late final AuthService authService;
  late final ClientsService clientsService;
  late final RadiosService radiosService;
  late final SimsService simsService;
  late final CommonService commonService;
  late final AppsService appsService;
  late final LicenseService licenseService;
  late final ConsolesService consolesService;

  late final AuthRepository authRepository;
  late final ClientsRepository clientsRepository;
  late final RadiosRepository radiosRepository;
  late final SimsRepository simsRepository;
  late final CommonRepository commonRepository;
  late final AppsRepository appsRepository;
  late final LicenseRepository licenseRepository;
  late final ConsolesRepository consolesRepository;

  DI({
    super.key,
    required super.child,
  }) {
    // Core
    storage = SkStorage();

    authStorageService = AuthStorageService(
      storage: storage,
    );

    http = SkHttp(
      authStorageService: authStorageService,
    );

    // Services
    authService = AuthService(
      http: http.copyWith(useToken: false),
    );

    clientsService = ClientsService(
      http: http,
    );

    radiosService = RadiosService(
      http: http,
    );

    simsService = SimsService(
      http: http,
    );

    appsService = AppsService(
      http: http,
    );

    licenseService = LicenseService(
      http: http,
    );

    consolesService = ConsolesService(
      http: http,
    );

    commonService = CommonService(
      http: http,
    );

    // Repository
    authRepository = AuthRepository(
      authStorageService: authStorageService,
      authService: authService,
    );

    clientsRepository = ClientsRepository(
      clientsService: clientsService,
    );

    radiosRepository = RadiosRepository(
      radiosService: radiosService,
    );

    simsRepository = SimsRepository(
      simsService: simsService,
    );

    appsRepository = AppsRepository(
      appsService: appsService,
    );

    licenseRepository = LicenseRepository(
      licenseService: licenseService,
    );

    consolesRepository = ConsolesRepository(
      consolesService: consolesService,
    );

    commonRepository = CommonRepository(
      commonService: commonService,
    );

    /// Verify if the user is authenticated
    authStorageService.isAuth.then((value) {
      state.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        value ? HOME_VIEW : LOGIN_VIEW,
        (route) => false,
      );
    });

    /// Listen for api errors
    /// If the api returns a 401 status code, the user is redirected to the login view
    http.onError.listen((error) {
      if (error.runtimeType == UnauthorizedException) {
        state.navigatorKey.currentState!.pushNamedAndRemoveUntil(
          LOGIN_VIEW,
          (route) => false,
        );
      }
    });
  }

  static DI of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DI>() as DI;
  }

  @override
  bool updateShouldNotify(DI oldWidget) => false;
}
