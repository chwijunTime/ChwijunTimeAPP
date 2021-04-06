import 'package:json_serializable/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

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