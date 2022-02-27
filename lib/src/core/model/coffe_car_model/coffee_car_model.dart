import 'package:json_annotation/json_annotation.dart';

part 'coffee_car_model.g.dart';

@JsonSerializable()
class CoffeeCar {
  CoffeeCar({
    required this.carName,
    required this.lat,
    required this.lng,
    required this.providerName,
    required this.carId,
    required this.providerId,
    required this.availability,
    required this.address,
    required this.products,
    required this.reviews,
  });

  final String carName;
  final double lat;
  final double lng;
  final String providerName;
  final String address;
  final String carId;
  final String providerId;
  final bool availability;
  final bool products;
  final bool reviews;

  factory CoffeeCar.fromJson(Map<String, dynamic> json) =>
      _$CoffeeCarFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeCarToJson(this);
}

@JsonSerializable()
class CarsList{
  CarsList({required this.cars});
  final List<CoffeeCar> cars;

  factory CarsList.fromJson(Map<String, dynamic> json) =>
      _$CarsListFromJson(json);

  Map<String, dynamic> toJson() => _$CarsListToJson(this);
}
