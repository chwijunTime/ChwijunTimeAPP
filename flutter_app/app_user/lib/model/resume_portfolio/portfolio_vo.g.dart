// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioVO _$PortfolioVOFromJson(Map<String, dynamic> json) {
  return PortfolioVO(
    member: json['member'] == null
        ? null
        : UserInfoVO.fromJson(json['member'] as Map<String, dynamic>),
    index: json['memberPortfolioIdx'] as int,
    portfolioUrl: json['notionPortfolioURL'] as String,
    user: json['user'] as String,
    state: json['state'] as String,
  );
}

Map<String, dynamic> _$PortfolioVOToJson(PortfolioVO instance) =>
    <String, dynamic>{
      'member': instance.member,
      'memberPortfolioIdx': instance.index,
      'notionPortfolioURL': instance.portfolioUrl,
      'user': instance.user,
      'state': instance.state,
    };
