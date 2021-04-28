// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseNotice _$ResponseNoticeFromJson(Map<String, dynamic> json) {
  return ResponseNotice(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : NotificationVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseNoticeToJson(ResponseNotice instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
