// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_portfolio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePortfolio _$ResponsePortfolioFromJson(Map<String, dynamic> json) {
  return ResponsePortfolio(
    code: json['code'] as int,
    data: json['data'] == null
        ? null
        : PortfolioVO.fromJson(json['data'] as Map<String, dynamic>),
    msg: json['msg'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ResponsePortfolioToJson(ResponsePortfolio instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'success': instance.success,
    };
