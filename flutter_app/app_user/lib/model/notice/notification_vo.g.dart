// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationVO _$NotificationVOFromJson(Map<String, dynamic> json) {
  return NotificationVO(
    title: json['title'] as String,
    content: json['content'] as String,
    date: json['createDated'] as String,
    isFavorite: json['isFavorite'] as bool,
    tag: (json['tag'] as List)?.map((e) => e as String)?.toList(),
  )
    ..memberVO = json['member'] == null
        ? null
        : MemberVO.fromJson(json['member'] as Map<String, dynamic>)
    ..index = json['noticeIdx'] as int;
}

Map<String, dynamic> _$NotificationVOToJson(NotificationVO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'createDated': instance.date,
      'member': instance.memberVO,
      'noticeIdx': instance.index,
      'isFavorite': instance.isFavorite,
      'tag': instance.tag,
    };
