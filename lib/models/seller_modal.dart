class Seller {
  final String code;
  final String name;

  Seller({
    required this.code,
    required this.name,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}
