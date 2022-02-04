// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      description: json['description'] as String,
      availability: json['availability'] as bool,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'description': instance.description,
      'availability': instance.availability,
    };
