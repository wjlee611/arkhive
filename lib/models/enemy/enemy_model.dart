import 'package:arkhive/models/common_models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enemy_model.g.dart';

@JsonSerializable(createToJson: false)
class EnemyModel extends Equatable {
  final String? enemyId,
      enemyIndex,
      name,
      enemyRace,
      enemyLevel,
      attackType,
      endure,
      attack,
      defence,
      resistance,
      ability;
  final List<String>? tags;
  final bool? hideInHandbook;

  const EnemyModel({
    this.enemyId,
    this.enemyIndex,
    this.name,
    this.enemyRace,
    this.enemyLevel,
    this.attackType,
    this.endure,
    this.attack,
    this.defence,
    this.resistance,
    this.ability,
    this.tags,
    this.hideInHandbook,
  });

  factory EnemyModel.fromJson(Map<String, dynamic> json) =>
      _$EnemyModelFromJson(json);

  @override
  List<Object?> get props => [
        enemyId,
        enemyIndex,
        name,
        enemyRace,
        enemyLevel,
        attackType,
        endure,
        attack,
        defence,
        resistance,
        ability,
        tags,
        hideInHandbook,
      ];
}

class EnemyDataModel {
  final List<EnemyValueDataModel>? values;

  EnemyDataModel.fromJson(Map<String, dynamic> json)
      : values = [
          if (json['Value'] != null)
            for (var data in json['Value']) EnemyValueDataModel.fromJson(data)
        ];
}

class EnemyValueDataModel {
  final EnemyAttrDataModel? attributes;
  final List<BlackboardModel>? talentBlackboard;

  EnemyValueDataModel.fromJson(Map<String, dynamic> json)
      : attributes =
            EnemyAttrDataModel.fromJson(json['enemyData']?['attributes']),
        talentBlackboard = [
          if (json['enemyData']?['talentBlackboard'] != null)
            for (var data in json['enemyData']['talentBlackboard'])
              BlackboardModel.fromJson(data)
        ];
}

class EnemyAttrDataModel {
  EnemyAttrValueDataModel<int>? maxHp, atk, def, massLevel;
  EnemyAttrValueDataModel<double>? magicResistance,
      moveSpeed,
      attackSpeed,
      baseAttackTime;
  EnemyAttrValueDataModel<bool>? stunImmune,
      silenceImmune,
      sleepImmune,
      frozenImmune,
      levitateImmune;

  EnemyAttrDataModel({
    this.maxHp,
    this.atk,
    this.def,
    this.massLevel,
    this.magicResistance,
    this.moveSpeed,
    this.attackSpeed,
    this.baseAttackTime,
    this.stunImmune,
    this.silenceImmune,
    this.sleepImmune,
    this.frozenImmune,
    this.levitateImmune,
  });

  EnemyAttrDataModel.copy(EnemyAttrDataModel obj)
      : this(
          maxHp: obj.maxHp,
          atk: obj.atk,
          def: obj.def,
          massLevel: obj.massLevel,
          magicResistance: obj.magicResistance,
          moveSpeed: obj.moveSpeed,
          attackSpeed: obj.attackSpeed,
          baseAttackTime: obj.baseAttackTime,
          stunImmune: obj.stunImmune,
          silenceImmune: obj.silenceImmune,
          sleepImmune: obj.sleepImmune,
          frozenImmune: obj.frozenImmune,
          levitateImmune: obj.levitateImmune,
        );

  EnemyAttrDataModel.fromJson(Map<String, dynamic> json)
      : maxHp = EnemyAttrValueDataModel.fromJson(json['maxHp']),
        atk = EnemyAttrValueDataModel.fromJson(json['atk']),
        def = EnemyAttrValueDataModel.fromJson(json['def']),
        magicResistance =
            EnemyAttrValueDataModel.fromJson(json['magicResistance']),
        massLevel = EnemyAttrValueDataModel.fromJson(json['massLevel']),
        moveSpeed = EnemyAttrValueDataModel.fromJson(json['moveSpeed']),
        attackSpeed = EnemyAttrValueDataModel.fromJson(json['attackSpeed']),
        baseAttackTime =
            EnemyAttrValueDataModel.fromJson(json['baseAttackTime']),
        stunImmune = EnemyAttrValueDataModel.fromJson(json['stunImmune']),
        silenceImmune = EnemyAttrValueDataModel.fromJson(json['silenceImmune']),
        sleepImmune = EnemyAttrValueDataModel.fromJson(json['sleepImmune']),
        frozenImmune = EnemyAttrValueDataModel.fromJson(json['frozenImmune']),
        levitateImmune =
            EnemyAttrValueDataModel.fromJson(json['levitateImmune']);

  void copyWith({
    EnemyAttrValueDataModel<int>? maxHp,
    atk,
    def,
    massLevel,
    EnemyAttrValueDataModel<double>? magicResistance,
    moveSpeed,
    attackSpeed,
    baseAttackTime,
    EnemyAttrValueDataModel<bool>? stunImmune,
    silenceImmune,
    sleepImmune,
    frozenImmune,
    levitateImmune,
  }) {
    this.maxHp = maxHp ?? this.maxHp;
    this.atk = atk ?? this.atk;
    this.def = def ?? this.def;
    this.massLevel = massLevel ?? this.massLevel;
    this.magicResistance = magicResistance ?? this.magicResistance;
    this.moveSpeed = moveSpeed ?? this.moveSpeed;
    this.attackSpeed = attackSpeed ?? this.attackSpeed;
    this.baseAttackTime = baseAttackTime ?? this.baseAttackTime;
    this.stunImmune = stunImmune ?? this.stunImmune;
    this.silenceImmune = silenceImmune ?? this.silenceImmune;
    this.sleepImmune = sleepImmune ?? this.sleepImmune;
    this.frozenImmune = frozenImmune ?? this.frozenImmune;
    this.levitateImmune = levitateImmune ?? this.levitateImmune;
  }
}

class EnemyAttrValueDataModel<T> {
  final bool? isDefined;
  final T? value;

  EnemyAttrValueDataModel.fromJson(Map<String, dynamic> json)
      : isDefined = json['m_defined'],
        value = json['m_value'];
}
