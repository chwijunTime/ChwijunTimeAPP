// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's_notice_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SNoticeVO _$SNoticeVOFromJson(Map<String, dynamic> json) {
  return SNoticeVO(
    title: json['title'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$SNoticeVOToJson(SNoticeVO instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };
