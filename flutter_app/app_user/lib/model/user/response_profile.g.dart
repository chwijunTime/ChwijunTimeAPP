// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseProfile _$ResponseProfileFromJson(Map<String, dynamic> json) {
  return ResponseProfile(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : ProfileVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseProfileToJson(ResponseProfile instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
