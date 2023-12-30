import 'package:skyradio_mobile/services/auth.dart';
import 'package:skyradio_mobile/services/auth_storage.dart';

class AuthRepository {
  final AuthStorageService _authStorageService;
  final AuthService _authService;

  AuthRepository({
    required AuthStorageService authStorageService,
    required AuthService authService,
  })  : _authStorageService = authStorageService,
        _authService = authService;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _authService.login(email, password);

    await _authStorageService.save(response);

    return response;
  }

  Future<void> logout() async {
    await _authStorageService.delete();
  }
}
