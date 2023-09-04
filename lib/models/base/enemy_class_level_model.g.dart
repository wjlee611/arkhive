// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enemy_class_level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnemyClassLevelModel _$EnemyClassLevelModelFromJson(
        Map<String, dynamic> json) =>
    EnemyClassLevelModel(
      classLevel: json['classLevel'] as String,
      attack: EnemyClassLevelBoundModel.fromJson(
          json['attack'] as Map<String, dynamic>),
      def: EnemyClassLevelBoundModel.fromJson(
          json['def'] as Map<String, dynamic>),
      magicRes: EnemyClassLevelBoundModel.fromJson(
          json['magicRes'] as Map<String, dynamic>),
      maxHP: EnemyClassLevelBoundModel.fromJson(
          json['maxHP'] as Map<String, dynamic>),
      moveSpeed: EnemyClassLevelBoundModel.fromJson(
          json['moveSpeed'] as Map<String, dynamic>),
      attackSpeed: EnemyClassLevelBoundModel.fromJson(
          json['attackSpeed'] as Map<String, dynamic>),
      enemyDamageRes: EnemyClassLevelBoundModel.fromJson(
          json['enemyDamageRes'] as Map<String, dynamic>),
      enemyRes: EnemyClassLevelBoundModel.fromJson(
          json['enemyRes'] as Map<String, dynamic>),
    );

EnemyClassLevelBoundModel _$EnemyClassLevelBoundModelFromJson(
        Map<String, dynamic> json) =>
    EnemyClassLevelBoundModel(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
    );
