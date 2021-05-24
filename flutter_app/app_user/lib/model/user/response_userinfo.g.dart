// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_userinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseUserInfo _$ResponseUserInfoFromJson(Map<String, dynamic> json) {
  return ResponseUserInfo(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : UserInfoVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseUserInfoToJson(ResponseUserInfo instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
