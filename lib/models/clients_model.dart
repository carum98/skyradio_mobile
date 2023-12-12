class Clients {
  final String code;
  final String name;
  final String color;

  Clients({
    required this.code,
    required this.name,
    required this.color,
  });

  factory Clients.fromJson(Map<String, dynamic> json) {
    return Clients(
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
