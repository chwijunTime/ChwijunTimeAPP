// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_comp_notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseNoticeComp _$ResponseNoticeCompFromJson(Map<String, dynamic> json) {
  return ResponseNoticeComp(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : CompNoticeVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseNoticeCompToJson(ResponseNoticeComp instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
