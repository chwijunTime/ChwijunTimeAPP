// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewVO _$ReviewVOFromJson(Map<String, dynamic> json) {
  return ReviewVO(
    address: json['companyAddress'] as String,
    price: json['companyCost'] as int,
    applyDate: json['companyDateofApplication'] as String,
    question: json['companyFrequentlyAskedQuestions'] as String,
    title: json['companyName'] as String,
    index: json['companyReviewIdx'] as int,
    tag: (json['companyReviewTags'] as List)?.map((e) => e as String)?.toList(),
    postTag: (json['tagName'] as List)?.map((e) => e as String)?.toList(),
    review: json['companyReviews'] as String,
  );
}

Map<String, dynamic> _$ReviewVOToJson(ReviewVO instance) => <String, dynamic>{
      'companyAddress': instance.address,
      'companyCost': instance.price,
      'companyDateofApplication': instance.applyDate,
      'companyFrequentlyAskedQuestions': instance.question,
      'companyName': instance.title,
      'companyReviewIdx': instance.index,
      'companyReviewTags': instance.tag,
      'tagName': instance.postTag,
      'companyReviews': instance.review,
    };
