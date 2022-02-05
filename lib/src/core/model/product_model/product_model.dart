import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  Product({
    required this.productId,
    required this.productName,
    required this.description,
    required this.availability,
    // required this.rate,
  });
  final int productId;
  final String productName;
  final String description;
  final bool availability;
  // final List rate;
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
