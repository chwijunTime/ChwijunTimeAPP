// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_consulting_admin_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseConsultingAdminList _$ResponseConsultingAdminListFromJson(
    Map<String, dynamic> json) {
  return ResponseConsultingAdminList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : ConsultingAdminVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseConsultingAdminListToJson(
        ResponseConsultingAdminList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
