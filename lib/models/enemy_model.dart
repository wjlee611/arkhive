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
  final bool? hideInHandbook;

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
        ability = json['ability'],
        hideInHandbook = json['hideInHandbook'];
}

class EnemyDataModel {
  final List<EnemyValueDataModel> values;

  EnemyDataModel.fromJson(Map<String, dynamic> json)
      : values = [
          if (json['Value'] != null)
            for (var data in json['Value']) EnemyValueDataModel.fromJson(data)
        ];
}

class EnemyValueDataModel {
  final EnemyAttrValueDataModel? attributes;
  final List<BlackboardModel> talentBlackboard;

  EnemyValueDataModel.fromJson(Map<String, dynamic> json)
      : attributes =
            EnemyAttrValueDataModel.fromJson(json['enemyData']?['attributes']),
        talentBlackboard = [
          if (json['enemyData']?['talentBlackboard'] != null)
            for (var data in json['enemyData']['talentBlackboard'])
              BlackboardModel.fromJson(data)
        ];
}

class EnemyAttrValueDataModel {
  final int? maxHp, atk, def, massLevel;
  final double? magicResistance, moveSpeed, attackSpeed, baseAttackTime;
  final bool? stunImmune,
      silenceImmune,
      sleepImmune,
      frozenImmune,
      levitateImmune;

  EnemyAttrValueDataModel.fromJson(Map<String, dynamic> json)
      : maxHp = json['maxHp']?['m_value'],
        atk = json['atk']?['m_value'],
        def = json['def']?['m_value'],
        magicResistance = json['magicResistance']?['m_value'],
        massLevel = json['massLevel']?['m_value'],
        moveSpeed = json['moveSpeed']?['m_value'],
        attackSpeed = json['attackSpeed']?['m_value'],
        baseAttackTime = json['baseAttackTime']?['m_value'],
        stunImmune = json['stunImmune']?['m_value'],
        silenceImmune = json['silenceImmune']?['m_value'],
        sleepImmune = json['sleepImmune']?['m_value'],
        frozenImmune = json['frozenImmune']?['m_value'],
        levitateImmune = json['levitateImmune']?['m_value'];
}
