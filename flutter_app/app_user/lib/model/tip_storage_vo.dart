import 'package:flutter/cupertino.dart';

class TipVO {
  String title;
  String address;
  String tip;
  bool isMine;

  TipVO({@required this.title, @required this.address, @required this.tip, this.isMine});
}