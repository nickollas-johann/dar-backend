// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CultureModel {
  int? cultureId;
  int landId;
  String cultureName;
  String? cultureDiscription;
  DateTime cultureStart;
  DateTime estimatedTime;

  CultureModel({
    this.cultureId,
    required this.landId,
    required this.cultureName,
    this.cultureDiscription,
    required this.cultureStart,
    required this.estimatedTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'culture_id': cultureId,
      'culture_name': cultureName,
      'culture_start': cultureStart.millisecondsSinceEpoch,
      'estimated_time': estimatedTime.millisecondsSinceEpoch,
      'lands_id': landId,
      'culture_discription': cultureDiscription,
    };
  }

  factory CultureModel.fromMap(Map<String, dynamic> map) {
    return CultureModel(
      cultureId: map['culture_id'] != null ? map['culture_id'] as int : null,
      cultureName: map['culture_name'] as String,
      cultureStart: DateTime.parse(map['culture_start'].toString()).toUtc(),
      estimatedTime: DateTime.parse(map['estimated_time'].toString()).toUtc(),
      landId: map['lands_id'] as int,
      cultureDiscription: map['culture_discription'] != null
          ? map['culture_discription'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CultureModel.fromJson(String source) =>
      CultureModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
