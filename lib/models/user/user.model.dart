class UserModel {
  UserModel({
    this.id,
    this.email,
    this.password,
    this.name,
    this.gender,
    this.isLoggedIn,
  });

  final String? id;
  final String? email;
  final String? password;
  final String? name;
  final String? gender;
  final bool? isLoggedIn;

  UserModel copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? gender,
    bool? isLoggedIn,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final raw = json['is_logged_in'];
    return UserModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      isLoggedIn: raw == true || raw == 1,
    );
  }
}