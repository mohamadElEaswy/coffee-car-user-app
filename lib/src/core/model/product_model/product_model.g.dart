// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'],
      description: json['description'] as String,
      availability: json['availability'] as bool,
      category: json['category'] as String,
      time: DateTime.parse(json['time'] as String),
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'category': instance.category,
      'description': instance.description,
      'availability': instance.availability,
      'time': instance.time.toIso8601String(),
    };
