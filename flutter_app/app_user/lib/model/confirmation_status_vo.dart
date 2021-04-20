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

  @override
  String toString() {
    return 'ConfirmationStatusVO{title: $title, grade: $grade, area: $area, siteUrl: $siteUrl, address: $address, etc: $etc}';
  }
}