import 'dart:ui';

import 'package:skyradio_mobile/utils/color.dart';

class Models {
  final String code;
  final String name;
  final Color color;

  Models({
    required this.code,
    required this.name,
    required this.color,
  });

  factory Models.fromJson(Map<String, dynamic> json) {
    return Models(
      code: json['code'],
      name: json['name'],
      color: (json['color'] as String).toColor(),
    );
  }

  factory Models.placeholder() {
    return Models(
      code: '',
      name: '',
      color: const Color(0xFF000000),
    );
  }
}
