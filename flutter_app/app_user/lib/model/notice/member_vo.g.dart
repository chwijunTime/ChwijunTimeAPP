// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberVO _$MemberVOFromJson(Map<String, dynamic> json) {
  return MemberVO(
    date: json['createdDate'] as String,
    classNumber: json['memberClassNumber'] as String,
    memberDate: json['memberCreated'] as String,
    etc: json['memberETC'] as String,
    email: json['memberEmail'] as String,
    index: json['memberIdx'] as int,
    phone: json['memberPhoneNumber'] as String,
    modifyDate: json['modifiedDate'] as String,
    role: (json['roles'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$MemberVOToJson(MemberVO instance) => <String, dynamic>{
      'createdDate': instance.date,
      'memberClassNumber': instance.classNumber,
      'memberCreated': instance.memberDate,
      'memberETC': instance.etc,
      'memberEmail': instance.email,
      'memberIdx': instance.index,
      'memberPhoneNumber': instance.phone,
      'modifiedDate': instance.modifyDate,
      'roles': instance.role,
    };
