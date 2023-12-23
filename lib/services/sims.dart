import 'package:skyradio_mobile/core/http.dart';

class SimsService {
  final SkHttp _http;

  SimsService({
    required SkHttp http,
  }) : _http = http;

  Future<ResponseData> getAll(RequestParams params) async {
    final response = await _http.get(
      '/sims',
      params: {
        'per_page': 15,
        ...params,
      },
    );

    return response.data;
  }

  Future<ResponseData> get(String code) async {
    final response = await _http.get(
      '/sims/$code',
    );

    return response.data;
  }

  Future<ResponseData> create(RequestParams params) async {
    final response = await _http.post(
      '/sims',
      params,
    );

    return response.data;
  }

  Future<ResponseData> update(String code, RequestParams params) async {
    final response = await _http.put(
      '/sims/$code',
      params,
    );

    return response.data;
  }

  Future<ResponseData> delete(String code) async {
    final response = await _http.delete(
      '/sims/$code',
    );

    return response.data;
  }
}
