// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagTermDescriptionModel _$TagTermDescriptionModelFromJson(
        Map<String, dynamic> json) =>
    TagTermDescriptionModel(
      termId: json['termId'] as String?,
      termName: json['termName'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$TagTermDescriptionModelToJson(
        TagTermDescriptionModel instance) =>
    <String, dynamic>{
      'termId': instance.termId,
      'termName': instance.termName,
      'description': instance.description,
    };
