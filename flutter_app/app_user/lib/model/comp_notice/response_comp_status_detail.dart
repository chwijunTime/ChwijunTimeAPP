import 'package:app_user/model/comp_notice/comp_status_detail_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_comp_status_detail.g.dart';

@JsonSerializable()
class ResponseCompStatusDetail{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  CompStatusDetailVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;

  ResponseCompStatusDetail({this.code, this.data, this.msg, this.success});

  factory ResponseCompStatusDetail.fromJson(Map<String, dynamic> json) => _$ResponseCompStatusDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCompStatusDetailToJson(this);
}