import 'package:app_user/model/comp_notice/comp_notice_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_comp_notice.g.dart';

@JsonSerializable()
class ResponseNoticeComp{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  CompNoticeVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseNoticeComp({this.code, this.data, this.msg, this.success});

  factory ResponseNoticeComp.fromJson(Map<String, dynamic> json) => _$ResponseNoticeCompFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseNoticeCompToJson(this);
}