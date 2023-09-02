import 'package:arkhive/models/common/attribute_m_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attribute_model.g.dart';

@JsonSerializable()
class AttributeModel extends Equatable {
  final AttributeMModel<int>? maxHp;
  final AttributeMModel<int>? atk;
  final AttributeMModel<int>? def;
  final AttributeMModel<double>? magicResistance;
  final AttributeMModel<int>? cost;
  final AttributeMModel<int>? blockCnt;
  final AttributeMModel<double>? moveSpeed;
  final AttributeMModel<double>? attackSpeed;
  final AttributeMModel<double>? baseAttackTime;
  final AttributeMModel<int>? respawnTime;
  final AttributeMModel<double>? hpRecoveryPerSec;
  final AttributeMModel<double>? spRecoveryPerSec;
  final AttributeMModel<int>? maxDeployCount;
  final AttributeMModel<int>? massLevel;
  final AttributeMModel<int>? baseForceLevel;
  final AttributeMModel<int>? tauntLevel;
  final AttributeMModel<double>? epDamageResistance;
  final AttributeMModel<double>? epResistance;
  final AttributeMModel<bool>? stunImmune;
  final AttributeMModel<bool>? silenceImmune;
  final AttributeMModel<bool>? sleepImmune;
  final AttributeMModel<bool>? frozenImmune;
  final AttributeMModel<bool>? levitateImmune;

  const AttributeModel({
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

  factory AttributeModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeModelToJson(this);

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
