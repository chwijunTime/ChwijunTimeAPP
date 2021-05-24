import 'package:json_annotation/json_annotation.dart';

part 'post_apply_vo.g.dart';

@JsonSerializable()
class PostApplyVO{
  @JsonKey(name: "applicationEmploymentPortfolioURL")
  String portfolioURL;
  @JsonKey(name: "applicationEmploymentResumeURL")
  String resumeURL;
  @JsonKey(name: "gitHubURL")
  String gitHubURL;

  PostApplyVO({this.portfolioURL, this.resumeURL, this.gitHubURL});

  factory PostApplyVO.fromJson(Map<String, dynamic> json) => _$PostApplyVOFromJson(json);

  Map<String, dynamic> toJson() => _$PostApplyVOToJson(this);
}