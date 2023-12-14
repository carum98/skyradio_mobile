import 'providers.dart';

class Sims {
  final String code;
  final String number;
  final Providers provider;

  Sims({
    required this.code,
    required this.number,
    required this.provider,
  });

  factory Sims.fromJson(Map<String, dynamic> json) {
    return Sims(
      code: json['code'],
      number: json['number'],
      provider: Providers.fromJson(json['provider']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'number': number,
      'provider': provider.toJson(),
    };
  }
}
