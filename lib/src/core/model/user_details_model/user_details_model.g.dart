// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      uId: json['uId'] as String,
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      city: json['city'] as String,
      coords: LatLng.fromJson(json['coords'] as Map<String, dynamic>),
      userType: json['userType'] as String,
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'uId': instance.uId,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'city': instance.city,
      'userType': instance.userType,
      'coords': instance.coords,
    };
