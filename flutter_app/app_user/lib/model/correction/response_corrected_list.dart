import 'package:app_user/model/correction/correction_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_corrected_list.g.dart';

@JsonSerializable()
class ResponseCorrectedList{
  @JsonKey(name: "classNumber")
  String classNumber;
  @JsonKey(name: "correctionApply")
  CorrectionVO correctionVO;
  @JsonKey(name: "correctionContent")
  String content;
  @JsonKey(name: "correctionIdx")
  int index;
  @JsonKey(name: "reasonForRejection")
  String rejectReason;


  ResponseCorrectedList(
      {this.classNumber,
      this.correctionVO,
      this.content,
      this.index,
      this.rejectReason});

  factory ResponseCorrectedList.fromJson(Map<String, dynamic> json) => _$ResponseCorrectedListFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCorrectedListToJson(this);
}