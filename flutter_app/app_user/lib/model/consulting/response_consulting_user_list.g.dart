// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_consulting_user_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseConsultingUserList _$ResponseConsultingUserListFromJson(
    Map<String, dynamic> json) {
  return ResponseConsultingUserList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : ConsultingUserVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseConsultingUserListToJson(
        ResponseConsultingUserList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
