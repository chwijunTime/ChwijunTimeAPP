import 'package:flutter/cupertino.dart';

class CounselingVO {
  String date;
  String time;
  String place;
  String reason;
  String user;
  List<String> tag;

  CounselingVO(
      {@required this.date,
      @required this.time,
      @required this.place,
      this.reason,
      @required this.tag,
      this.user});

  @override
  String toString() {
    return 'CounselingVO{date: $date, time: $time, place: $place, reason: $reason, tag: $tag}';
  }
}
