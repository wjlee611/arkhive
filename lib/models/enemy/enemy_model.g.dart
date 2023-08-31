// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enemy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnemyModel _$EnemyModelFromJson(Map<String, dynamic> json) => EnemyModel(
      enemyId: json['enemyId'] as String?,
      enemyIndex: json['enemyIndex'] as String?,
      name: json['name'] as String?,
      enemyRace: json['enemyRace'] as String?,
      enemyLevel: json['enemyLevel'] as String?,
      attackType: json['attackType'] as String?,
      endure: json['endure'] as String?,
      attack: json['attack'] as String?,
      defence: json['defence'] as String?,
      resistance: json['resistance'] as String?,
      ability: json['ability'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      hideInHandbook: json['hideInHandbook'] as bool?,
    );
