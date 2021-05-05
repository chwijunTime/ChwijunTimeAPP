import 'package:app_user/model/tag/tag_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_tag_list.g.dart';

@JsonSerializable()
class ResponseTagList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<TagVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseTagList({this.code, this.list, this.msg, this.success});

  factory ResponseTagList.fromJson(Map<String, dynamic> json) => _$ResponseTagListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseTagListToJson(this);
}