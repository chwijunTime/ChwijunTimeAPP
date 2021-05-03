import 'package:app_user/model/confirmation/confirmation_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_comfirmation_list.g.dart';

@JsonSerializable()
class ResponseConfirmationList {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<ConfirmationVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseConfirmationList({this.code, this.list, this.msg, this.success});

  factory ResponseConfirmationList.fromJson(Map<String, dynamic> json) => _$ResponseConfirmationListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseConfirmationListToJson(this);
}