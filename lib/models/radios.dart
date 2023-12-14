import 'package:skyradio_mobile/models/models.dart';

class Radios {
  final String code;
  final String name;
  final String imei;
  final Models model;

  Radios({
    required this.code,
    required this.name,
    required this.imei,
    required this.model,
  });

  factory Radios.fromJson(Map<String, dynamic> json) {
    return Radios(
      code: json['code'],
      name: json['name'],
      imei: json['imei'],
      model: Models.fromJson(json['model']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'imei': imei,
      'model': model.toJson(),
    };
  }
}
