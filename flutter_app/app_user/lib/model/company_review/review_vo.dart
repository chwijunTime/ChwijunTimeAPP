import 'package:json_annotation/json_annotation.dart';

part 'review_vo.g.dart';

@JsonSerializable()
class ReviewVO {
  @JsonKey(name: "companyAddress")
  String address;
  @JsonKey(name: "companyCost")
  int price;
  @JsonKey(name: "companyDateofApplication")
  String applyDate;
  @JsonKey(name: "companyFrequentlyAskedQuestions")
  String question;
  @JsonKey(name: "companyName")
  String title;
  @JsonKey(name: "companyReviewIdx")
  int index;
  @JsonKey(name: "companyReviewTags")
  List<String> tag;
  @JsonKey(name: "companyReviews")
  String review;

  bool isFavorite;
  bool isMine;

  ReviewVO(
      {this.address,
      this.price,
      this.applyDate,
      this.question,
      this.title,
      this.index,
      this.tag,
      this.review,
      this.isFavorite,
      this.isMine});

  factory ReviewVO.fromJson(Map<String, dynamic> json) => _$ReviewVOFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewVOToJson(this);
}