import 'package:skyradio_mobile/core/global_state.dart';
import 'package:skyradio_mobile/services/auth.dart';
import 'package:skyradio_mobile/services/auth_storage.dart';

class AuthRepository {
  final AuthStorageService _authStorageService;
  final AuthService _authService;
  final GlobalState _globalState;

  AuthRepository({
    required AuthStorageService authStorageService,
    required AuthService authService,
    required GlobalState globalState,
  })  : _authStorageService = authStorageService,
        _authService = authService,
        _globalState = globalState;

  Future<void> login(String email, String password) async {
    final response = await _authService.login(email, password);

    final auth = await _authStorageService.save(response);

    _globalState.setUser(auth.user);
  }

  Future<void> logout() async {
    await _authStorageService.delete();
  }
}
