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
    compAddress: json['employmentAnnouncementAddress'] as String,
    compTitle: json['employmentAnnouncementName'] as String,
    githubUrl: json['gitHubURL'] as String,
    classNumber: json['memberClassNumber'] as String,
    email: json['memberEmail'] as String,
    field: json['recruitmentField'] as String,
  );
}

Map<String, dynamic> _$ApplyEmploymentToJson(ApplyEmployment instance) =>
    <String, dynamic>{
      'applicationDate': instance.applyDate,
      'applicationEmploymentIdx': instance.applyIdx,
      'applicationEmploymentPortfolioURL': instance.portfolioUrl,
      'applicationEmploymentResumeURL': instance.resumeUrl,
      'applicationEmploymentStatus': instance.status,
      'employmentAnnouncementAddress': instance.compAddress,
      'employmentAnnouncementName': instance.compTitle,
      'gitHubURL': instance.githubUrl,
      'memberClassNumber': instance.classNumber,
      'memberEmail': instance.email,
      'recruitmentField': instance.field,
    };
