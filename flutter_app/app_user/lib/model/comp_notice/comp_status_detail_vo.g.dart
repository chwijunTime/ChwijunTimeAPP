// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comp_status_detail_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompStatusDetailVO _$CompStatusDetailVOFromJson(Map<String, dynamic> json) {
  return CompStatusDetailVO(
    data: json['applicationEmployment'] == null
        ? null
        : ApplyEmployment.fromJson(
            json['applicationEmployment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CompStatusDetailVOToJson(CompStatusDetailVO instance) =>
    <String, dynamic>{
      'applicationEmployment': instance.data,
    };
