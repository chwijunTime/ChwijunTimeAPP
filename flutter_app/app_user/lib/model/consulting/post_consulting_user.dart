import 'package:json_annotation/json_annotation.dart';

part 'post_consulting_user.g.dart';

@JsonSerializable()
class PostConsultingUser{
  @JsonKey(name: "classNumber")
  String classNumber;
  @JsonKey(name: "name")
  String name;

  PostConsultingUser({this.classNumber, this.name});

  factory PostConsultingUser.fromJson(Map<String, dynamic> json) => _$PostConsultingUserFromJson(json);

  Map<String, dynamic> toJson() => _$PostConsultingUserToJson(this);
}