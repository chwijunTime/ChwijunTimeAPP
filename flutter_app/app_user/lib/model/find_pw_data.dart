import 'package:json_annotation/json_annotation.dart';

part 'find_pw_data.g.dart';

@JsonSerializable()
class FindPWData{
  @JsonKey(name: "additionalProp1")
  bool prop1;
  @JsonKey(name: "additionalProp2")
  bool prop2;
  @JsonKey(name: "additionalProp3")
  bool prop3;

  FindPWData({this.prop1, this.prop2, this.prop3});

  factory FindPWData.fromJson(Map<String, dynamic> json) => _$FindPWDataFromJson(json);

  Map<String, dynamic> toJson() => _$FindPWDataToJson(this);
}