import 'package:app_user/model/consulting/consulting_admin_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_consulting_admin.g.dart';

@JsonSerializable()
class ResponseConsultingAdmin{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  ConsultingAdminVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseConsultingAdmin({this.code, this.data, this.msg, this.success});

  factory ResponseConsultingAdmin.fromJson(Map<String, dynamic> json) => _$ResponseConsultingAdminFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseConsultingAdminToJson(this);
}