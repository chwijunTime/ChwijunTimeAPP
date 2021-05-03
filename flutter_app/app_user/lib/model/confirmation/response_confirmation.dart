import 'package:app_user/model/confirmation/confirmation_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_confirmation.g.dart';

@JsonSerializable()
class ResponseConfirmation {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  ConfirmationVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseConfirmation({this.code, this.data, this.msg, this.success});

  factory ResponseConfirmation.fromJson(Map<String, dynamic> json) => _$ResponseConfirmationFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseConfirmationToJson(this);
}