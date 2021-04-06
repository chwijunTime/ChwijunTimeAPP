import 'package:json_annotation/json_annotation.dart';

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

@JsonSerializable()
class Data {
  String accessToken;
  String memberClassNumber;
  String memberEmail;
  String roles;


  Data({this.accessToken, this.memberClassNumber, this.memberEmail, this.roles});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}