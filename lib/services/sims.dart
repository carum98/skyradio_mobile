import 'package:skyradio_mobile/core/http.dart';

class SimsService {
  final SkHttp _http;

  SimsService({
    required SkHttp http,
  }) : _http = http;

  Future<Map<String, dynamic>> getAll() async {
    final response = await _http.get('/sims');

    return response.data;
  }
}
