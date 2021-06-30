import 'package:app_user/model/correction/admin_correction_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_admin_correction_list.g.dart';

@JsonSerializable()
class ResponseAdminCorrectionList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<AdminCorrectionVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;

  ResponseAdminCorrectionList({this.code, this.list, this.msg, this.success});

  factory ResponseAdminCorrectionList.fromJson(Map<String, dynamic> json) => _$ResponseAdminCorrectionListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseAdminCorrectionListToJson(this);
}