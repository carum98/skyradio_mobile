import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';

import 'clients.dart';
import 'license.dart';

class Apps {
  final String code;
  final String name;
  final License? license;
  final Clients client;

  Apps({
    required this.code,
    required this.name,
    required this.license,
    required this.client,
  });

  factory Apps.fromJson(Map<String, dynamic> json) {
    return Apps(
      code: json['code'],
      name: json['name'],
      license:
          json['license'] != null ? License.fromJson(json['license']) : null,
      client: Clients.fromJsonSim(json['client']),
    );
  }
}

class AppsForm extends SkFormModel {
  String? _name;
  License? _license;
  Clients? _client;

  AppsForm({
    String? name,
    License? license,
    Clients? client,
    super.code,
  })  : _name = name,
        _license = license,
        _client = client;

  String? get name => _name;
  License? get license => _license;
  Clients? get client => _client;

  set name(String? value) {
    _name = value;
    notifyListeners();
  }

  set license(License? value) {
    _license = value;
    notifyListeners();
  }

  set client(Clients? value) {
    _client = value;
    notifyListeners();
  }

  factory AppsForm.create() {
    return AppsForm();
  }

  factory AppsForm.update(Apps app) {
    return AppsForm(
      name: app.name,
      license: app.license,
      client: app.client,
      code: app.code,
    );
  }

  @override
  RequestData getParams() {
    return {
      'name': name,
      'license': license?.code,
      'client': client?.code,
    };
  }

  @override
  bool get isValid => name != null && client != null;
}

class AppsItemForm {
  String? name;
  License? license;

  ResponseData getParams() {
    return {
      'name': name,
      'license_code': license?.code,
    };
  }
}
