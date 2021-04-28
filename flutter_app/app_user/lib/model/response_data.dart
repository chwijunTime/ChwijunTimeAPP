import 'package:json_annotation/json_annotation.dart';

part 'response_data.g.dart';

@JsonSerializable()
class ResponseData {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "msg")
  String msg;
  @JsonKey(name: "success")
  bool success;


  ResponseData({this.code, this.msg, this.success});

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}