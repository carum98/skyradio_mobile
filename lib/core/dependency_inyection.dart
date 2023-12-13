import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/core/global_state.dart';
import 'package:skyradio_mobile/core/http.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/core/storage.dart';
import 'package:skyradio_mobile/repository/auth_repository.dart';
import 'package:skyradio_mobile/repository/clients_repository.dart';
import 'package:skyradio_mobile/repository/radios_repository.dart';
import 'package:skyradio_mobile/services/auth_service.dart';
import 'package:skyradio_mobile/services/auth_storage_service.dart';
import 'package:skyradio_mobile/services/clients_service.dart';
import 'package:skyradio_mobile/services/radios_service.dart';

class DI extends InheritedWidget {
  final GlobalState state = GlobalState();

  late final SkStorage storage;
  late final SkHttp http;

  late final AuthStorageService authStorageService;
  late final AuthService authService;
  late final ClientsService clientsService;
  late final RadiosService radiosService;

  late final AuthRepository authRepository;
  late final ClientsRepository clientsRepository;
  late final RadiosRepository radiosRepository;

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
