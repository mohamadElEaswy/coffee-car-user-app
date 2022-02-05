// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rate _$RateFromJson(Map<String, dynamic> json) => Rate(
      rateId: json['rateId'] as int,
      userName: json['userName'] as String,
      userId: json['userId'] as int,
      userRating: (json['userRating'] as num).toDouble(),
      userText: json['userText'] as String,
    );

Map<String, dynamic> _$RateToJson(Rate instance) => <String, dynamic>{
      'rateId': instance.rateId,
      'userName': instance.userName,
      'userId': instance.userId,
      'userRating': instance.userRating,
      'userText': instance.userText,
    };
