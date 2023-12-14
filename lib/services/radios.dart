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
}
