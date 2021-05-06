// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_contracting_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseContractingList _$ResponseContractingListFromJson(
    Map<String, dynamic> json) {
  return ResponseContractingList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : ContractingVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponseContractingListToJson(
        ResponseContractingList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
