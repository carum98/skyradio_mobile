import 'license.dart';

class Apps {
  final String code;
  final String name;
  final License? license;

  Apps({
    required this.code,
    required this.name,
    required this.license,
  });

  factory Apps.fromJson(Map<String, dynamic> json) {
    return Apps(
      code: json['code'],
      name: json['name'],
      license:
          json['license'] != null ? License.fromJson(json['license']) : null,
    );
  }
}
