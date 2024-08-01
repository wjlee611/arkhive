// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyframe_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyFrameDataModel _$KeyFrameDataModelFromJson(Map<String, dynamic> json) =>
    KeyFrameDataModel(
      maxHp: (json['maxHp'] as num?)?.toInt(),
      atk: (json['atk'] as num?)?.toInt(),
      def: (json['def'] as num?)?.toInt(),
      magicResistance: (json['magicResistance'] as num?)?.toDouble(),
      cost: (json['cost'] as num?)?.toInt(),
      blockCnt: (json['blockCnt'] as num?)?.toInt(),
      moveSpeed: (json['moveSpeed'] as num?)?.toDouble(),
      attackSpeed: (json['attackSpeed'] as num?)?.toDouble(),
      baseAttackTime: (json['baseAttackTime'] as num?)?.toDouble(),
      respawnTime: (json['respawnTime'] as num?)?.toInt(),
      hpRecoveryPerSec: (json['hpRecoveryPerSec'] as num?)?.toDouble(),
      spRecoveryPerSec: (json['spRecoveryPerSec'] as num?)?.toDouble(),
      maxDeployCount: (json['maxDeployCount'] as num?)?.toInt(),
      massLevel: (json['massLevel'] as num?)?.toInt(),
      baseForceLevel: (json['baseForceLevel'] as num?)?.toInt(),
      tauntLevel: (json['tauntLevel'] as num?)?.toInt(),
      epDamageResistance: (json['epDamageResistance'] as num?)?.toDouble(),
      epResistance: (json['epResistance'] as num?)?.toDouble(),
      stunImmune: json['stunImmune'] as bool?,
      silenceImmune: json['silenceImmune'] as bool?,
      sleepImmune: json['sleepImmune'] as bool?,
      frozenImmune: json['frozenImmune'] as bool?,
      levitateImmune: json['levitateImmune'] as bool?,
    );

Map<String, dynamic> _$KeyFrameDataModelToJson(KeyFrameDataModel instance) =>
    <String, dynamic>{
      'maxHp': instance.maxHp,
      'atk': instance.atk,
      'def': instance.def,
      'magicResistance': instance.magicResistance,
      'cost': instance.cost,
      'blockCnt': instance.blockCnt,
      'moveSpeed': instance.moveSpeed,
      'attackSpeed': instance.attackSpeed,
      'baseAttackTime': instance.baseAttackTime,
      'respawnTime': instance.respawnTime,
      'hpRecoveryPerSec': instance.hpRecoveryPerSec,
      'spRecoveryPerSec': instance.spRecoveryPerSec,
      'maxDeployCount': instance.maxDeployCount,
      'massLevel': instance.massLevel,
      'baseForceLevel': instance.baseForceLevel,
      'tauntLevel': instance.tauntLevel,
      'epDamageResistance': instance.epDamageResistance,
      'epResistance': instance.epResistance,
      'stunImmune': instance.stunImmune,
      'silenceImmune': instance.silenceImmune,
      'sleepImmune': instance.sleepImmune,
      'frozenImmune': instance.frozenImmune,
      'levitateImmune': instance.levitateImmune,
    };
