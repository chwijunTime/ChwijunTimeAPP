import 'package:app_user/model/notice/member_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_vo.g.dart';

@JsonSerializable()
class NotificationVO {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "createDated")
  String date;
  @JsonKey(name: "member")
  MemberVO memberVO;
  @JsonKey(name: "noticeIdx")
  int index;

  NotificationVO(
      {this.title, this.content, this.date, this.memberVO, this.index});

  @override
  String toString() {
    return 'NotificationVO{title: $title, content: $content, date: $date, memberVO: $memberVO, index: $index}';
  }

  factory NotificationVO.fromJson(Map<String, dynamic> json) =>
      _$NotificationVOFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationVOToJson(this);
}
