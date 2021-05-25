import 'package:json_annotation/json_annotation.dart';

part 'tip_vo.g.dart';

@JsonSerializable()
class TipVO{
  @JsonKey(name: "tagName")
  List<String> tag;
  @JsonKey(name: "tipsInfo")
  String tipInfo;
  @JsonKey(name: "tipsStorageIdx")
  int index;
  @JsonKey(name: "workCompanyAddress")
  String address;
  @JsonKey(name: "workCompanyName")
  String title;


  TipVO({this.tag, this.tipInfo, this.index, this.address, this.title});

  factory TipVO.fromJson(Map<String, dynamic> json) => _$TipVOFromJson(json);

  Map<String, dynamic> toJson() => _$TipVOToJson(this);
}