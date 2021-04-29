import 'package:app_user/model/notice/notification_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_notice_list.g.dart';

@JsonSerializable()
class ResponseNoticeList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<NotificationVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseNoticeList({this.code, this.list, this.msg, this.success});

  factory ResponseNoticeList.fromJson(Map<String, dynamic> json) => _$ResponseNoticeListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseNoticeListToJson(this);
}