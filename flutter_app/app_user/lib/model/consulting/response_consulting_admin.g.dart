// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_consulting_admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseConsultingAdmin _$ResponseConsultingAdminFromJson(
    Map<String, dynamic> json) {
  return ResponseConsultingAdmin(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : ConsultingAdminVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseConsultingAdminToJson(
        ResponseConsultingAdmin instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
