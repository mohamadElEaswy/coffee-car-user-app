// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
      uId: json['uId'] as String,
      userName: json['userName'] as String,
      reviewText: json['reviewText'] as String,
    );

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'uId': instance.uId,
      'userName': instance.userName,
      'reviewText': instance.reviewText,
    };
