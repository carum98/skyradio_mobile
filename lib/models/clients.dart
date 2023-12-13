import 'package:skyradio_mobile/models/modality.dart';
import 'package:skyradio_mobile/models/seller.dart';

class Clients {
  final String code;
  final String name;
  final String color;
  final Modality modality;
  final Seller seller;
  final int radiosCount;

  Clients({
    required this.code,
    required this.name,
    required this.color,
    required this.modality,
    required this.seller,
    required this.radiosCount,
  });

  factory Clients.fromJson(Map<String, dynamic> json) {
    return Clients(
      code: json['code'],
      name: json['name'],
      color: json['color'],
      modality: Modality.fromJson(json['modality']),
      seller: Seller.fromJson(json['seller']),
      radiosCount: json['radios_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'color': color,
      'radios_count': radiosCount,
    };
  }
}
