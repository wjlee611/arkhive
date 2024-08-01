// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enemy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnemyModel _$EnemyModelFromJson(Map<String, dynamic> json) => EnemyModel(
      enemyId: json['enemyId'] as String?,
      enemyIndex: json['enemyIndex'] as String?,
      enemyTags: (json['enemyTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sortId: (json['sortId'] as num?)?.toInt(),
      name: json['name'] as String?,
      enemyRace: json['enemyRace'] as String?,
      enemyLevel: json['enemyLevel'] as String?,
      description: json['description'] as String?,
      attackType: json['attackType'] as String?,
      endure: json['endure'] as String?,
      attack: json['attack'] as String?,
      defence: json['defence'] as String?,
      resistance: json['resistance'] as String?,
      ability: json['ability'] as String?,
      isInvalidKilled: json['isInvalidKilled'] as bool?,
      overrideKillCntInfos:
          json['overrideKillCntInfos'] as Map<String, dynamic>?,
      hideInHandbook: json['hideInHandbook'] as bool?,
      abilityList: (json['abilityList'] as List<dynamic>?)
          ?.map(
              (e) => EnemyAbilityListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      linkEnemies: (json['linkEnemies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      damageType: (json['damageType'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      invisibleDetail: json['invisibleDetail'] as bool?,
    );

EnemyAbilityListModel _$EnemyAbilityListModelFromJson(
        Map<String, dynamic> json) =>
    EnemyAbilityListModel(
      text: json['text'] as String?,
      textFormat: json['textFormat'] as String?,
    );

Map<String, dynamic> _$EnemyAbilityListModelToJson(
        EnemyAbilityListModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'textFormat': instance.textFormat,
    };
