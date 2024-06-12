import 'dart:convert';

class LoginParamsModel {
  final String email;
    final String password;

  LoginParamsModel({
    required this.email,
    required this.password,
  });

  LoginParamsModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginParamsModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LoginParamsModel.fromMap(Map<String, dynamic> map) {
    return LoginParamsModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginParamsModel.fromJson(String source) => LoginParamsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginParamsModel(email: $email, password: $password)';

  @override
  bool operator ==(covariant LoginParamsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
