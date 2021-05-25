import 'package:app_user/model/consulting/consulting_user_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_consulting_user_list.g.dart';

@JsonSerializable()
class ResponseConsultingUserList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<ConsultingUserVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseConsultingUserList({this.code, this.list, this.msg, this.success});

  factory ResponseConsultingUserList.fromJson(Map<String, dynamic> json) => _$ResponseConsultingUserListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseConsultingUserListToJson(this);
}