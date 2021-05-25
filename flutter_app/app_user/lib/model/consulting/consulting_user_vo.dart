import 'package:json_annotation/json_annotation.dart';

part 'consulting_user_vo.g.dart';

@JsonSerializable()
class ConsultingUserVO{
  @JsonKey(name: "applicationDate")
  String applyDate;
  @JsonKey(name: "consultingUserClassNumber")
  String classNumber;
  @JsonKey(name: "consultingUserIdx")
  int index;
  @JsonKey(name: "consultingUserName")
  String name;

  ConsultingUserVO({this.applyDate, this.classNumber, this.index, this.name});

  factory ConsultingUserVO.fromJson(Map<String, dynamic> json) => _$ConsultingUserVOFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultingUserVOToJson(this);
}