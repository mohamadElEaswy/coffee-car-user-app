// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoffeeCar _$CoffeeCarFromJson(Map<String, dynamic> json) => CoffeeCar(
      carName: json['carName'] as String,
      coords: LatLng.fromJson(json['coords'] as Map<String, dynamic>),
      providerName: json['providerName'] as String,
      carId: json['carId'] as String,
      providerId: json['providerId'] as String,
      availability: json['availability'] as bool,
      address: json['address'] as String,
      products: json['products'] as bool,
      reviews: json['reviews'] as bool,
    );

Map<String, dynamic> _$CoffeeCarToJson(CoffeeCar instance) => <String, dynamic>{
      'carName': instance.carName,
      'providerName': instance.providerName,
      'address': instance.address,
      'carId': instance.carId,
      'providerId': instance.providerId,
      'availability': instance.availability,
      'coords': instance.coords,
      'products': instance.products,
      'reviews': instance.reviews,
    };
