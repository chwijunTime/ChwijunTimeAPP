// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_comp_status_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCompStatusList _$ResponseCompStatusListFromJson(
    Map<String, dynamic> json) {
  return ResponseCompStatusList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : CompApplyStatusVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseCompStatusListToJson(
        ResponseCompStatusList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
