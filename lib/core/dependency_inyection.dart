import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/core/global_state.dart';
import 'package:skyradio_mobile/core/http.dart';
import 'package:skyradio_mobile/core/storage.dart';
import 'package:skyradio_mobile/services/auth_storage_service.dart';

class DI extends InheritedWidget {
  final GlobalState state = GlobalState();

  late final SkStorage storage;
  late final SkHttp http;

  late final AuthStorageService authStorageService;

  DI({
    super.key,
    required super.child,
  }) {
    storage = SkStorage();

    authStorageService = AuthStorageService(
      storage: storage,
    );

    http = SkHttp(
      authStorageService: authStorageService,
    );

    /// Verify if the user is authenticated
    authStorageService.isAuth.then(state.setAuth);
  }

  static DI of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DI>() as DI;
  }

  @override
  bool updateShouldNotify(DI oldWidget) => false;
}
