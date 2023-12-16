import 'package:skyradio_mobile/models/sims.dart';

import 'models.dart';

class Radios {
  final String code;
  final String name;
  final String imei;
  final String? serial;
  final Models model;
  final Sims? sim;

  Radios({
    required this.code,
    required this.name,
    required this.imei,
    required this.serial,
    required this.model,
    required this.sim,
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
}
