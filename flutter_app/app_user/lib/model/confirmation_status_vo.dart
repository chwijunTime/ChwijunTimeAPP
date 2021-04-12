import 'package:flutter/cupertino.dart';

class ConfirmationStatusVO{
  String title;
  int grade;
  String area;
  String siteUrl;
  String address;
  String etc;

  ConfirmationStatusVO(
      {@required this.title,
        @required this.grade,
        @required this.area,
      this.siteUrl,
        @required this.address,
      this.etc});
}