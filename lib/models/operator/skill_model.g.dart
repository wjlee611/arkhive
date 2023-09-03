// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillModel _$SkillModelFromJson(Map<String, dynamic> json) => SkillModel(
      skillId: json['skillId'] as String?,
      iconId: json['iconId'] as String?,
      hidden: json['hidden'] as bool?,
      levels: (json['levels'] as List<dynamic>?)
          ?.map((e) => SkillLevelsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SkillLevelsModel _$SkillLevelsModelFromJson(Map<String, dynamic> json) =>
    SkillLevelsModel(
      name: json['name'] as String?,
      rangeId: json['rangeId'] as String?,
      description: json['description'] as String?,
      skillType: fromJsonToString(json['skillType']),
      durationType: fromJsonToString(json['durationType']),
      spData: json['spData'] == null
          ? null
          : SkillSpDataModel.fromJson(json['spData'] as Map<String, dynamic>),
      prefabId: json['prefabId'] as String?,
      duration: (json['duration'] as num?)?.toDouble(),
      blackboard: (json['blackboard'] as List<dynamic>?)
          ?.map(
              (e) => TalentBlackboardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SkillSpDataModel _$SkillSpDataModelFromJson(Map<String, dynamic> json) =>
    SkillSpDataModel(
      spType: fromJsonToString(json['spType']),
      levelUpCost: json['levelUpCost'] as String?,
      maxChargeTime: json['maxChargeTime'] as String?,
      spCost: json['spCost'] as String?,
      initSp: json['initSp'] as String?,
      increment: json['increment'] as String?,
    );
