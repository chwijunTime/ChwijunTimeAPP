// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_tip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseTip _$ResponseTipFromJson(Map<String, dynamic> json) {
  return ResponseTip(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : TipVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseTipToJson(ResponseTip instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
