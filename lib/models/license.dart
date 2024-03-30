class License {
  final String code;
  final String key;

  License({
    required this.code,
    required this.key,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      code: json['code'],
      key: json['key'],
    );
  }
}
