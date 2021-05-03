// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_comfirmation_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseConfirmationList _$ResponseConfirmationListFromJson(
    Map<String, dynamic> json) {
  return ResponseConfirmationList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : ConfirmationVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseConfirmationListToJson(
        ResponseConfirmationList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
