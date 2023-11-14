// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CultureModel {
  String? cultureId;
  String landId;
  String cultureName;
  String cultureDiscription;
  DateTime cultureStart;
  DateTime estimatedTime;
  
  CultureModel({
    this.cultureId,
    required this.landId,
    required this.cultureName,
    required this.cultureDiscription,
    required this.cultureStart,
    required this.estimatedTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'culture_id': cultureId,
      'lands_id': landId,
      'culture_name': cultureName,
      'culture_discription': cultureDiscription,
      'culture_start': cultureStart.millisecondsSinceEpoch,
      'estimated_time': estimatedTime.millisecondsSinceEpoch,
    };
  }

  factory CultureModel.fromMap(Map<String, dynamic> map) {
    return CultureModel(
      cultureId: map['culture_id'] as String,
      landId: map['lands_id'] as String,
      cultureName: map['culture_name'] as String,
      cultureStart: DateTime.fromMillisecondsSinceEpoch(map['culture_start'] as int),
      estimatedTime: DateTime.fromMillisecondsSinceEpoch(map['estimated_time'] as int),
      cultureDiscription: map['culture_discription'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CultureModel.fromJson(String source) => CultureModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
