import 'package:app_user/model/company_review/review_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_review_list.g.dart';

@JsonSerializable()
class ResponseReviewList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<ReviewVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseReviewList({this.code, this.list, this.msg, this.success});

  factory ResponseReviewList.fromJson(Map<String, dynamic> json) => _$ResponseReviewListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseReviewListToJson(this);
}