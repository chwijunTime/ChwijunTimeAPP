import 'package:flutter/cupertino.dart';

class ApplyVO {
  String user;
  String portfolio;
  String introduction;
  String status;

  ApplyVO(
      {@required this.user,
      @required this.portfolio,
      @required this.introduction,
      @required this.status});

  @override
  String toString() {
    return 'ApplyVO{user: $user, portfolio: $portfolio, introduction: $introduction, status: $status}';
  }
}
