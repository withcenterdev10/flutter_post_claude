class UserModel {
  UserModel({this.email, this.password, this.name, this.nickname});

  final String? email;
  final String? password;
  final String? name;
  final String? nickname;

  UserModel copyWith({
    String? email,
    String? password,
    String? name,
    String? nickname,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
    );
  }
}
