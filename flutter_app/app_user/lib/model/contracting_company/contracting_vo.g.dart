// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contracting_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractingVO _$ContractingVOFromJson(Map<String, dynamic> json) {
  return ContractingVO(
    field: json['contractingBusinessAreas'] as String,
    info: json['contractingCompanyAboutUs'] as String,
    address: json['contractingCompanyAddress'] as String,
    salary: json['contractingCompanyAverageAnnualSalary'] as String,
    index: json['contractingCompanyIdx'] as int,
    title: json['contractingCompanyName'] as String,
    tag: (json['contractingCompanyTags'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    isFavorite: json['isFavorite'] as bool,
    postTag: (json['tagName'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ContractingVOToJson(ContractingVO instance) =>
    <String, dynamic>{
      'contractingBusinessAreas': instance.field,
      'contractingCompanyAboutUs': instance.info,
      'contractingCompanyAddress': instance.address,
      'contractingCompanyAverageAnnualSalary': instance.salary,
      'contractingCompanyIdx': instance.index,
      'contractingCompanyName': instance.title,
      'contractingCompanyTags': instance.tag,
      'tagName': instance.postTag,
      'isFavorite': instance.isFavorite,
    };
