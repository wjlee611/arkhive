// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeModel _$AttributeModelFromJson(Map<String, dynamic> json) =>
    AttributeModel(
      maxHp:
          AttributeMModel<int>.fromJson(json['maxHp'] as Map<String, dynamic>),
      atk: AttributeMModel<int>.fromJson(json['atk'] as Map<String, dynamic>),
      def: AttributeMModel<int>.fromJson(json['def'] as Map<String, dynamic>),
      magicResistance: AttributeMModel<double>.fromJson(
          json['magicResistance'] as Map<String, dynamic>),
      cost: AttributeMModel<int>.fromJson(json['cost'] as Map<String, dynamic>),
      blockCnt: AttributeMModel<int>.fromJson(
          json['blockCnt'] as Map<String, dynamic>),
      moveSpeed: AttributeMModel<double>.fromJson(
          json['moveSpeed'] as Map<String, dynamic>),
      attackSpeed: AttributeMModel<double>.fromJson(
          json['attackSpeed'] as Map<String, dynamic>),
      baseAttackTime: AttributeMModel<double>.fromJson(
          json['baseAttackTime'] as Map<String, dynamic>),
      respawnTime: AttributeMModel<int>.fromJson(
          json['respawnTime'] as Map<String, dynamic>),
      hpRecoveryPerSec: AttributeMModel<double>.fromJson(
          json['hpRecoveryPerSec'] as Map<String, dynamic>),
      spRecoveryPerSec: AttributeMModel<double>.fromJson(
          json['spRecoveryPerSec'] as Map<String, dynamic>),
      maxDeployCount: AttributeMModel<int>.fromJson(
          json['maxDeployCount'] as Map<String, dynamic>),
      massLevel: AttributeMModel<int>.fromJson(
          json['massLevel'] as Map<String, dynamic>),
      baseForceLevel: AttributeMModel<int>.fromJson(
          json['baseForceLevel'] as Map<String, dynamic>),
      tauntLevel: AttributeMModel<int>.fromJson(
          json['tauntLevel'] as Map<String, dynamic>),
      epDamageResistance: AttributeMModel<double>.fromJson(
          json['epDamageResistance'] as Map<String, dynamic>),
      epResistance: AttributeMModel<double>.fromJson(
          json['epResistance'] as Map<String, dynamic>),
      stunImmune: AttributeMModel<bool>.fromJson(
          json['stunImmune'] as Map<String, dynamic>),
      silenceImmune: AttributeMModel<bool>.fromJson(
          json['silenceImmune'] as Map<String, dynamic>),
      sleepImmune: AttributeMModel<bool>.fromJson(
          json['sleepImmune'] as Map<String, dynamic>),
      frozenImmune: AttributeMModel<bool>.fromJson(
          json['frozenImmune'] as Map<String, dynamic>),
      levitateImmune: AttributeMModel<bool>.fromJson(
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
