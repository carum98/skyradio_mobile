import 'dart:async';
import 'dart:convert';

import 'package:skyradio_mobile/services/auth_storage.dart';
import 'package:http/http.dart' as http;

import 'types.dart';
export 'types.dart';

enum Method {
  get,
  post,
  put,
  delete,
}

class SkHttp {
  final AuthStorageService _authStorageService;
  final bool _useToken;

  SkHttp({
    required AuthStorageService authStorageService,
    bool? useToken,
  })  : _authStorageService = authStorageService,
        _useToken = useToken ?? true;

  final StreamController<SkHttpException> _onError =
      StreamController<SkHttpException>();
  Stream<SkHttpException> get onError => _onError.stream;

  Future<Response> get(String path, {RequestParams? params}) async {
    return await _request(
      path: path,
      method: Method.get,
      params: params,
    );
  }

  Future<Response> post(String path, RequestData data) async {
    return await _request(
      path: path,
      method: Method.post,
      data: data,
    );
  }

  Future<Response> put(String path, RequestData data) async {
    return await _request(
      path: path,
      method: Method.put,
      data: data,
    );
  }

  Future<Response> delete(String path) async {
    return await _request(
      path: path,
      method: Method.delete,
    );
  }

  Uri _uri(
    String path, {
    RequestParams? params,
  }) {
    final Map<String, String>? queryParameters = params?.map(
      (key, value) => MapEntry(key, value.toString()),
    );

    return Uri(
      scheme: 'http',
      host: '192.168.10.158',
      port: 8080,
      path: path,
      queryParameters: queryParameters,
    );
  }

  Future<Map<String, String>?> _headers() async {
    if (!_useToken) return null;

    final authInfo = await _authStorageService.get();

    return {
      'Authorization': 'Bearer ${authInfo?.token}',
      // 'Content-Type': 'application/json',
    };
  }

  Future<Response> _request({
    required String path,
    required Method method,
    RequestData? data,
    RequestParams? params,
  }) async {
    try {
      final headers = await _headers();
      late final http.Response response;

      switch (method) {
        case Method.get:
          response = await http.get(
            _uri(path, params: params),
            headers: headers,
          );
        case Method.post:
          response = await http.post(
            _uri(path),
            headers: headers,
            body: data,
          );
        case Method.put:
          response = await http.put(
            _uri(path),
            headers: headers,
            body: data,
          );
        case Method.delete:
          response = await http.delete(
            _uri(path),
            headers: headers,
          );
      }

      if (response.statusCode == 401) {
        _authStorageService.delete();

        throw UnauthorizedException(
          message: jsonDecode(response.body)['message'],
        );
      }

      if (response.statusCode == 204) {
        return Response(http.Response('{}', 204));
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw SkHttpException(
          message: jsonDecode(response.body)['message'],
        );
      }

      return Response(response);
    } on SkHttpException catch (e) {
      _onError.add(e);

      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  SkHttp copyWith({bool? useToken}) {
    return SkHttp(
      authStorageService: _authStorageService,
      useToken: useToken ?? _useToken,
    );
  }
}

class Response {
  final http.Response _response;

  Response(this._response);

  int get statusCode => _response.statusCode;
  ResponseData get data => _decodeBody();

  ResponseData _decodeBody() {
    try {
      return jsonDecode(_response.body);
    } catch (e) {
      throw SkHttpException(message: 'Invalid response body');
    }
  }
}

class SkHttpException implements Exception {
  final String message;

  SkHttpException({required this.message});
}

class UnauthorizedException implements SkHttpException {
  @override
  final String message;

  UnauthorizedException({required this.message});
}
