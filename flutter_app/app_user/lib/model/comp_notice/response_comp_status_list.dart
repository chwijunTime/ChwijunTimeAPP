import 'package:app_user/model/comp_notice/comp_apply_status_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_comp_status_list.g.dart';

@JsonSerializable()
class ResponseCompStatusList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<CompApplyStatusVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseCompStatusList({this.code, this.list, this.msg, this.success});

  factory ResponseCompStatusList.fromJson(Map<String, dynamic> json) => _$ResponseCompStatusListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCompStatusListToJson(this);
}