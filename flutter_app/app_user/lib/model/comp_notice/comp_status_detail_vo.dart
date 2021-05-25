import 'package:app_user/model/comp_notice/apply_employment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comp_status_detail_vo.g.dart';

@JsonSerializable()
class CompStatusDetailVO{
  @JsonKey(name: "applicationEmployment")
  ApplyEmployment data;

  CompStatusDetailVO({this.data});

  factory CompStatusDetailVO.fromJson(Map<String, dynamic> json) => _$CompStatusDetailVOFromJson(json);

  Map<String, dynamic> toJson() => _$CompStatusDetailVOToJson(this);
}