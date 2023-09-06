import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enemy_class_level_model.g.dart';

@JsonSerializable(createToJson: false)
class EnemyClassLevelModel extends Equatable {
  final String classLevel;
  final EnemyClassLevelBoundModel attack;
  final EnemyClassLevelBoundModel def;
  final EnemyClassLevelBoundModel magicRes;
  final EnemyClassLevelBoundModel maxHP;
  final EnemyClassLevelBoundModel moveSpeed;
  final EnemyClassLevelBoundModel attackSpeed;
  final EnemyClassLevelBoundModel enemyDamageRes;
  final EnemyClassLevelBoundModel enemyRes;

  const EnemyClassLevelModel({
    required this.classLevel,
    required this.attack,
    required this.def,
    required this.magicRes,
    required this.maxHP,
    required this.moveSpeed,
    required this.attackSpeed,
    required this.enemyDamageRes,
    required this.enemyRes,
  });

  factory EnemyClassLevelModel.fromJson(Map<String, dynamic> json) =>
      _$EnemyClassLevelModelFromJson(json);

  @override
  List<Object?> get props => [
        classLevel,
        attack,
        def,
        magicRes,
        maxHP,
        moveSpeed,
        attackSpeed,
        enemyDamageRes,
        enemyRes,
      ];
}

@JsonSerializable(createToJson: false)
class EnemyClassLevelBoundModel extends Equatable {
  final double min;
  final double max;

  const EnemyClassLevelBoundModel({
    required this.min,
    required this.max,
  });

  factory EnemyClassLevelBoundModel.fromJson(Map<String, dynamic> json) =>
      _$EnemyClassLevelBoundModelFromJson(json);

  @override
  List<Object?> get props => [
        min,
        max,
      ];
}
