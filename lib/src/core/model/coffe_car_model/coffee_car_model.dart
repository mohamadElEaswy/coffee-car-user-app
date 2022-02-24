import 'package:json_annotation/json_annotation.dart';
import 'package:mk/src/locations.dart';


part 'coffee_car_model.g.dart';


@JsonSerializable()
class CoffeeCar{
  CoffeeCar({
    required this.carName,
    required this.coords,
    required this.providerName,
    required this.carId,
    required this.providerId,
    required this.availability,
    required this.address,
    // required this.location,
    required this.products,
    required this.reviews,
    // required this.orders,
    // required this.orders,
  });

  final String carName;
  final String providerName;
  final String address;
  final String carId;
  final String providerId;
  final bool availability;
  final LatLng coords;
  final bool products;
  final bool reviews;

  factory CoffeeCar.fromJson(Map<String, dynamic> json) => _$CoffeeCarFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeCarToJson(this);
}

