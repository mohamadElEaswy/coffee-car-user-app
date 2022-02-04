// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoffeeCar _$CoffeeCarFromJson(Map<String, dynamic> json) => CoffeeCar(
      carName: json['carName'] as String,
      providerName: json['providerName'] as String,
      carId: json['carId'] as int,
      providerId: json['providerId'] as int,
      availability: json['availability'] as bool,
      address: json['address'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      rate: (json['rate'] as List<dynamic>)
          .map((e) => Rate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoffeeCarToJson(CoffeeCar instance) => <String, dynamic>{
      'carName': instance.carName,
      'providerName': instance.providerName,
      'address': instance.address,
      'carId': instance.carId,
      'providerId': instance.providerId,
      'availability': instance.availability,
      'products': instance.products,
      'rate': instance.rate,
    };
