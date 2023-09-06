import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keyframe_data_model.g.dart';

@JsonSerializable()
class KeyFrameDataModel extends Equatable {
  final int? maxHp;
  final int? atk;
  final int? def;
  final double? magicResistance;
  final int? cost;
  final int? blockCnt;
  final double? moveSpeed;
  final double? attackSpeed;
  final double? baseAttackTime;
  final int? respawnTime;
  final double? hpRecoveryPerSec;
  final double? spRecoveryPerSec;
  final int? maxDeployCount;
  final int? massLevel;
  final int? baseForceLevel;
  final int? tauntLevel;
  final double? epDamageResistance; // CN
  final double? epResistance; // CN
  final bool? stunImmune;
  final bool? silenceImmune;
  final bool? sleepImmune;
  final bool? frozenImmune;
  final bool? levitateImmune;

  const KeyFrameDataModel({
    this.maxHp,
    this.atk,
    this.def,
    this.magicResistance,
    this.cost,
    this.blockCnt,
    this.moveSpeed,
    this.attackSpeed,
    this.baseAttackTime,
    this.respawnTime,
    this.hpRecoveryPerSec,
    this.spRecoveryPerSec,
    this.maxDeployCount,
    this.massLevel,
    this.baseForceLevel,
    this.tauntLevel,
    this.epDamageResistance,
    this.epResistance,
    this.stunImmune,
    this.silenceImmune,
    this.sleepImmune,
    this.frozenImmune,
    this.levitateImmune,
  });

  factory KeyFrameDataModel.fromJson(Map<String, dynamic> json) =>
      _$KeyFrameDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$KeyFrameDataModelToJson(this);

  KeyFrameDataModel copyWith({
    int? maxHp,
    int? atk,
    int? def,
    double? magicResistance,
    int? cost,
    int? blockCnt,
    double? moveSpeed,
    double? attackSpeed,
    double? baseAttackTime,
    int? respawnTime,
    double? hpRecoveryPerSec,
    double? spRecoveryPerSec,
    int? maxDeployCount,
    int? massLevel,
    int? baseForceLevel,
    int? tauntLevel,
    double? epDamageResistance,
    double? epResistance,
    bool? stunImmune,
    bool? silenceImmune,
    bool? sleepImmune,
    bool? frozenImmune,
    bool? levitateImmune,
  }) =>
      KeyFrameDataModel(
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
