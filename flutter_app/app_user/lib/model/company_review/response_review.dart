import 'package:app_user/model/company_review/review_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_review.g.dart';

@JsonSerializable()
class ResponseReview{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  List<ReviewVO> data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseReview({this.code, this.data, this.msg, this.success});

  factory ResponseReview.fromJson(Map<String, dynamic> json) => _$ResponseReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseReviewToJson(this);
}