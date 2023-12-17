import 'package:skyradio_mobile/models/radios.dart';

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
