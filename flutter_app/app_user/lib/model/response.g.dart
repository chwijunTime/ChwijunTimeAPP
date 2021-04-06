// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response1 _$Response1FromJson(Map<String, dynamic> json) {
  return Response1(
    code: json['code'] as int,
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$Response1ToJson(Response1 instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'success': instance.success,
    };
