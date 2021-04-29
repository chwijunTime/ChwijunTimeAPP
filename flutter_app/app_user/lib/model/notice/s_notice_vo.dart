import 'package:json_annotation/json_annotation.dart';

part 's_notice_vo.g.dart';

@JsonSerializable()
class SNoticeVO {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "content")
  String content;


  SNoticeVO({this.title, this.content});

  factory SNoticeVO.fromJson(Map<String, dynamic> json) => _$SNoticeVOFromJson(json);

  Map<String, dynamic> toJson() => _$SNoticeVOToJson(this);
}