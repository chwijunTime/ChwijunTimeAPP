// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseReview _$ResponseReviewFromJson(Map<String, dynamic> json) {
  return ResponseReview(
    code: json['code'] as int,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ReviewVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseReviewToJson(ResponseReview instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
