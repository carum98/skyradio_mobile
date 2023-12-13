import 'package:skyradio_mobile/core/http.dart';

class RadiosService {
  final SkHttp _http;

  RadiosService({
    required SkHttp http,
  }) : _http = http;

  Future<Map<String, dynamic>> getAll() async {
    final response = await _http.get('/radios');

    return response.data;
  }
}
