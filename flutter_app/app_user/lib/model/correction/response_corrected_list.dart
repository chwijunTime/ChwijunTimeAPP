import 'package:app_user/model/correction/corrected_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_corrected_list.g.dart';

@JsonSerializable()
class ResponseCorrectedList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<CorrectedVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;

  ResponseCorrectedList({this.code, this.list, this.msg, this.success});

  factory ResponseCorrectedList.fromJson(Map<String, dynamic> json) => _$ResponseCorrectedListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCorrectedListToJson(this);
}