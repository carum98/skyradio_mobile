import 'package:skyradio_mobile/core/http.dart';

class AuthService {
  final SkHttp _http;

  AuthService({
    required SkHttp http,
  }) : _http = http;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _http.post('/login', {
      'email': email,
      'password': password,
    });

    return response.data;
  }
}
