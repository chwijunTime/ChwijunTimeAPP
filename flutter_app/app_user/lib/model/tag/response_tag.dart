import 'package:app_user/model/tag/tag_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_tag.g.dart';

@JsonSerializable()
class ResponseTag{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  TagVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseTag({this.code, this.data, this.msg, this.success});

  factory ResponseTag.fromJson(Map<String, dynamic> json) => _$ResponseTagFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseTagToJson(this);
}