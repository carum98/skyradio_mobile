import 'package:skyradio_mobile/core/http.dart';

class ClientsService {
  final SkHttp _http;

  ClientsService({
    required SkHttp http,
  }) : _http = http;

  Future<Map<String, dynamic>> getAll() async {
    final response = await _http.get('/clients');

    return response.data;
  }
}
