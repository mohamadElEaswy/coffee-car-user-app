import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category {
  Category({
    this.id = '',
    required this.name,
    // required this.time,
    // required this.products,
  });

  final String? id ;
  final String name;
  // final DateTime time;
  // final List<Product> products;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}