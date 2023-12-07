// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  int? orderId;
  int userId;
  int professionalId;
  DateTime orderDate;
  bool orderDone;
  String discription;

  OrderModel({
    this.orderId,
    required this.userId,
    required this.professionalId,
    required this.orderDate,
    this.orderDone = false,
    required this.discription,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': orderId,
      'order_date': orderDate,
      'order_done': orderDone,
      'user_id': userId,
      'professional_id': professionalId,
      'discription': discription,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['order_id'] != null ? map['order_id'] as int : null,
      orderDate: DateTime.parse(map['order_date'].toString()).toUtc(),
      orderDone: map['order_done']  == 1 ? true : false,
      userId: map['user_id'] as int,
      professionalId: map['professional_id'] as int,
      discription: map['discription'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
