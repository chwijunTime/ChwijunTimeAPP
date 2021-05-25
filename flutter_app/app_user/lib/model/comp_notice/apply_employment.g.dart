// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_employment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyEmployment _$ApplyEmploymentFromJson(Map<String, dynamic> json) {
  return ApplyEmployment(
    applyDate: json['applicationDate'] as String,
    applyIdx: json['applicationEmploymentIdx'] as int,
    portfolioUrl: json['applicationEmploymentPortfolioURL'] as String,
    resumeUrl: json['applicationEmploymentResumeURL'] as String,
    status: json['applicationEmploymentStatus'] as String,
    compNotice: json['employmentAnnouncement'] == null
        ? null
        : CompNoticeVO.fromJson(
            json['employmentAnnouncement'] as Map<String, dynamic>),
    githubUrl: json['gitHubURL'] as String,
    member: json['member'] == null
        ? null
        : UserInfoVO.fromJson(json['member'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ApplyEmploymentToJson(ApplyEmployment instance) =>
    <String, dynamic>{
      'applicationDate': instance.applyDate,
      'applicationEmploymentIdx': instance.applyIdx,
      'applicationEmploymentPortfolioURL': instance.portfolioUrl,
      'applicationEmploymentResumeURL': instance.resumeUrl,
      'applicationEmploymentStatus': instance.status,
      'employmentAnnouncement': instance.compNotice,
      'gitHubURL': instance.githubUrl,
      'member': instance.member,
    };
