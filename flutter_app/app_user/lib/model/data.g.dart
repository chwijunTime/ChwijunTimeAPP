// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    accessToken: json['accessToken'] as String,
    memberClassNumber: json['memberClassNumber'] as String,
    memberEmail: json['memberEmail'] as String,
    roles: json['roles'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'memberClassNumber': instance.memberClassNumber,
      'memberEmail': instance.memberEmail,
      'roles': instance.roles,
    };
