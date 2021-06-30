import 'package:json_annotation/json_annotation.dart';

part 'confirmation_vo.g.dart';

@JsonSerializable()
class ConfirmationVO {
  @JsonKey(name: "employmentConfirmationAddress")
  String address;
  @JsonKey(name: "employmentConfirmationAreas")
  String area;
  @JsonKey(name: "employmentConfirmationClassNumber")
  String classNumber;
  @JsonKey(name: "employmentConfirmationEtc")
  String etc;
  @JsonKey(name: "employmentConfirmationIdx")
  int index;
  @JsonKey(name: "employmentConfirmationName")
  String title;
  @JsonKey(name: "employmentConfirmationSite")
  String siteUrl;
  @JsonKey(name: "employmentConfirmationGeneration")
  String generation;
  @JsonKey(name: "studentName")
  String name;
  @JsonKey(name: "employmentConfirmationTags")
  List<String> tag;
  @JsonKey(name: "tagName")
  List<String> postTag;

  ConfirmationVO(
      {this.address,
      this.area,
      this.classNumber,
      this.etc,
      this.index,
      this.title,
      this.siteUrl,
      this.generation,
      this.tag,
      this.postTag,
      this.name});

  factory ConfirmationVO.fromJson(Map<String, dynamic> json) =>
      _$ConfirmationVOFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmationVOToJson(this);
}
