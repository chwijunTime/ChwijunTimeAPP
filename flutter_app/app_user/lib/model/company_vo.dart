import 'package:flutter/cupertino.dart';

class CompanyVO {
  String title;
  String info;
  List<String> tag;
  int minSalary;
  int maxSalary;
  bool isFavorite;
  String address;
  String field;

  CompanyVO(
      {@required this.title,
      @required this.info,
      @required this.tag,
      @required this.minSalary,
      @required this.maxSalary,
      @required this.isFavorite,
      @required this.address,
      @required this.field});

  @override
  String toString() {
    return 'CompanyVO{title: $title, info: $info, tag: $tag, minSalary: $minSalary, maxSalary: $maxSalary, isFavorite: $isFavorite, address: $address, field: $field}';
  }
}
