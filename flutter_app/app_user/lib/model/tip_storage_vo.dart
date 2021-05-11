import 'package:flutter/cupertino.dart';

class TipVO {
  String title;
  String address;
  String tip;
  bool isMine;
  int index;

  TipVO(
      {@required this.title,
      @required this.address,
      @required this.tip,
      this.isMine,
      this.index});
}
