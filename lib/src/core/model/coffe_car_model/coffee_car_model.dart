import 'package:json_annotation/json_annotation.dart';


part 'coffee_car_model.g.dart';


@JsonSerializable()
class CoffeeCar{
  CoffeeCar({
    required this.carName,
    required this.lang,
    required this.lat,
    required this.providerName,
    required this.carId,
    required this.providerId,
    required this.availability,
    required this.address,
    // required this.location,
    required this.products,
    required this.rate,
  });

  final String carName;
  final String providerName;
  final String address;
  final String carId;
  final String providerId;
  final bool availability;
  final String lang;
  final String lat;
  // final Location location;
  final bool products;
  final bool rate;

  factory CoffeeCar.fromJson(Map<String, dynamic> json) => _$CoffeeCarFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeCarToJson(this);
}

