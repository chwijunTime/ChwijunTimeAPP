// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_apply_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostApplyVO _$PostApplyVOFromJson(Map<String, dynamic> json) {
  return PostApplyVO(
    portfolioURL: json['applicationEmploymentPortfolioURL'] as String,
    resumeURL: json['applicationEmploymentResumeURL'] as String,
    gitHubURL: json['gitHubURL'] as String,
  );
}

Map<String, dynamic> _$PostApplyVOToJson(PostApplyVO instance) =>
    <String, dynamic>{
      'applicationEmploymentPortfolioURL': instance.portfolioURL,
      'applicationEmploymentResumeURL': instance.resumeURL,
      'gitHubURL': instance.gitHubURL,
    };
