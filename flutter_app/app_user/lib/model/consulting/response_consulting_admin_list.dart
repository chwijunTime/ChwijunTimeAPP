import 'package:app_user/model/consulting/consulting_admin_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_consulting_admin_list.g.dart';

@JsonSerializable()
class ResponseConsultingAdminList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<ConsultingAdminVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseConsultingAdminList({this.code, this.list, this.msg, this.success});

  factory ResponseConsultingAdminList.fromJson(Map<String, dynamic> json) => _$ResponseConsultingAdminListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseConsultingAdminListToJson(this);
}