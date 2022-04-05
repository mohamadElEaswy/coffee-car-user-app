import 'package:mk/src/core/model/product_model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  OrderModel({
    required this.confirmation,
    required this.userId,
    required this.userPhone,
    required this.providerId,
    required this.providerPhone,
    required this.time,
    required this.cart,
    required this.distance,
    required this.note,
    // required this.price,
  });

  final String userId;
  final String userPhone;
  final String providerId;
  final String providerPhone;
  final DateTime time;
  final List<Product> cart;
  final String note;
  final String distance;
  final bool confirmation;
  // final double price;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
