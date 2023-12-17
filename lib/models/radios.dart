import 'package:skyradio_mobile/models/clients.dart';
import 'package:skyradio_mobile/models/sims.dart';

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
