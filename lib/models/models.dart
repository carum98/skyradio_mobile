import 'dart:ui';

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
