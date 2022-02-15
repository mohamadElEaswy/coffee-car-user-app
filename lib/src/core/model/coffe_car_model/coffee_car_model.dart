import 'package:json_annotation/json_annotation.dart';
import 'package:mk/src/core/model/product_model/product_model.dart';
import 'package:mk/src/core/model/rate_model/rate_model.dart';

part 'coffee_car_model.g.dart';


@JsonSerializable()
class CoffeeCar{
  CoffeeCar({
    required this.carName,
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
  final int carId;
  final int providerId;
  final bool availability;
  // final Location location;
  final List<Product> products;
  final List<Rate> rate;

  factory CoffeeCar.fromJson(Map<String, dynamic> json) => _$CoffeeCarFromJson(json);
  Map<String, dynamic> toJson() => _$CoffeeCarToJson(this);
}

