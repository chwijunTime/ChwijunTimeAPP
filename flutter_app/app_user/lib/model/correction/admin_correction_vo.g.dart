// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_correction_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminCorrectionVO _$AdminCorrectionVOFromJson(Map<String, dynamic> json) {
  return AdminCorrectionVO(
    index: json['correctionApplyIdx'] as int,
    status: json['correctionStatus'] as String,
    type: json['correctionType'] as String,
    member: json['member'] == null
        ? null
        : UserInfoVO.fromJson(json['member'] as Map<String, dynamic>),
    portfolio: json['memberPortfolio'] == null
        ? null
        : PortfolioVO.fromJson(json['memberPortfolio'] as Map<String, dynamic>),
    resume: json['memberResume'] == null
        ? null
        : ResumeVO.fromJson(json['memberResume'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AdminCorrectionVOToJson(AdminCorrectionVO instance) =>
    <String, dynamic>{
      'correctionApplyIdx': instance.index,
      'correctionStatus': instance.status,
      'correctionType': instance.type,
      'member': instance.member,
      'memberPortfolio': instance.portfolio,
      'memberResume': instance.resume,
    };
