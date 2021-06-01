// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corrected_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorrectedVO _$CorrectedVOFromJson(Map<String, dynamic> json) {
  return CorrectedVO(
    classNumber: json['classNumber'] as String,
    correctionVO: json['correctionApply'] == null
        ? null
        : CorrectionVO.fromJson(
            json['correctionApply'] as Map<String, dynamic>),
    content: json['correctionContent'] as String,
    index: json['correctionIdx'] as int,
    rejectReason: json['reasonForRejection'] as String,
  );
}

Map<String, dynamic> _$CorrectedVOToJson(CorrectedVO instance) =>
    <String, dynamic>{
      'classNumber': instance.classNumber,
      'correctionApply': instance.correctionVO,
      'correctionContent': instance.content,
      'correctionIdx': instance.index,
      'reasonForRejection': instance.rejectReason,
    };
