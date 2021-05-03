import 'package:app_user/model/comp_notice/comp_notice_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_comp_notice_list.g.dart';

@JsonSerializable()
class ResponseCompNoticeList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<CompNoticeVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseCompNoticeList({this.code, this.list, this.msg, this.success});

  factory ResponseCompNoticeList.fromJson(Map<String, dynamic> json) => _$ResponseCompNoticeListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCompNoticeListToJson(this);
}