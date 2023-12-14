import 'package:skyradio_mobile/core/http.dart';

class SimsService {
  final SkHttp _http;

  SimsService({
    required SkHttp http,
  }) : _http = http;

  Future<ResponseData> getAll(RequestParams params) async {
    final response = await _http.get(
      '/sims',
      params: params,
    );

    return response.data;
  }
}
