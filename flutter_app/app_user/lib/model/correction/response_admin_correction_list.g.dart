// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_admin_correction_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseAdminCorrectionList _$ResponseAdminCorrectionListFromJson(
    Map<String, dynamic> json) {
  return ResponseAdminCorrectionList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : AdminCorrectionVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseAdminCorrectionListToJson(
        ResponseAdminCorrectionList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
