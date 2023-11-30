import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LandsModel {
  int? landsId;
  double landSize;
  String location;
  int userId;

  LandsModel({
    this.landsId,
    required this.landSize,
    required this.location,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lands_id': landsId,
      'lands_size': landSize,
      'location': location,
      'user_id': userId,
    };
  }

  factory LandsModel.fromMap(Map<String, dynamic> map) {
    return LandsModel(
      landsId: map['lands_id'] != null ? map['lands_id'] as int : null,
      landSize: map['lands_size'] as double,
      location: map['location'] as String,
      userId: map['user_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LandsModel.fromJson(String source) =>
      LandsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
