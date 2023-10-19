import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LandsModel {
  int? id;
  double landSize;
  String localization;

  LandsModel({
    this.id,
    required this.landSize,
    required this.localization,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'landSize': landSize,
      'localization': localization,
    };
  }

  factory LandsModel.fromMap(Map<String, dynamic> map) {
    return LandsModel(
      id: map['id'] != null ? map['id'] as int : null,
      landSize: map['landSize'] as double,
      localization: map['localization'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LandsModel.fromJson(String source) => LandsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
