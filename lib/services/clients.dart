import 'package:skyradio_mobile/core/http.dart';

class ClientsService {
  final SkHttp _http;

  ClientsService({
    required SkHttp http,
  }) : _http = http;

  Future<ResponseData> getAll(RequestParams params) async {
    final response = await _http.get(
      '/clients',
      params: params,
    );

    return response.data;
  }
}
