// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_blackboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentBlackboardModel _$TalentBlackboardModelFromJson(
        Map<String, dynamic> json) =>
    TalentBlackboardModel(
      key: json['key'] as String,
      value: (json['value'] as num?)?.toDouble(),
      valueStr: json['valueStr'] as String?,
    );

Map<String, dynamic> _$TalentBlackboardModelToJson(
        TalentBlackboardModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'valueStr': instance.valueStr,
    };
