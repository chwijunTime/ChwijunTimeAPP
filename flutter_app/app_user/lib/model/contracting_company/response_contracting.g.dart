// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_contracting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseContracting _$ResponseContractingFromJson(Map<String, dynamic> json) {
  return ResponseContracting(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : ContractingVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseContractingToJson(
        ResponseContracting instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
