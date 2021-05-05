import 'package:json_annotation/json_annotation.dart';

part 'tag_vo.g.dart';

@JsonSerializable()
class TagVO {
  @JsonKey(name: "tagIdx")
  int index;
  @JsonKey(name: "tagName")
  String name;


  TagVO({this.index, this.name});

  factory TagVO.fromJson(Map<String, dynamic> json) => _$TagVOFromJson(json);

  Map<String, dynamic> toJson() => _$TagVOToJson(this);
}