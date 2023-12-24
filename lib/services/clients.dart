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

  Future<ResponseData> create(RequestParams params) async {
    final response = await _http.post(
      '/clients',
      params,
    );

    return response.data;
  }

  Future<void> update(String code, RequestParams params) async {
    await _http.put(
      '/clients/$code',
      params,
    );
  }

  Future<void> delete(String code) async {
    await _http.delete(
      '/clients/$code',
    );
  }

  Future<ResponseData> addRadios(String code, RequestParams params) async {
    final response = await _http.post(
      '/clients/$code/radios',
      params,
    );

    return response.data;
  }
}
