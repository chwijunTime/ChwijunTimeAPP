// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_correction_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCorrectionList _$ResponseCorrectionListFromJson(
    Map<String, dynamic> json) {
  return ResponseCorrectionList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) =>
            e == null ? null : CorrectionVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseCorrectionListToJson(
        ResponseCorrectionList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
