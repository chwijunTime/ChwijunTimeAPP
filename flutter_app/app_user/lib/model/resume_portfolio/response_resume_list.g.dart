// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_resume_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseResumeList _$ResponseResumeListFromJson(Map<String, dynamic> json) {
  return ResponseResumeList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) =>
            e == null ? null : ResumeVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseResumeListToJson(ResponseResumeList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
