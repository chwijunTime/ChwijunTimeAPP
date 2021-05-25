// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipVO _$TipVOFromJson(Map<String, dynamic> json) {
  return TipVO(
    tag: (json['tagName'] as List)?.map((e) => e as String)?.toList(),
    tipInfo: json['tipsInfo'] as String,
    index: json['tipsStorageIdx'] as int,
    address: json['workCompanyAddress'] as String,
    title: json['workCompanyName'] as String,
  );
}

Map<String, dynamic> _$TipVOToJson(TipVO instance) => <String, dynamic>{
      'tagName': instance.tag,
      'tipsInfo': instance.tipInfo,
      'tipsStorageIdx': instance.index,
      'workCompanyAddress': instance.address,
      'workCompanyName': instance.title,
    };
