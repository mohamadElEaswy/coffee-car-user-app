// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoffeeCar _$CoffeeCarFromJson(Map<String, dynamic> json) => CoffeeCar(
      carName: json['carName'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
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
      'lat': instance.lat,
      'lng': instance.lng,
      'providerName': instance.providerName,
      'address': instance.address,
      'carId': instance.carId,
      'providerId': instance.providerId,
      'availability': instance.availability,
      'products': instance.products,
      'reviews': instance.reviews,
    };

CarsList _$CarsListFromJson(Map<String, dynamic> json) => CarsList(
      cars: (json['cars'] as List<dynamic>)
          .map((e) => CoffeeCar.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarsListToJson(CarsList instance) => <String, dynamic>{
      'cars': instance.cars,
    };
