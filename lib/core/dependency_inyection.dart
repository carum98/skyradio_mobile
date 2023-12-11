import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/core/global_state.dart';
import 'package:skyradio_mobile/core/http.dart';
import 'package:skyradio_mobile/core/router.dart';
import 'package:skyradio_mobile/core/storage.dart';
import 'package:skyradio_mobile/repository/auth_repository.dart';
import 'package:skyradio_mobile/services/auth_service.dart';
import 'package:skyradio_mobile/services/auth_storage_service.dart';

class DI extends InheritedWidget {
  final GlobalState state = GlobalState();

  late final SkStorage storage;
  late final SkHttp http;

  late final AuthStorageService authStorageService;
  late final AuthService authService;

  late final AuthRepository authRepository;

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

    // Repository
    authRepository = AuthRepository(
      authStorageService: authStorageService,
      authService: authService,
    );

    /// Verify if the user is authenticated
    authStorageService.isAuth.then((value) {
      state.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        value ? CLIENTS_VIEW : LOGIN_VIEW,
        (route) => false,
      );
    });
  }

  static DI of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DI>() as DI;
  }

  @override
  bool updateShouldNotify(DI oldWidget) => false;
}
