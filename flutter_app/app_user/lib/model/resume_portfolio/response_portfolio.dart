import 'package:app_user/model/resume_portfolio/portfolio_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_portfolio.g.dart';

@JsonSerializable()
class ResponsePortfolio{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "data")
  PortfolioVO data;
  @JsonKey(name: "msg")
  String msg;
  @JsonKey(name: "success")
  bool success;

  ResponsePortfolio({this.code, this.data, this.msg, this.success});

  factory ResponsePortfolio.fromJson(Map<String, dynamic> json) =>
      _$ResponsePortfolioFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePortfolioToJson(this);
}
