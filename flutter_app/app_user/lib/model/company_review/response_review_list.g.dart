// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_review_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseReviewList _$ResponseReviewListFromJson(Map<String, dynamic> json) {
  return ResponseReviewList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) =>
            e == null ? null : ReviewVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseReviewListToJson(ResponseReviewList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
