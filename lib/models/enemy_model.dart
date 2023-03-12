import 'package:arkhive/models/common_models.dart';

class EnemyModel {
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

  EnemyModel.fromJson(Map<String, dynamic> json)
      : enemyId = json['enemyId'],
        enemyIndex = json['enemyIndex'],
        name = json['name'],
        enemyRace = json['enemyRace'],
        enemyLevel = json['enemyLevel'],
        attackType = json['attackType'],
        endure = json['endure'],
        attack = json['attack'],
        defence = json['defence'],
        resistance = json['resistance'],
        ability = json['ability'];
}

class EnemyDataModel {
  final String? key;
  final List<EnemyAttrValueDataModel> values;

  EnemyDataModel.fromJson(Map<String, dynamic> json)
      : key = json['Key'],
        values = [
          if (json['Value'] != null)
            for (var data in json['Value'])
              EnemyAttrValueDataModel.fromJson(data)
        ];
}

class EnemyValueDataModel {
  final EnemyAttrValueDataModel? attributes;
  final List<BlackboardModel> talentBlackboard;

  EnemyValueDataModel.fromJson(Map<String, dynamic> json)
      : attributes = json['attributes'],
        talentBlackboard = [
          if (json['talentBlackboard'] != null)
            for (var data in json['talentBlackboard'])
              BlackboardModel.fromJson(data)
        ];
}

class EnemyAttrValueDataModel {
  final int? maxHp, atk, def, magicResistance, massLevel;
  final double? moveSpeed, attackSpeed, baseAttackTime;
  final bool? stunImmune,
      silenceImmune,
      sleepImmune,
      frozenImmune,
      levitateImmune;

  EnemyAttrValueDataModel.fromJson(Map<String, dynamic> json)
      : maxHp = json['maxHp']['m_value'],
        atk = json['atk']['m_value'],
        def = json['def']['m_value'],
        magicResistance = json['magicResistance']['m_value'],
        massLevel = json['massLevel']['m_value'],
        moveSpeed = json['moveSpeed']['m_value'],
        attackSpeed = json['attackSpeed']['m_value'],
        baseAttackTime = json['baseAttackTime']['m_value'],
        stunImmune = json['stunImmune']['m_value'],
        silenceImmune = json['silenceImmune']['m_value'],
        sleepImmune = json['sleepImmune']['m_value'],
        frozenImmune = json['frozenImmune']['m_value'],
        levitateImmune = json['levitateImmune']['m_value'];
}
