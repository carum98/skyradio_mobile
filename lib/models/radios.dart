import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/providers.dart';
import 'package:skyradio_mobile/models/sims.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';

import 'models.dart';

class Radios {
  final String code;
  final String name;
  final String imei;
  final String? serial;
  final Models model;
  final Sims? sim;
  final Clients? client;

  Radios({
    required this.code,
    required this.name,
    required this.imei,
    required this.serial,
    required this.model,
    required this.sim,
    this.client,
  });

  factory Radios.fromJson(Map<String, dynamic> json) {
    return Radios(
      code: json['code'],
      name: json['name'],
      imei: json['imei'],
      serial: json['serial'],
      model: Models.fromJson(json['model']),
      sim: json['sim'] != null ? Sims.fromJson(json['sim']) : null,
    );
  }

  factory Radios.fromJsonSim(Map<String, dynamic> json) {
    return Radios(
      code: json['code'],
      name: json['name'],
      imei: json['imei'],
      serial: null,
      model: Models.placeholder(),
      sim: null,
      client:
          json['client'] != null ? Clients.fromJsonSim(json['client']) : null,
    );
  }
}

class RadiosForm extends SkFormModel {
  String? _name;
  String? _imei;
  String? _serial;
  Models? _model;

  RadiosForm({
    String? name,
    String? imei,
    String? serial,
    Models? model,
    super.code,
  })  : _name = name,
        _imei = imei,
        _serial = serial,
        _model = model;

  String? get name => _name;
  String? get imei => _imei;
  String? get serial => _serial;
  Models? get model => _model;

  set name(String? value) {
    _name = value;
    notifyListeners();
  }

  set imei(String? value) {
    _imei = value;
    notifyListeners();
  }

  set serial(String? value) {
    _serial = value;
    notifyListeners();
  }

  set model(Models? value) {
    _model = value;
    notifyListeners();
  }

  factory RadiosForm.create() {
    return RadiosForm();
  }

  factory RadiosForm.update(Radios radio) {
    return RadiosForm(
      code: radio.code,
      name: radio.name,
      imei: radio.imei,
      serial: radio.serial,
      model: radio.model,
    );
  }

  @override
  RequestData getParams() {
    return {
      'name': name,
      'imei': imei,
      'serial': serial,
      'model_code': model?.code,
    };
  }

  @override
  bool get isValid =>
      (_name != null && _name!.isNotEmpty) && imei != null && model != null;
}

class RadiosItemForm {
  final Radios radio;
  String? name;
  Sims? sim;

  RadiosItemForm({
    required this.radio,
  })  : name = radio.name,
        sim = radio.sim;

  String get code => radio.code;

  ResponseData getParams() {
    final params = {
      'name': name,
      'sim_code': sim?.code,
    };

    params.removeWhere((key, value) => value == null);

    return params;
  }
}

class RadiosFilter extends ApiFilterModel {
  Models? model;
  Providers? simProvider;
  Clients? client;

  RadiosFilter({
    this.model,
    this.simProvider,
    this.client,
  });

  @override
  RequestParams toRequestParams() {
    final params = {
      'radios_model[code][equal]': model?.code,
      'sims_provider[code][equal]': simProvider?.code,
      'clients[code][equal]': client?.code,
    };

    params.removeWhere((key, value) => value == null);

    return params;
  }
}
