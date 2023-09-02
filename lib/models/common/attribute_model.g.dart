// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeModel _$AttributeModelFromJson(Map<String, dynamic> json) =>
    AttributeModel(
      maxHp: json['maxHp'] == null
          ? null
          : AttributeMModel<int>.fromJson(
              json['maxHp'] as Map<String, dynamic>),
      atk: json['atk'] == null
          ? null
          : AttributeMModel<int>.fromJson(json['atk'] as Map<String, dynamic>),
      def: json['def'] == null
          ? null
          : AttributeMModel<int>.fromJson(json['def'] as Map<String, dynamic>),
      magicResistance: json['magicResistance'] == null
          ? null
          : AttributeMModel<double>.fromJson(
              json['magicResistance'] as Map<String, dynamic>),
      cost: json['cost'] == null
          ? null
          : AttributeMModel<int>.fromJson(json['cost'] as Map<String, dynamic>),
      blockCnt: json['blockCnt'] == null
          ? null
          : AttributeMModel<int>.fromJson(
              json['blockCnt'] as Map<String, dynamic>),
      moveSpeed: json['moveSpeed'] == null
          ? null
          : AttributeMModel<double>.fromJson(
              json['moveSpeed'] as Map<String, dynamic>),
      attackSpeed: json['attackSpeed'] == null
          ? null
          : AttributeMModel<double>.fromJson(
              json['attackSpeed'] as Map<String, dynamic>),
      baseAttackTime: json['baseAttackTime'] == null
          ? null
          : AttributeMModel<double>.fromJson(
              json['baseAttackTime'] as Map<String, dynamic>),
      respawnTime: json['respawnTime'] == null
          ? null
          : AttributeMModel<int>.fromJson(
              json['respawnTime'] as Map<String, dynamic>),
      hpRecoveryPerSec: json['hpRecoveryPerSec'] == null
          ? null
          : AttributeMModel<double>.fromJson(
              json['hpRecoveryPerSec'] as Map<String, dynamic>),
      spRecoveryPerSec: json['spRecoveryPerSec'] == null
          ? null
          : AttributeMModel<double>.fromJson(
              json['spRecoveryPerSec'] as Map<String, dynamic>),
      maxDeployCount: json['maxDeployCount'] == null
          ? null
          : AttributeMModel<int>.fromJson(
              json['maxDeployCount'] as Map<String, dynamic>),
      massLevel: json['massLevel'] == null
          ? null
          : AttributeMModel<int>.fromJson(
              json['massLevel'] as Map<String, dynamic>),
      baseForceLevel: json['baseForceLevel'] == null
          ? null
          : AttributeMModel<int>.fromJson(
              json['baseForceLevel'] as Map<String, dynamic>),
      tauntLevel: json['tauntLevel'] == null
          ? null
          : AttributeMModel<int>.fromJson(
              json['tauntLevel'] as Map<String, dynamic>),
      epDamageResistance: json['epDamageResistance'] == null
          ? null
          : AttributeMModel<double>.fromJson(
              json['epDamageResistance'] as Map<String, dynamic>),
      epResistance: json['epResistance'] == null
          ? null
          : AttributeMModel<double>.fromJson(
              json['epResistance'] as Map<String, dynamic>),
      stunImmune: json['stunImmune'] == null
          ? null
          : AttributeMModel<bool>.fromJson(
              json['stunImmune'] as Map<String, dynamic>),
      silenceImmune: json['silenceImmune'] == null
          ? null
          : AttributeMModel<bool>.fromJson(
              json['silenceImmune'] as Map<String, dynamic>),
      sleepImmune: json['sleepImmune'] == null
          ? null
          : AttributeMModel<bool>.fromJson(
              json['sleepImmune'] as Map<String, dynamic>),
      frozenImmune: json['frozenImmune'] == null
          ? null
          : AttributeMModel<bool>.fromJson(
              json['frozenImmune'] as Map<String, dynamic>),
      levitateImmune: json['levitateImmune'] == null
          ? null
          : AttributeMModel<bool>.fromJson(
              json['levitateImmune'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttributeModelToJson(AttributeModel instance) =>
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
