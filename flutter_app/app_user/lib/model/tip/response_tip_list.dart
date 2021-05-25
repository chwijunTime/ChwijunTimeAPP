import 'package:app_user/model/tip/tip_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_tip_list.g.dart';

@JsonSerializable()
class ResponseTipList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "list")
  List<TipVO> list;
  @JsonKey(name: "msg")
  String msg;
  @JsonKey(name: "success")
  bool success;

  ResponseTipList({this.code, this.list, this.msg, this.success});

  factory ResponseTipList.fromJson(Map<String, dynamic> json) => _$ResponseTipListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseTipListToJson(this);
}