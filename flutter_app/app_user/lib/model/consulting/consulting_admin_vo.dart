import 'package:json_annotation/json_annotation.dart';

part 'consulting_admin_vo.g.dart';

@JsonSerializable()
class ConsultingAdminVO{
  @JsonKey(name: "applicationDate")
  String applyDate;
  @JsonKey(name: "consultingIdx")
  int index;
  @JsonKey(name: "consultingStatus")
  String status;

  ConsultingAdminVO({this.applyDate, this.index, this.status});

  factory ConsultingAdminVO.fromJson(Map<String, dynamic> json) => _$ConsultingAdminVOFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultingAdminVOToJson(this);
}