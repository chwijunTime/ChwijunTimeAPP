import 'package:app_user/model/contracting_company/contracting_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_contracting_list.g.dart';

@JsonSerializable()
class ResponseContractingList {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'list')
  List<ContractingVO> list;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseContractingList({this.code, this.list, this.msg, this.success});

  factory ResponseContractingList.fromJson(Map<String, dynamic> json) => _$ResponseContractingListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseContractingListToJson(this);
}