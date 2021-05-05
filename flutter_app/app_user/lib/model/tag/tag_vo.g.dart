// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagVO _$TagVOFromJson(Map<String, dynamic> json) {
  return TagVO(
    index: json['tagIdx'] as int,
    name: json['tagName'] as String,
  );
}

Map<String, dynamic> _$TagVOToJson(TagVO instance) => <String, dynamic>{
      'tagIdx': instance.index,
      'tagName': instance.name,
    };
