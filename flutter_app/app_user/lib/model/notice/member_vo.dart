import 'package:json_annotation/json_annotation.dart';

part 'member_vo.g.dart';

@JsonSerializable()
class MemberVO{
  @JsonKey(name: "createdDate")
  String date;
  @JsonKey(name: "memberClassNumber")
  String classNumber;
  @JsonKey(name: "memberCreated")
  String memberDate;
  @JsonKey(name: "memberETC")
  String etc;
  @JsonKey(name: "memberEmail")
  String email;
  @JsonKey(name: "memberIdx")
  int index;
  @JsonKey(name: "memberPhoneNumber")
  String phone;
  @JsonKey(name: "modifiedDate")
  String modifyDate;
  @JsonKey(name: "roles")
  List<String> role;

  MemberVO(
      {this.date,
      this.classNumber,
      this.memberDate,
      this.etc,
      this.email,
      this.index,
      this.phone,
      this.modifyDate,
      this.role});

  factory MemberVO.fromJson(Map<String, dynamic> json) => _$MemberVOFromJson(json);

  Map<String, dynamic> toJson() => _$MemberVOToJson(this);
}