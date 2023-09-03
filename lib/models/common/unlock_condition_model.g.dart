// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlock_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnlockConditionModel _$UnlockConditionModelFromJson(
        Map<String, dynamic> json) =>
    UnlockConditionModel(
      phase: UnlockConditionModel._fromJsonToString(json['phase']),
      level: json['level'] as int,
    );

Map<String, dynamic> _$UnlockConditionModelToJson(
        UnlockConditionModel instance) =>
    <String, dynamic>{
      'phase': instance.phase,
      'level': instance.level,
    };
