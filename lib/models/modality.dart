import 'package:flutter/widgets.dart';

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
      color: Color(int.parse(json['color'].replaceAll('#', '0xFF'))),
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
