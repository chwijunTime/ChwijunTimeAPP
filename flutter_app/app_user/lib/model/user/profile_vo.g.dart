// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileVO _$ProfileVOFromJson(Map<String, dynamic> json) {
  return ProfileVO(
    member: json['member'] == null
        ? null
        : UserInfoVO.fromJson(json['member'] as Map<String, dynamic>),
    tag: (json['memberTags'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ProfileVOToJson(ProfileVO instance) => <String, dynamic>{
      'member': instance.member,
      'memberTags': instance.tag,
    };
