import 'package:json_annotation/json_annotation.dart';

part 'member_dto.g.dart';

@JsonSerializable()
class MemberDTO{
  String memberClassNumber;
  String memberEmail;
  String memberPassword;

  MemberDTO({this.memberClassNumber, this.memberEmail, this.memberPassword});

  factory MemberDTO.fromJson(Map<String, dynamic> json) => _$MemberDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MemberDTOToJson(this);
}