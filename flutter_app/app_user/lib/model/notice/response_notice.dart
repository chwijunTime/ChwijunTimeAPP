import 'package:app_user/model/notice/notification_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_notice.g.dart';

@JsonSerializable()
class ResponseNotice{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  NotificationVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseNotice({this.code, this.data, this.msg, this.success});

  factory ResponseNotice.fromJson(Map<String, dynamic> json) => _$ResponseNoticeFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseNoticeToJson(this);
}