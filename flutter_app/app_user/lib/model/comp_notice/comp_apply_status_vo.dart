import 'package:json_annotation/json_annotation.dart';

part 'comp_apply_status_vo.g.dart';

@JsonSerializable()
class CompApplyStatusVO{
  @JsonKey(name: "applicationEmploymentIdx")
  int index;
  @JsonKey(name: 'applicationEmploymentStatus')
  String status;
  @JsonKey(name: 'employmentAnnouncementName')
  String title;
  @JsonKey(name: 'gitHubURL')
  String gitHubUrl;
  @JsonKey(name: "memberClassNumber")
  String classNumber;
  @JsonKey(name: "recruitmentField")
  String field;

  CompApplyStatusVO(
      {this.index,
      this.status,
      this.title,
      this.gitHubUrl,
      this.classNumber,
      this.field});

  factory CompApplyStatusVO.fromJson(Map<String, dynamic> json) => _$CompApplyStatusVOFromJson(json);

  Map<String, dynamic> toJson() => _$CompApplyStatusVOToJson(this);
}