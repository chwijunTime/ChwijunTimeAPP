import 'package:flutter/cupertino.dart';

class ReviewVO {
  String title;
  int grade;
  String applyDate;
  String address;
  int price;
  String review;
  String question;
  List<String> tag;
  bool isFavorite;
  bool isMine;

  ReviewVO(
      {@required this.title,
      @required this.grade,
      @required this.applyDate,
      @required this.address,
      @required this.price,
      @required this.review,
      @required this.question,
      @required this.tag,
      @required this.isFavorite,
      @required this.isMine});
}
