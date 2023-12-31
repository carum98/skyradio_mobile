import 'package:skyradio_mobile/core/types.dart';
import 'package:skyradio_mobile/models/radios.dart';
import 'package:skyradio_mobile/utils/api_params.dart';
import 'package:skyradio_mobile/utils/string_validator.dart';
import 'package:skyradio_mobile/widgets/scaffold/sk_scaffold_form.dart';

import 'providers.dart';

class Sims {
  final String code;
  final String number;
  final String? serial;
  final Providers provider;
  final Radios? radio;

  Sims({
    required this.code,
    required this.number,
    required this.serial,
    required this.provider,
    required this.radio,
  });

  factory Sims.fromJson(Map<String, dynamic> json) {
    return Sims(
      code: json['code'],
      number: json['number'],
      serial: json['serial'],
      provider: Providers.fromJson(json['provider']),
      radio: json['radio'] != null ? Radios.fromJsonSim(json['radio']) : null,
    );
  }
}

class SimsForm extends SkFormModel {
  String? _number;
  String? _serial;
  Providers? _provider;

  SimsForm({
    String? number,
    String? serial,
    Providers? provider,
    super.code,
  })  : _number = number,
        _serial = serial,
        _provider = provider;

  String? get number => _number;
  String? get serial => _serial;
  Providers? get provider => _provider;

  set number(String? value) {
    _number = value;
    notifyListeners();
  }

  set serial(String? value) {
    _serial = value;
    notifyListeners();
  }

  set provider(Providers? value) {
    _provider = value;
    notifyListeners();
  }

  factory SimsForm.create() {
    return SimsForm();
  }

  factory SimsForm.update(Sims sim) {
    return SimsForm(
      number: sim.number,
      serial: sim.serial,
      provider: sim.provider,
      code: sim.code,
    );
  }

  @override
  RequestData getParams() {
    return {
      'number': number,
      'serial': serial,
      'provider_code': provider?.code,
    };
  }

  @override
  bool get isValid =>
      _number.validate(isRequired: true, min: 3, max: 12) &&
      _serial.validate(min: 3, max: 15) &&
      _provider != null;
}

class SimsFilter extends ApiFilterModel {
  Providers? simProvider;

  SimsFilter({
    this.simProvider,
  });

  @override
  RequestParams toRequestParams() {
    final params = {
      'sims_provider[code][equal]': simProvider?.code,
    };

    params.removeWhere((key, value) => value == null);

    return params;
  }
}
