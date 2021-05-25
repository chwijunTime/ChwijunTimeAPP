import 'package:app_user/model/notice/notification_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_correction.g.dart';

@JsonSerializable()
class PostCorrectionApproval{
  @JsonKey(name: "classNumber")
  int code;
  @JsonKey(name: 'correctionContent')
  String content;

  PostCorrectionApproval({this.code, this.content});

  factory PostCorrectionApproval.fromJson(Map<String, dynamic> json) => _$PostCorrectionApprovalFromJson(json);

  Map<String, dynamic> toJson() => _$PostCorrectionApprovalToJson(this);
}

@JsonSerializable()
class PostCorrectionReject{
  @JsonKey(name: "classNumber")
  int code;
  @JsonKey(name: 'reasonForRejection')
  String content;

  PostCorrectionReject({this.code, this.content});

  factory PostCorrectionReject.fromJson(Map<String, dynamic> json) => _$PostCorrectionRejectFromJson(json);

  Map<String, dynamic> toJson() => _$PostCorrectionRejectToJson(this);
}