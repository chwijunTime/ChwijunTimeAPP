import 'package:json_serializable/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class Response1 {
  int code;
  String msg;
  bool success;


  Response1({this.code, this.msg, this.success});

  factory Response1.fromJson(Map<String, dynamic> json) => _$Response1FromJson(json);

  Map<String, dynamic> toJson() => _$Response1ToJson(this);
}