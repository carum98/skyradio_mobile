import 'package:skyradio_mobile/core/http.dart';

class LicenseService {
  final SkHttp _http;

  LicenseService({
    required SkHttp http,
  }) : _http = http;

  Future<ResponseData> getAll(RequestParams params) async {
    final response = await _http.get(
      '/licenses',
      params: {
        'per_page': 15,
        ...params,
      },
    );

    return response.data;
  }

  Future<ResponseData> getLicense(String code) async {
    final response = await _http.get(
      '/licenses/$code',
    );

    return response.data;
  }

  Future<ResponseData> create(RequestParams params) async {
    final response = await _http.post('/licenses', params);

    return response.data;
  }

  Future<void> update(String code, RequestParams params) async {
    await _http.put(
      '/licenses/$code',
      params,
    );
  }
}
