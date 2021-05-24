// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comp_apply_status_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompApplyStatusVO _$CompApplyStatusVOFromJson(Map<String, dynamic> json) {
  return CompApplyStatusVO(
    index: json['applicationEmploymentIdx'] as int,
    status: json['applicationEmploymentStatus'] as String,
    title: json['employmentAnnouncementName'] as String,
    gitHubUrl: json['gitHubURL'] as String,
    classNumber: json['memberClassNumber'] as String,
    field: json['recruitmentField'] as String,
  );
}

Map<String, dynamic> _$CompApplyStatusVOToJson(CompApplyStatusVO instance) =>
    <String, dynamic>{
      'applicationEmploymentIdx': instance.index,
      'applicationEmploymentStatus': instance.status,
      'employmentAnnouncementName': instance.title,
      'gitHubURL': instance.gitHubUrl,
      'memberClassNumber': instance.classNumber,
      'recruitmentField': instance.field,
    };
