import 'dart:convert';

import 'package:skyradio_mobile/core/storage.dart';
import 'package:skyradio_mobile/models/auth_model.dart';

class AuthStorageService {
  final Storage _storage;
  final storageName = 'auth';

  AuthStorageService({required Storage storage}) : _storage = storage;

  Future<Auth?> get() async {
    final map = await _storage.read(storageName);

    if (map == null) {
      return null;
    }

    return Auth.fromJson(jsonDecode(map));
  }

  Future<void> save(Map<String, dynamic> map) {
    return _storage.write(storageName, jsonEncode(Auth.fromJson(map).toJson()));
  }

  Future<void> delete() {
    return _storage.delete(storageName);
  }
}
