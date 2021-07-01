// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_comp_status_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCompStatusDetail _$ResponseCompStatusDetailFromJson(
    Map<String, dynamic> json) {
  return ResponseCompStatusDetail(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : ApplyEmployment.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseCompStatusDetailToJson(
        ResponseCompStatusDetail instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
