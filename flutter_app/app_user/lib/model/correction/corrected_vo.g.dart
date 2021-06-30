// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corrected_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorrectedVO _$CorrectedVOFromJson(Map<String, dynamic> json) {
  return CorrectedVO(
    classNumber: json['classNumber'] as String,
    applyIndex: json['correctionApplyIdx'] as int,
    content: json['correctionContent'] as String,
    index: json['correctionIdx'] as int,
    status: json['correctionStatus'] as String,
    type: json['correctionType'] as String,
    memberClassNumber: json['memberClassNumber'] as String,
    email: json['memberEmail'] as String,
    portfolioIdx: json['memberPortfolioIdx'] as int,
    resumeIdx: json['memberResumeIdx'] as int,
    portfolioUrl: json['notionPortfolioURL'] as String,
    rejectReason: json['reasonForRejection'] as String,
    resumeUrl: json['resumeFileURL'] as String,
  );
}

Map<String, dynamic> _$CorrectedVOToJson(CorrectedVO instance) =>
    <String, dynamic>{
      'classNumber': instance.classNumber,
      'correctionApplyIdx': instance.applyIndex,
      'correctionContent': instance.content,
      'correctionIdx': instance.index,
      'correctionStatus': instance.status,
      'correctionType': instance.type,
      'memberClassNumber': instance.memberClassNumber,
      'memberEmail': instance.email,
      'memberPortfolioIdx': instance.portfolioIdx,
      'memberResumeIdx': instance.resumeIdx,
      'notionPortfolioURL': instance.portfolioUrl,
      'reasonForRejection': instance.rejectReason,
      'resumeFileURL': instance.resumeUrl,
    };
