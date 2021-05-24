import 'package:app_user/model/resume_portfolio/portfolio_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_portfolio_list.g.dart';

@JsonSerializable()
class ResponsePortfolioList {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "list")
  List<PortfolioVO> list;
  @JsonKey(name: "msg")
  String msg;
  @JsonKey(name: "success")
  bool success;

  ResponsePortfolioList({this.code, this.list, this.msg, this.success});

  factory ResponsePortfolioList.fromJson(Map<String, dynamic> json) =>
      _$ResponsePortfolioListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePortfolioListToJson(this);
}
