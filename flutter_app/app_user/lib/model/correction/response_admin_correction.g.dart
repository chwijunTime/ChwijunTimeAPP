// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_admin_correction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseAdminCorrection _$ResponseAdminCorrectionFromJson(
    Map<String, dynamic> json) {
  return ResponseAdminCorrection(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : AdminCorrectionVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseAdminCorrectionToJson(
        ResponseAdminCorrection instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
