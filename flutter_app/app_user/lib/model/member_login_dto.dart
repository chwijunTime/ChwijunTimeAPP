import 'package:json_annotation/json_annotation.dart';

part 'member_login_dto.g.dart';

@JsonSerializable()
class MemberLoginDTO{
  String memberEmail;
  String memberPassword;

  MemberLoginDTO({this.memberEmail, this.memberPassword});

  factory MemberLoginDTO.fromJson(Map<String, dynamic> json) => _$MemberLoginDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MemberLoginDTOToJson(this);
}