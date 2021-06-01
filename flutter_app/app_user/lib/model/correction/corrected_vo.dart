import 'package:app_user/model/correction/correction_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'corrected_vo.g.dart';

@JsonSerializable()
class CorrectedVO{
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


  CorrectedVO(
      {this.classNumber,
      this.correctionVO,
      this.content,
      this.index,
      this.rejectReason});

  factory CorrectedVO.fromJson(Map<String, dynamic> json) => _$CorrectedVOFromJson(json);

  Map<String, dynamic> toJson() => _$CorrectedVOToJson(this);
}