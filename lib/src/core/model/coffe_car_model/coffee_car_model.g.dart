// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoffeeCar _$CoffeeCarFromJson(Map<String, dynamic> json) => CoffeeCar(
      carName: json['carName'] as String,
      providerName: json['providerName'] as String,
      lat: json['lat'] as String,
      lang: json['lang'] as String,
      carId: json['carId'] as String,
      providerId: json['providerId'] as String,
      availability: json['availability'] as bool,
      address: json['address'] as String,
      products: (json['products'] as bool)
          // .map((e) => Product.fromJson(e as Map<String, dynamic>))
          // .toList()
      ,
      rate: (json['rate'] as bool)
          // .map((e) => Rate.fromJson(e as Map<String, dynamic>))
          // .toList()
      ,
    );

Map<String, dynamic> _$CoffeeCarToJson(CoffeeCar instance) => <String, dynamic>{
      'carName': instance.carName,
      'lang': instance.lang,
      'lat': instance.lat,
      'providerName': instance.providerName,
      'address': instance.address,
      'carId': instance.carId,
      'providerId': instance.providerId,
      'availability': instance.availability,
      'products': instance.products,
      'rate': instance.rate,
    };
