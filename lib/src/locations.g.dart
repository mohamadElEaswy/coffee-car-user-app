// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLngData _$LatLngDataFromJson(Map<String, dynamic> json) => LatLngData(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngDataToJson(LatLngData instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Cars _$CarsFromJson(Map<String, dynamic> json) => Cars(
      address: json['address'] as String,
      id: json['id'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$CarsToJson(Cars instance) => <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      cars: (json['cars'] as List<dynamic>)
          .map((e) => Cars.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'cars': instance.cars,
    };
