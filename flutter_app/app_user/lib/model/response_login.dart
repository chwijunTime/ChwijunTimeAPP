import 'package:json_serializable/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'response_login.g.dart';

@JsonSerializable()
class ResponseLogin {
  int code;
  Data data;
  String msg;
  bool success;


  ResponseLogin({this.code, this.data, this.msg, this.success});

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => _$ResponseLoginFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLoginToJson(this);
}