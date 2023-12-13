class Radios {
  final String code;
  final String name;
  final String imei;

  Radios({
    required this.code,
    required this.name,
    required this.imei,
  });

  factory Radios.fromJson(Map<String, dynamic> json) {
    return Radios(
      code: json['code'],
      name: json['name'],
      imei: json['imei'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'imei': imei,
    };
  }
}
