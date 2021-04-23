import 'package:flutter/cupertino.dart';

class PortfolioVO {
  String user;
  String state;
  String url;

  PortfolioVO({@required this.user, @required this.state, @required this.url});

  @override
  String toString() {
    return 'PortfolioVO{user: $user, state: $state, url: $url}';
  }
}