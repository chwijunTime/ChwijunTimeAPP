// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_resume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseResume _$ResponseResumeFromJson(Map<String, dynamic> json) {
  return ResponseResume(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : ResumeVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseResumeToJson(ResponseResume instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
