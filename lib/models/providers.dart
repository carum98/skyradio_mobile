import 'dart:ui';

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
      color: Color(int.parse(json['color'].replaceAll('#', '0xFF'))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'color': color.toString(),
    };
  }
}
