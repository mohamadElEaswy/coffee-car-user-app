import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.availability,
    required this.category,
    required this.time,
    this.quantity,
    // required this.rate,
  });
  final String id;
  final String name;
  final dynamic price;
  int? quantity;
  final String category;
  final String description;
  final bool availability;
  final DateTime time;
  // final List rate;
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
