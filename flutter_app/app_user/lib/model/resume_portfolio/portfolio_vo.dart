import 'package:app_user/model/user/userinfo_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'portfolio_vo.g.dart';

@JsonSerializable()
class PortfolioVO {
  @JsonKey(name: "member")
  UserInfoVO member;
  @JsonKey(name: "memberPortfolioIdx")
  int index;
  @JsonKey(name: "notionPortfolioURL")
  String portfolioUrl;

  PortfolioVO(
      {this.member, this.index, this.portfolioUrl});

  factory PortfolioVO.fromJson(Map<String, dynamic> json) => _$PortfolioVOFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioVOToJson(this);
}