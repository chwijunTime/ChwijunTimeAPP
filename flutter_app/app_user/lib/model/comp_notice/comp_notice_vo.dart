import 'package:json_annotation/json_annotation.dart';

part 'comp_notice_vo.g.dart';

@JsonSerializable()
class CompNoticeVO{
  @JsonKey(name: "announcementDate")
  String startDate;
  @JsonKey(name: "deadLine")
  String deadLine;
  @JsonKey(name: "employmentAnnouncementAddress")
  String address;
  @JsonKey(name: "employmentAnnouncementEtc")
  String etc;
  @JsonKey(name: "employmentAnnouncementExplanation")
  String info;
  @JsonKey(name: "employmentAnnouncementIdx")
  int index;
  @JsonKey(name: "employmentAnnouncementName")
  String title;
  @JsonKey(name: "employmentAnnouncementTags")
  List<String> tag;
  @JsonKey(name: "tagName")
  List<String> postTag;
  @JsonKey(name: "preferentialConditions")
  String preferential;
  @JsonKey(name: "recruitmentField")
  String field;

  CompNoticeVO(
      {this.startDate,
      this.deadLine,
      this.address,
      this.etc,
      this.info,
      this.index,
      this.title,
      this.tag,
      this.preferential,
      this.field,
      this.postTag});

  factory CompNoticeVO.fromJson(Map<String, dynamic> json) => _$CompNoticeVOFromJson(json);

  Map<String, dynamic> toJson() => _$CompNoticeVOToJson(this);
}