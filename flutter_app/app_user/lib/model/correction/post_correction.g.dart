// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_correction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCorrectionApproval _$PostCorrectionApprovalFromJson(
    Map<String, dynamic> json) {
  return PostCorrectionApproval(
    code: json['classNumber'] as int,
    content: json['correctionContent'] as String,
  );
}

Map<String, dynamic> _$PostCorrectionApprovalToJson(
        PostCorrectionApproval instance) =>
    <String, dynamic>{
      'classNumber': instance.code,
      'correctionContent': instance.content,
    };

PostCorrectionReject _$PostCorrectionRejectFromJson(Map<String, dynamic> json) {
  return PostCorrectionReject(
    code: json['classNumber'] as int,
    content: json['reasonForRejection'] as String,
  );
}

Map<String, dynamic> _$PostCorrectionRejectToJson(
        PostCorrectionReject instance) =>
    <String, dynamic>{
      'classNumber': instance.code,
      'reasonForRejection': instance.content,
    };
