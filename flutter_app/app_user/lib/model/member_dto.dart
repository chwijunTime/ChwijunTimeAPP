import 'package:json_annotation/json_annotation.dart';

part 'member_dto.g.dart';

@JsonSerializable()
class MemberDTO{
  @JsonKey(name: "memberClassNumber")
  String memberClassNumber;
  @JsonKey(name: "memberEmail")
  String memberEmail;
  @JsonKey(name: "memberPassword")
  String memberPassword;

  MemberDTO({this.memberClassNumber, this.memberEmail, this.memberPassword});

  factory MemberDTO.fromJson(Map<String, dynamic> json) => _$MemberDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MemberDTOToJson(this);
}