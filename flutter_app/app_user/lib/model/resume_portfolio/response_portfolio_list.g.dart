// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_portfolio_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePortfolioList _$ResponsePortfolioListFromJson(
    Map<String, dynamic> json) {
  return ResponsePortfolioList(
    code: json['code'] as int,
    list: (json['list'] as List)
        ?.map((e) =>
            e == null ? null : PortfolioVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponsePortfolioListToJson(
        ResponsePortfolioList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'list': instance.list,
      'msg': instance.msg,
      'success': instance.success,
    };
