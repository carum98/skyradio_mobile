class Sims {
  final String code;
  final String number;

  Sims({
    required this.code,
    required this.number,
  });

  factory Sims.fromJson(Map<String, dynamic> json) {
    return Sims(
      code: json['code'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'number': number,
    };
  }
}
