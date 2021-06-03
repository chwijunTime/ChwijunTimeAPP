// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumeVO _$ResumeVOFromJson(Map<String, dynamic> json) {
  return ResumeVO(
    member: json['member'] == null
        ? null
        : UserInfoVO.fromJson(json['member'] as Map<String, dynamic>),
    index: json['memberResumeIdx'] as int,
    resumeUrl: json['notionResumeURL'] as String,
    user: json['user'] as String,
    state: json['state'] as String,
    resResumeUrl: json['resumeFileURL'] as String,
  );
}

Map<String, dynamic> _$ResumeVOToJson(ResumeVO instance) => <String, dynamic>{
      'member': instance.member,
      'memberResumeIdx': instance.index,
      'notionResumeURL': instance.resumeUrl,
      'resumeFileURL': instance.resResumeUrl,
      'user': instance.user,
      'state': instance.state,
    };
