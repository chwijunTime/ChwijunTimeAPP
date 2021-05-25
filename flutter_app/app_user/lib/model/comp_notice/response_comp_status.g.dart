// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_comp_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCompStatus _$ResponseCompStatusFromJson(Map<String, dynamic> json) {
  return ResponseCompStatus(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : CompStatusDetailVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseCompStatusToJson(ResponseCompStatus instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
