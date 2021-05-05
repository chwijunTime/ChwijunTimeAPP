// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_tag_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseTagList _$ResponseTagListFromJson(Map<String, dynamic> json) {
  return ResponseTagList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map(
            (e) => e == null ? null : TagVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseTagListToJson(ResponseTagList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
