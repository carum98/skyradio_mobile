enum Role {
  admin,
  user,
  guest,
  seller;
}

class User {
  final String code;
  final String name;
  final String email;
  final Role role;

  const User({
    required this.code,
    required this.name,
    required this.email,
    required this.role,
  });

  bool get isAdmin => role == Role.admin;
  bool get isUser => role == Role.user;
  bool get isGuest => role == Role.guest;
  bool get isSeller => role == Role.seller;

  bool get canModify => isAdmin || isUser;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      code: json['code'],
      name: json['name'],
      email: json['email'],
      role: Role.values.firstWhere((e) => e.name == json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'email': email,
      'role': role.name,
    };
  }

  factory User.fake() {
    return const User(
      code: '',
      name: '',
      email: '',
      role: Role.user,
    );
  }
}
