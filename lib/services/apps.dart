import 'package:skyradio_mobile/core/http.dart';

class AppsService {
  final SkHttp _http;

  AppsService({
    required SkHttp http,
  }) : _http = http;

  Future<ResponseData> getAll(RequestParams params) async {
    final response = await _http.get(
      '/apps',
      params: {
        'per_page': 15,
        ...params,
      },
    );

    return response.data;
  }

  Future<ResponseData> getApp(String code) async {
    final response = await _http.get(
      '/apps/$code',
    );

    return response.data;
  }

  Future<ResponseData> delete(String code) async {
    final response = await _http.delete(
      '/apps/$code',
    );

    return response.data;
  }
}
