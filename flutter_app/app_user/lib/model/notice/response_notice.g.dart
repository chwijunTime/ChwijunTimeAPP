// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseNotice _$ResponseNoticeFromJson(Map<String, dynamic> json) {
  return ResponseNotice(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : NotificationVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseNoticeToJson(ResponseNotice instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
