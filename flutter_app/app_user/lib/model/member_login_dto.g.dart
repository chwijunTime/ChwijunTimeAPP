// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberLoginDTO _$MemberLoginDTOFromJson(Map<String, dynamic> json) {
  return MemberLoginDTO(
    memberEmail: json['memberEmail'] as String,
    memberPassword: json['memberPassword'] as String,
  );
}

Map<String, dynamic> _$MemberLoginDTOToJson(MemberLoginDTO instance) =>
    <String, dynamic>{
      'memberEmail': instance.memberEmail,
      'memberPassword': instance.memberPassword,
    };
