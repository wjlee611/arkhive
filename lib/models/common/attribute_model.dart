import 'package:arkhive/models/common/attribute_m_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attribute_model.g.dart';

@JsonSerializable()
class AttributeModel extends Equatable {
  final AttributeMModel<int> maxHp;
  final AttributeMModel<int> atk;
  final AttributeMModel<int> def;
  final AttributeMModel<double> magicResistance;
  final AttributeMModel<int> cost;
  final AttributeMModel<int> blockCnt;
  final AttributeMModel<double> moveSpeed;
  final AttributeMModel<double> attackSpeed;
  final AttributeMModel<double> baseAttackTime;
  final AttributeMModel<int> respawnTime;
  final AttributeMModel<double> hpRecoveryPerSec;
  final AttributeMModel<double> spRecoveryPerSec;
  final AttributeMModel<int> maxDeployCount;
  final AttributeMModel<int> massLevel;
  final AttributeMModel<int> baseForceLevel;
  final AttributeMModel<int> tauntLevel;
  final AttributeMModel<double> epDamageResistance; // CN
  final AttributeMModel<double> epResistance; // CN
  final AttributeMModel<bool> stunImmune;
  final AttributeMModel<bool> silenceImmune;
  final AttributeMModel<bool> sleepImmune;
  final AttributeMModel<bool> frozenImmune;
  final AttributeMModel<bool> levitateImmune;

  const AttributeModel({
    required this.maxHp,
    required this.atk,
    required this.def,
    required this.magicResistance,
    required this.cost,
    required this.blockCnt,
    required this.moveSpeed,
    required this.attackSpeed,
    required this.baseAttackTime,
    required this.respawnTime,
    required this.hpRecoveryPerSec,
    required this.spRecoveryPerSec,
    required this.maxDeployCount,
    required this.massLevel,
    required this.baseForceLevel,
    required this.tauntLevel,
    required this.epDamageResistance,
    required this.epResistance,
    required this.stunImmune,
    required this.silenceImmune,
    required this.sleepImmune,
    required this.frozenImmune,
    required this.levitateImmune,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeModelToJson(this);

  AttributeModel copyWith({
    AttributeMModel<int>? maxHp,
    AttributeMModel<int>? atk,
    AttributeMModel<int>? def,
    AttributeMModel<double>? magicResistance,
    AttributeMModel<int>? cost,
    AttributeMModel<int>? blockCnt,
    AttributeMModel<double>? moveSpeed,
    AttributeMModel<double>? attackSpeed,
    AttributeMModel<double>? baseAttackTime,
    AttributeMModel<int>? respawnTime,
    AttributeMModel<double>? hpRecoveryPerSec,
    AttributeMModel<double>? spRecoveryPerSec,
    AttributeMModel<int>? maxDeployCount,
    AttributeMModel<int>? massLevel,
    AttributeMModel<int>? baseForceLevel,
    AttributeMModel<int>? tauntLevel,
    AttributeMModel<double>? epDamageResistance,
    AttributeMModel<double>? epResistance,
    AttributeMModel<bool>? stunImmune,
    AttributeMModel<bool>? silenceImmune,
    AttributeMModel<bool>? sleepImmune,
    AttributeMModel<bool>? frozenImmune,
    AttributeMModel<bool>? levitateImmune,
  }) =>
      AttributeModel(
        maxHp: maxHp ?? this.maxHp,
        atk: atk ?? this.atk,
        def: def ?? this.def,
        magicResistance: magicResistance ?? this.magicResistance,
        cost: cost ?? this.cost,
        blockCnt: blockCnt ?? this.blockCnt,
        moveSpeed: moveSpeed ?? this.moveSpeed,
        attackSpeed: attackSpeed ?? this.attackSpeed,
        baseAttackTime: baseAttackTime ?? this.baseAttackTime,
        respawnTime: respawnTime ?? this.respawnTime,
        hpRecoveryPerSec: hpRecoveryPerSec ?? this.hpRecoveryPerSec,
        spRecoveryPerSec: spRecoveryPerSec ?? this.spRecoveryPerSec,
        maxDeployCount: maxDeployCount ?? this.maxDeployCount,
        massLevel: massLevel ?? this.massLevel,
        baseForceLevel: baseForceLevel ?? this.baseForceLevel,
        tauntLevel: tauntLevel ?? this.tauntLevel,
        epDamageResistance: epDamageResistance ?? this.epDamageResistance,
        epResistance: epResistance ?? this.epResistance,
        stunImmune: stunImmune ?? this.stunImmune,
        silenceImmune: silenceImmune ?? this.silenceImmune,
        sleepImmune: sleepImmune ?? this.sleepImmune,
        frozenImmune: frozenImmune ?? this.frozenImmune,
        levitateImmune: levitateImmune ?? this.levitateImmune,
      );

  @override
  List<Object?> get props => [
        maxHp,
        atk,
        def,
        magicResistance,
        cost,
        blockCnt,
        moveSpeed,
        attackSpeed,
        baseAttackTime,
        respawnTime,
        hpRecoveryPerSec,
        spRecoveryPerSec,
        maxDeployCount,
        massLevel,
        baseForceLevel,
        tauntLevel,
        epDamageResistance,
        epResistance,
        stunImmune,
        silenceImmune,
        sleepImmune,
        frozenImmune,
        levitateImmune,
      ];
}
