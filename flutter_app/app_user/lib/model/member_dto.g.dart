// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDTO _$MemberDTOFromJson(Map<String, dynamic> json) {
  return MemberDTO(
    memberClassNumber: json['memberClassNumber'] as String,
    memberEmail: json['memberEmail'] as String,
    memberPassword: json['memberPassword'] as String,
  );
}

Map<String, dynamic> _$MemberDTOToJson(MemberDTO instance) => <String, dynamic>{
      'memberClassNumber': instance.memberClassNumber,
      'memberEmail': instance.memberEmail,
      'memberPassword': instance.memberPassword,
    };
