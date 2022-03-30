// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      uId: json['uId'] as String,
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String,
      city: json['city'] as String,
      userType: json['userType'] as String,
      joinDate: DateTime.parse(json['joinDate'] as String),
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'uId': instance.uId,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'city': instance.city,
      'userType': instance.userType,
      'joinDate': instance.joinDate.toIso8601String(),
    };
