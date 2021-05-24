// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userinfo_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoVO _$UserInfoVOFromJson(Map<String, dynamic> json) {
  return UserInfoVO(
    createDate: json['createdDate'] as String,
    classNumber: json['memberClassNumber'] as String,
    memberCreatedDate: json['memberCreated'] as String,
    etc: json['memberETC'] as String,
    email: json['memberEmail'] as String,
    index: json['memberIdx'] as int,
    phone: json['memberPhoneNumber'] as String,
    modifyDate: json['modifiedDate'] as String,
    roles: (json['roles'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UserInfoVOToJson(UserInfoVO instance) =>
    <String, dynamic>{
      'createdDate': instance.createDate,
      'memberClassNumber': instance.classNumber,
      'memberCreated': instance.memberCreatedDate,
      'memberETC': instance.etc,
      'memberEmail': instance.email,
      'memberIdx': instance.index,
      'memberPhoneNumber': instance.phone,
      'modifiedDate': instance.modifyDate,
      'roles': instance.roles,
    };
