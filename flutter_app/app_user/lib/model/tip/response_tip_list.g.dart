// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_tip_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseTipList _$ResponseTipListFromJson(Map<String, dynamic> json) {
  return ResponseTipList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map(
            (e) => e == null ? null : TipVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseTipListToJson(ResponseTipList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
