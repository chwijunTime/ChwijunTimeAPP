// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_comp_notice_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCompNoticeList _$ResponseCompNoticeListFromJson(
    Map<String, dynamic> json) {
  return ResponseCompNoticeList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) =>
            e == null ? null : CompNoticeVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseCompNoticeListToJson(
        ResponseCompNoticeList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
