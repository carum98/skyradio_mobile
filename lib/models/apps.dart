import 'clients.dart';
import 'license.dart';

class Apps {
  final String code;
  final String name;
  final License? license;
  final Clients client;

  Apps({
    required this.code,
    required this.name,
    required this.license,
    required this.client,
  });

  factory Apps.fromJson(Map<String, dynamic> json) {
    return Apps(
      code: json['code'],
      name: json['name'],
      license:
          json['license'] != null ? License.fromJson(json['license']) : null,
      client: Clients.fromJsonSim(json['client']),
    );
  }
}
