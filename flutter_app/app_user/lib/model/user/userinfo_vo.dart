import 'package:json_annotation/json_annotation.dart';

part 'userinfo_vo.g.dart';

@JsonSerializable()
class UserInfoVO{
  @JsonKey(name: "createdDate")
  String createDate;
  @JsonKey(name: "memberClassNumber")
  String classNumber;
  @JsonKey(name: "memberCreated")
  String memberCreatedDate;
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
  List<String> roles;

  UserInfoVO(
      {this.createDate,
      this.classNumber,
      this.memberCreatedDate,
      this.etc,
      this.email,
      this.index,
      this.phone,
      this.modifyDate,
      this.roles});

  factory UserInfoVO.fromJson(Map<String, dynamic> json) => _$UserInfoVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoVOToJson(this);
}