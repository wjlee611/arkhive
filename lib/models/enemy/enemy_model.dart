import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enemy_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createToJson: false,
)
class EnemyModel extends Equatable {
  final String? enemyId;
  final String? enemyIndex;
  final List<String>? enemyTags;
  final int? sortId;
  final String? name;
  final String? enemyRace; // deprecated in CN
  final String? enemyLevel;
  final String? description;
  final String? attackType;
  final String? endure; // deprecated in CN
  final String? attack; // deprecated in CN
  final String? defence; // deprecated in CN
  final String? resistance; // deprecated in CN
  final String? ability;
  final bool? isInvalidKilled;
  final Map<String, dynamic>? overrideKillCntInfos; // "camp_r_03": -1
  final bool? hideInHandbook;
  final List<EnemyAbilityListModel>? abilityList; // CN
  final List<String>? linkEnemies; // CM: enemy id lists
  final List<String>? damageType; // CN: MAGIC, PHYSIC lists
  final bool? invisibleDetail; // CN

  const EnemyModel({
    this.enemyId,
    this.enemyIndex,
    this.enemyTags,
    this.sortId,
    this.name,
    this.enemyRace,
    this.enemyLevel,
    this.description,
    this.attackType,
    this.endure,
    this.attack,
    this.defence,
    this.resistance,
    this.ability,
    this.isInvalidKilled,
    this.overrideKillCntInfos,
    this.hideInHandbook,
    this.abilityList,
    this.linkEnemies,
    this.damageType,
    this.invisibleDetail,
  });

  factory EnemyModel.fromJson(Map<String, dynamic> json) =>
      _$EnemyModelFromJson(json);

  @override
  List<Object?> get props => [
        enemyId,
        enemyIndex,
        enemyTags,
        sortId,
        name,
        enemyRace,
        enemyLevel,
        description,
        attackType,
        endure,
        attack,
        defence,
        resistance,
        ability,
        isInvalidKilled,
        overrideKillCntInfos,
        hideInHandbook,
        abilityList,
        linkEnemies,
        damageType,
        invisibleDetail,
      ];
}

@JsonSerializable()
class EnemyAbilityListModel extends Equatable {
  final String? text;
  final String? textFormat;

  const EnemyAbilityListModel({
    this.text,
    this.textFormat,
  });

  factory EnemyAbilityListModel.fromJson(Map<String, dynamic> json) =>
      _$EnemyAbilityListModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnemyAbilityListModelToJson(this);

  @override
  List<Object?> get props => [
        text,
        textFormat,
      ];
}
