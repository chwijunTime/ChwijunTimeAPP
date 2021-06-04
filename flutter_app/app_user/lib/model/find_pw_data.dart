import 'package:json_annotation/json_annotation.dart';

part 'find_pw_data.g.dart';

@JsonSerializable()
class FindPWData{
  @JsonKey(name: "check")
  bool prop1;

  FindPWData({this.prop1});

  factory FindPWData.fromJson(Map<String, dynamic> json) => _$FindPWDataFromJson(json);

  Map<String, dynamic> toJson() => _$FindPWDataToJson(this);
}