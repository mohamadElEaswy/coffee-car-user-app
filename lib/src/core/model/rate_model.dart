import 'package:json_annotation/json_annotation.dart';

part 'rate_model.g.dart';

@JsonSerializable()
class Rate {
  final int rateId;
  final String userName;
  final int userId;
  final double userRating;
  final String userText;

  Rate(
      {required this.rateId,
      required this.userName,
      required this.userId,
      required this.userRating,
      required this.userText,});

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
  Map<String, dynamic> toJson()=> _$RateToJson(this);
}
