import 'package:app_user/model/resume_portfolio/resume_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_resume.g.dart';

@JsonSerializable()
class ResponseResume{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "data")
  ResumeVO data;
  @JsonKey(name: "msg")
  String msg;
  @JsonKey(name: "success")
  bool success;

  ResponseResume({this.code, this.data, this.msg, this.success});

  factory ResponseResume.fromJson(Map<String, dynamic> json) =>
      _$ResponseResumeFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseResumeToJson(this);
}
