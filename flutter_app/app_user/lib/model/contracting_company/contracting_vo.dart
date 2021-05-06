import 'package:json_annotation/json_annotation.dart';

part 'contracting_vo.g.dart';

@JsonSerializable()
class ContractingVO {
  @JsonKey(name: "contractingBusinessAreas")
  String field;
  @JsonKey(name: "contractingCompanyAboutUs")
  String info;
  @JsonKey(name: "contractingCompanyAddress")
  String address;
  @JsonKey(name: "contractingCompanyAverageAnnualSalary")
  String salary;
  @JsonKey(name: "contractingCompanyIdx")
  int index;
  @JsonKey(name: "contractingCompanyName")
  String title;
  @JsonKey(name: "contractingCompanyTags")
  List<String> tag;
  @JsonKey(name: "tagName")
  List<String> postTag;

  bool isFavorite;


  ContractingVO(
      {this.field,
      this.info,
      this.address,
      this.salary,
      this.index,
      this.title,
      this.tag,
      this.isFavorite,
      this.postTag});

  factory ContractingVO.fromJson(Map<String, dynamic> json) => _$ContractingVOFromJson(json);

  Map<String, dynamic> toJson() => _$ContractingVOToJson(this);
}