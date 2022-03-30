// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
// import 'package:flutter/services.dart' show rootBundle;

part 'locations.g.dart';

@JsonSerializable()
class LatLngData {
  LatLngData({
    required this.lat,
    required this.lng,
  });

  factory LatLngData.fromJson(Map<String, dynamic> json) => _$LatLngDataFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngDataToJson(this);

  final double lat;
  final double lng;
}

// @JsonSerializable()
// class Region {
//   Region({
//     required this.coords,
//     required this.id,
//     required this.name,
//     required this.zoom,
//   });
//
//   factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
//   Map<String, dynamic> toJson() => _$RegionToJson(this);
//
//   final LatLng coords;
//   final String id;
//   final String name;
//   final double zoom;
// }

@JsonSerializable()
class Cars{
  Cars({
    required this.address,
    required this.id,
    // required this.image,
    required this.lat,
    required this.lng,
    required this.name,

  });

  factory Cars.fromJson(Map<String, dynamic> json) => _$CarsFromJson(json);
  Map<String, dynamic> toJson() => _$CarsToJson(this);

  final String address;
  final String id;
  // final String image;
  final double lat;
  final double lng;
  final String name;

}

@JsonSerializable()
class Locations {
  Locations({
    required this.cars,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Cars> cars;
}

// Future<Locations> getCars() async {
//   const googleLocationsURL = 'https://about.google/static/data/locations.json';
//
//   // Retrieve the locations of Google offices
//   try {
//     final response = await http.get(Uri.parse(googleLocationsURL));
//     if (response.statusCode == 200) {
//       return Locations.fromJson(json.decode(response.body));
//     }else {
//       null;
//     }
//   } catch (e) {
//     print(e);
//   }
//   return null;

// Fallback for when the above HTTP request fails.
// return Locations.fromJson(
//   json.decode(
//     await rootBundle.loadString('assets/locations.json'),
//   ),
// );
// }