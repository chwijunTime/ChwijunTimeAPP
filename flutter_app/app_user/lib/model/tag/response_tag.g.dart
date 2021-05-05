// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseTag _$ResponseTagFromJson(Map<String, dynamic> json) {
  return ResponseTag(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : TagVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseTagToJson(ResponseTag instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
