import 'package:skyradio_mobile/core/http.dart';

class RadiosService {
  final SkHttp _http;

  RadiosService({
    required SkHttp http,
  }) : _http = http;

  Future<ResponseData> getAll(RequestParams params) async {
    final response = await _http.get(
      '/radios',
      params: {
        'per_page': 15,
        ...params,
      },
    );

    return response.data;
  }

  Future<ResponseData> get(String code) async {
    final response = await _http.get(
      '/radios/$code',
    );

    return response.data;
  }

  Future<ResponseData> create(RequestParams params) async {
    final response = await _http.post(
      '/radios',
      params,
    );

    return response.data;
  }

  Future<ResponseData> update(String code, RequestParams params) async {
    final response = await _http.put(
      '/radios/$code',
      params,
    );

    return response.data;
  }

  Future<ResponseData> delete(String code) async {
    final response = await _http.delete(
      '/radios/$code',
    );

    return response.data;
  }

  Future<ResponseData> addSim(String code, RequestParams params) async {
    final response = await _http.post(
      '/radios/$code/sims',
      params,
    );

    return response.data;
  }

  Future<ResponseData> swapSim(String code, RequestParams params) async {
    final response = await _http.post(
      '/radios/$code/sims',
      params,
    );

    return response.data;
  }

  Future<ResponseData> removeSim(String code) async {
    final response = await _http.delete(
      '/radios/$code/sims',
    );

    return response.data;
  }
}
