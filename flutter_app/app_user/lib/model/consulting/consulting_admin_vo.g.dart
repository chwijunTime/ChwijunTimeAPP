// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consulting_admin_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsultingAdminVO _$ConsultingAdminVOFromJson(Map<String, dynamic> json) {
  return ConsultingAdminVO(
    applyDate: json['applicationDate'] as String,
    index: json['consultingIdx'] as int,
    type: json['consultingStatus'] as String,
  );
}

Map<String, dynamic> _$ConsultingAdminVOToJson(ConsultingAdminVO instance) =>
    <String, dynamic>{
      'applicationDate': instance.applyDate,
      'consultingIdx': instance.index,
      'consultingStatus': instance.type,
    };
