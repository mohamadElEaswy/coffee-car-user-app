// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      confirmation: json['confirmation'] as bool,
      userId: json['userId'] as String,
      userPhone: json['userPhone'] as String,
      providerId: json['providerId'] as String,
      providerPhone: json['providerPhone'] as String,
      time: DateTime.parse(json['time'] as String),
      cart: (json['cart'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      distance: json['distance'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userPhone': instance.userPhone,
      'providerId': instance.providerId,
      'providerPhone': instance.providerPhone,
      'time': instance.time.toIso8601String(),
      'cart': instance.cart,
      'note': instance.note,
      'distance': instance.distance,
      'confirmation': instance.confirmation,
    };
