// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correction_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorrectionVO _$CorrectionVOFromJson(Map<String, dynamic> json) {
  return CorrectionVO(
    index: json['correctionApplyIdx'] as int,
    status: json['correctionStatus'] as String,
    type: json['correctionType'] as String,
    classNumber: json['memberClassNumber'] as String,
    email: json['memberEmail'] as String,
    portfolioIdx: json['memberPortfolioIdx'] as int,
    resumeIdx: json['memberResumeIdx'] as int,
    portfolioUrl: json['notionPortfolioURL'] as String,
    resumeUrl: json['resumeFileURL'] as String,
  );
}

Map<String, dynamic> _$CorrectionVOToJson(CorrectionVO instance) =>
    <String, dynamic>{
      'correctionApplyIdx': instance.index,
      'correctionStatus': instance.status,
      'correctionType': instance.type,
      'memberClassNumber': instance.classNumber,
      'memberEmail': instance.email,
      'memberPortfolioIdx': instance.portfolioIdx,
      'memberResumeIdx': instance.resumeIdx,
      'notionPortfolioURL': instance.portfolioUrl,
      'resumeFileURL': instance.resumeUrl,
    };
