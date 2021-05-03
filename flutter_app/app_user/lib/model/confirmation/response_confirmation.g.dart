// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_confirmation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseConfirmation _$ResponseConfirmationFromJson(Map<String, dynamic> json) {
  return ResponseConfirmation(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : ConfirmationVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseConfirmationToJson(
        ResponseConfirmation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
