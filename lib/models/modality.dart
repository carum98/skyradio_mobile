import 'package:flutter/widgets.dart';
import 'package:skyradio_mobile/utils/color.dart';

class Modality {
  final String code;
  final String name;
  final Color color;

  Modality({
    required this.code,
    required this.name,
    required this.color,
  });

  factory Modality.fromJson(Map<String, dynamic> json) {
    return Modality(
      code: json['code'],
      name: json['name'],
      color: (json['color'] as String).toColor(),
    );
  }

  factory Modality.placeholder() {
    return Modality(
      code: '',
      name: '',
      color: const Color(0xFF000000),
    );
  }
}
