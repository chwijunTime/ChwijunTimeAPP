// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_correction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCorrection _$ResponseCorrectionFromJson(Map<String, dynamic> json) {
  return ResponseCorrection(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : CorrectionVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseCorrectionToJson(ResponseCorrection instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
