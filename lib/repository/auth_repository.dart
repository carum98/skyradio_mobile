import 'package:skyradio_mobile/services/auth_service.dart';
import 'package:skyradio_mobile/services/auth_storage_service.dart';

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
}
