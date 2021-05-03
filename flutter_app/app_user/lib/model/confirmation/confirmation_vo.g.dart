// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirmation_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmationVO _$ConfirmationVOFromJson(Map<String, dynamic> json) {
  return ConfirmationVO(
    address: json['employmentConfirmationAddress'] as String,
    area: json['employmentConfirmationAreas'] as String,
    classNumber: json['employmentConfirmationClassNumber'] as String,
    etc: json['employmentConfirmationEtc'] as String,
    index: json['employmentConfirmationIdx'] as int,
    title: json['employmentConfirmationName'] as String,
    siteUrl: json['employmentConfirmationSite'] as String,
    tag: (json['employmentConfirmationTags'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    postTag: (json['tagName'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ConfirmationVOToJson(ConfirmationVO instance) =>
    <String, dynamic>{
      'employmentConfirmationAddress': instance.address,
      'employmentConfirmationAreas': instance.area,
      'employmentConfirmationClassNumber': instance.classNumber,
      'employmentConfirmationEtc': instance.etc,
      'employmentConfirmationIdx': instance.index,
      'employmentConfirmationName': instance.title,
      'employmentConfirmationSite': instance.siteUrl,
      'employmentConfirmationTags': instance.tag,
      'tagName': instance.postTag,
    };
