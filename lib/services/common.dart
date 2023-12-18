import 'package:skyradio_mobile/core/http.dart';

class CommonService {
  final SkHttp _http;

  CommonService({
    required SkHttp http,
  }) : _http = http;

  Future<ResponseData> getModalities(RequestParams params) async {
    final response = await _http.get(
      '/clients-modality',
      params: params,
    );

    return response.data;
  }

  Future<ResponseData> getModels(RequestParams params) async {
    final response = await _http.get(
      '/radios-model',
      params: params,
    );

    return response.data;
  }

  Future<ResponseData> getStatus(RequestParams params) async {
    final response = await _http.get(
      '/radios-status',
      params: params,
    );

    return response.data;
  }

  Future<ResponseData> getSellers(RequestParams params) async {
    final response = await _http.get(
      '/sellers',
      params: params,
    );

    return response.data;
  }

  Future<ResponseData> getProviders(RequestParams params) async {
    final response = await _http.get(
      '/sims-provider',
      params: params,
    );

    return response.data;
  }
}
