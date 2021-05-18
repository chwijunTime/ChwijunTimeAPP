// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comp_notice_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompNoticeVO _$CompNoticeVOFromJson(Map<String, dynamic> json) {
  return CompNoticeVO(
    startDate: json['announcementDate'] as String,
    deadLine: json['deadLine'] as String,
    address: json['employmentAnnouncementAddress'] as String,
    etc: json['employmentAnnouncementEtc'] as String,
    info: json['employmentAnnouncementExplanation'] as String,
    index: json['employmentAnnouncementIdx'] as int,
    title: json['employmentAnnouncementName'] as String,
    tag: (json['employmentAnnouncementTags'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    preferential: json['preferentialConditions'] as String,
    field: json['recruitmentField'] as String,
    postTag: (json['tagName'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CompNoticeVOToJson(CompNoticeVO instance) =>
    <String, dynamic>{
      'announcementDate': instance.startDate,
      'deadLine': instance.deadLine,
      'employmentAnnouncementAddress': instance.address,
      'employmentAnnouncementEtc': instance.etc,
      'employmentAnnouncementExplanation': instance.info,
      'employmentAnnouncementIdx': instance.index,
      'employmentAnnouncementName': instance.title,
      'employmentAnnouncementTags': instance.tag,
      'tagName': instance.postTag,
      'preferentialConditions': instance.preferential,
      'recruitmentField': instance.field,
    };
