import 'package:app_user/model/resume_portfolio/resume_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_resume_list.g.dart';

@JsonSerializable()
class ResponseResumeList {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "list")
  List<ResumeVO> list;
  @JsonKey(name: "msg")
  String msg;
  @JsonKey(name: "success")
  bool success;

  ResponseResumeList({this.code, this.list, this.msg, this.success});

  factory ResponseResumeList.fromJson(Map<String, dynamic> json) =>
      _$ResponseResumeListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseResumeListToJson(this);
}
