import 'package:json_annotation/json_annotation.dart';

part 'reviews_model.g.dart';


@JsonSerializable()
class Reviews{
  Reviews({
    required this.uId,
    required this.userName,
    required this.reviewText,
});
  final String uId;
  final String userName;
  final String reviewText;
  factory Reviews.fromJson(Map<String, dynamic> json) => _$ReviewsFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}