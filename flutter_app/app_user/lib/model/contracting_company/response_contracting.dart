import 'package:app_user/model/contracting_company/contracting_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_contracting.g.dart';

@JsonSerializable()
class ResponseContracting {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  ContractingVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseContracting({this.code, this.data, this.msg, this.success});

  factory ResponseContracting.fromJson(Map<String, dynamic> json) => _$ResponseContractingFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseContractingToJson(this);
}