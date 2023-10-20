// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthTo {
  final String userEmail;
  final String password;

  AuthTo(this.userEmail, this.password);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userEmail': userEmail,
      'password': password,
    };
  }

  factory AuthTo.fromRequest(String body) {
    var map = jsonDecode(body);
    return AuthTo(map['user_email'], map['user_password']);
  }

  factory AuthTo.fromMap(Map<String, dynamic> map) {
    return AuthTo(
      map['user_email'] as String,
      map['user_password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthTo.fromJson(String source) => AuthTo.fromMap(json.decode(source) as Map<String, dynamic>);
}
