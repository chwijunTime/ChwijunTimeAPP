// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consulting_user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsultingUserVO _$ConsultingUserVOFromJson(Map<String, dynamic> json) {
  return ConsultingUserVO(
    applyDate: json['applicationDate'] as String,
    classNumber: json['consultingUserClassNumber'] as String,
    index: json['consultingUserIdx'] as int,
    name: json['consultingUserName'] as String,
  );
}

Map<String, dynamic> _$ConsultingUserVOToJson(ConsultingUserVO instance) =>
    <String, dynamic>{
      'applicationDate': instance.applyDate,
      'consultingUserClassNumber': instance.classNumber,
      'consultingUserIdx': instance.index,
      'consultingUserName': instance.name,
    };
