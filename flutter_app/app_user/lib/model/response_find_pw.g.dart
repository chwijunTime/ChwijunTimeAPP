// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_find_pw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseFindPW _$ResponseFindPWFromJson(Map<String, dynamic> json) {
  return ResponseFindPW(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : FindPWData.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseFindPWToJson(ResponseFindPW instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
