import 'package:skyradio_mobile/core/http.dart';

class ConsolesService {
  final SkHttp _http;

  ConsolesService({
    required SkHttp http,
  }) : _http = http;

  Future<ResponseData> getAll(RequestParams params) async {
    final response = await _http.get(
      '/consoles',
      params: {
        'per_page': 15,
        ...params,
      },
    );

    return response.data;
  }

  Future<ResponseData> getConsole(String code) async {
    final response = await _http.get(
      '/consoles/$code',
    );

    return response.data;
  }

  Future<ResponseData> create(String code, RequestParams params) async {
    final response = await _http.post(
      '/clients/$code/console',
      params,
    );

    return response.data;
  }

  Future<void> update(String code, RequestParams params) async {
    await _http.put(
      '/consoles/$code',
      params,
    );
  }

  Future<void> delete(String code) async {
    await _http.delete(
      '/consoles/$code',
    );
  }
}
