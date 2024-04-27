import 'package:skyradio_mobile/models/user.dart';

class Auth {
  final String token;
  final String refreshToken;
  final int expiresIn;
  final User user;

  const Auth({
    required this.token,
    required this.refreshToken,
    required this.expiresIn,
    required this.user,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      token: json['token'],
      refreshToken: json['refreshToken'],
      expiresIn: json['expiredAt'],
      user: User.fromJson(json['user']),
    );
  }

  bool get isExpired =>
      DateTime.now().millisecondsSinceEpoch > (expiresIn - 60 * 60 * 1000);

  toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'expiredAt': expiresIn,
      'user': user.toJson(),
    };
  }
}
