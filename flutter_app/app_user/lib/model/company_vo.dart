import 'package:flutter/cupertino.dart';

class CompanyVO {
  String name;
  String content;
  List<String> tag;
  int minSalary;
  int maxSalary;
  bool isFavorite;

  CompanyVO(
      {@required this.name,
      @required this.content,
      @required this.tag,
      @required this.minSalary,
      @required this.maxSalary,
      @required this.isFavorite});
}
