import 'package:app_user/model/comp_notice/comp_status_detail_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_comp_status.g.dart';

@JsonSerializable()
class ResponseCompStatus{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  CompStatusDetailVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;

  ResponseCompStatus({this.code, this.data, this.msg, this.success});

  factory ResponseCompStatus.fromJson(Map<String, dynamic> json) => _$ResponseCompStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCompStatusToJson(this);
}