import 'package:app_user/model/correction/correction_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_correction_list.g.dart';

@JsonSerializable()
class ResponseCorrectionList{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<CorrectionVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;
  
  ResponseCorrectionList({this.code, this.list, this.msg, this.success});

  factory ResponseCorrectionList.fromJson(Map<String, dynamic> json) => _$ResponseCorrectionListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCorrectionListToJson(this);
}