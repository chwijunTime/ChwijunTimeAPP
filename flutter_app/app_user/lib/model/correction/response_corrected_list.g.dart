// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_corrected_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCorrectedList _$ResponseCorrectedListFromJson(
    Map<String, dynamic> json) {
  return ResponseCorrectedList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) =>
            e == null ? null : CorrectedVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseCorrectedListToJson(
        ResponseCorrectedList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
