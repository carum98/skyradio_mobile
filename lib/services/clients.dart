import 'package:skyradio_mobile/core/http.dart';

class ClientsService {
  final SkHttp _http;

  ClientsService({
    required SkHttp http,
  }) : _http = http;

  Future<ResponseData> getAll(RequestParams params) async {
    final response = await _http.get(
      '/clients',
      params: {
        'per_page': 15,
        ...params,
      },
    );

    return response.data;
  }

  Future<ResponseData> getRadios(String code, RequestParams params) async {
    final response = await _http.get(
      '/clients/$code/radios',
      params: {
        'per_page': 15,
        ...params,
      },
    );

    return response.data;
  }

  Future<ResponseData> getStats(String code) async {
    final response = await _http.get(
      '/clients/$code/stats',
    );

    return response.data;
  }
}
