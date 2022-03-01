import 'package:json_annotation/json_annotation.dart';

part 'user_details_model.g.dart';

@JsonSerializable()
class UserDetails {
  UserDetails({
    required this.uId,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.city,
    required this.userType,
    required this.joinDate
  });

  final String uId;
  final String userName;
  final String? phoneNumber;
  final String email;
  final String city;
  final String userType;
  final DateTime joinDate;

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
