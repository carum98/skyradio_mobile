class Modality {
  final String code;
  final String name;
  final String color;

  Modality({
    required this.code,
    required this.name,
    required this.color,
  });

  factory Modality.fromJson(Map<String, dynamic> json) {
    return Modality(
      code: json['code'],
      name: json['name'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'color': color,
    };
  }
}
