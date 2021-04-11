import 'package:flutter/material.dart';

class NotificationVO {
  String title;
  String content;
  String date;
  bool isFavorite;
  List<String> tag;

  NotificationVO(
      {@required this.title,
      @required this.content,
      @required this.date,
      @required this.isFavorite,
      @required this.tag});
}
