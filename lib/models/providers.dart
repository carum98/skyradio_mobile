import 'dart:ui';

import 'package:skyradio_mobile/utils/color.dart';

class Providers {
  final String code;
  final String name;
  final Color color;

  Providers({
    required this.code,
    required this.name,
    required this.color,
  });

  factory Providers.fromJson(Map<String, dynamic> json) {
    return Providers(
      code: json['code'],
      name: json['name'],
      color: (json['color'] as String).toColor(),
    );
  }
}
