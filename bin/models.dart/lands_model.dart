import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LandsModel {
  int? landsId;
  double landSize;
  String location;

  LandsModel({
    this.landsId,
    required this.landSize,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lands_id': landsId,
      'lands_size': landSize,
      'location': location,
    };
  }

  factory LandsModel.fromMap(Map<String, dynamic> map) {
    return LandsModel(
      landsId: map['lands_id'] != null ? map['lands_id'] as int : null,
      landSize: map['lands_size'] as double,
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LandsModel.fromJson(String source) => LandsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
