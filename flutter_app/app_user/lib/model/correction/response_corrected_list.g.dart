// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_corrected_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCorrectedList _$ResponseCorrectedListFromJson(
    Map<String, dynamic> json) {
  return ResponseCorrectedList(
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

Map<String, dynamic> _$ResponseCorrectedListToJson(
        ResponseCorrectedList instance) =>
    <String, dynamic>{
      'classNumber': instance.classNumber,
      'correctionApply': instance.correctionVO,
      'correctionContent': instance.content,
      'correctionIdx': instance.index,
      'reasonForRejection': instance.rejectReason,
    };
