import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? userId;
  String? userName;
  String? userPassword;
  String? userType;
  String? userEmail;
  String? userCel;
  String? userCrea;

  UserModel();

  UserModel.create(this.userId, this.userName, this.userEmail, this.userType,
      this.userCel, this.userCrea);

  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, userType: $userType, userCel: $userCel, userCrea: $userCrea)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userType': userType,
      'userCel': userCel,
      'userCrea': userCrea,
    };
  }

  factory UserModel.fromEmail(Map map) {
    return UserModel()..userId = map['user_id']?.toInt()
      ..userPassword = map['user_password'];
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..userName = map['user_name']
      ..userEmail = map['user_email']
      ..userPassword = map['user_password']
      ..userType = map['user_type']
      ..userCel = map['user_cel']
      ..userCrea = map['user_crea'];
      
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
        map['user_id'] != null ? map['user_id'] as int : null,
        map['user_name'] as String,
        map['user_email'] as String,
        map['user_type'] as String,
        map['user_cel'] as String,
        map['user_crea'] != null ? map['user_crea'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
