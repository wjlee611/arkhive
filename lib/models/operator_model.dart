import 'package:arkhive/models/common_models.dart';

/// USING AT
///
/// operator
/// token
/// trap

class OperatorModel {
  final String? name,
      description,
      position,
      profession,
      subProfessionId,
      nationId,
      groupId,
      teamId;
  final int? maxPotentialLevel, rarity;
  final bool? isNotObtainable;
  final List<String> tagList;
  final List<OperatorLevelPhaseModel> phases;
  final List<OperatorSkillsModel> skills;
  final List<OperatorTalentsModel> talents;
  final List<OperatorPotentialRanksModel> potentialRanks;
  final List<OperatorLevelPhaseAttrKeyFrameModel> favorKeyFrames;
  final List<OperatorAllSkillLvlupModel> allSkillLvlup;

  OperatorModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        nationId = json['nationId'],
        groupId = json['groupId'],
        teamId = json['teamId'],
        position = json['position'],
        profession = json['profession'],
        subProfessionId = json['subProfessionId'],
        maxPotentialLevel = json['maxPotentialLevel'],
        rarity = json['rarity'],
        isNotObtainable = json['isNotObtainable'],
        tagList = [
          if (json['tagList'] != null)
            for (var data in json['tagList']) data
        ],
        phases = [
          if (json['phases'] != null)
            for (var data in json['phases'])
              OperatorLevelPhaseModel.fromJson(data)
        ],
        skills = [
          if (json['skills'] != null)
            for (var data in json['skills']) OperatorSkillsModel.fromJson(data)
        ],
        talents = [
          if (json['talents'] != null)
            for (var data in json['talents'])
              OperatorTalentsModel.fromJson(data)
        ],
        potentialRanks = [
          if (json['potentialRanks'] != null)
            for (var data in json['potentialRanks'])
              OperatorPotentialRanksModel.fromJson(data)
        ],
        favorKeyFrames = [
          if (json['favorKeyFrames'] != null)
            for (var data in json['favorKeyFrames'])
              OperatorLevelPhaseAttrKeyFrameModel.fromJson(data)
        ],
        allSkillLvlup = [
          if (json['allSkillLvlup'] != null)
            for (var data in json['allSkillLvlup'])
              OperatorAllSkillLvlupModel.fromJson(data)
        ];
}

// OPERATOR STAT MODEL
class OperatorLevelPhaseModel {
  final String? characterPrefabKey, rangeId;
  final int? maxLevel;
  final List<OperatorLevelPhaseAttrKeyFrameModel> attributesKeyFrames;
  final List<EvolveCostModel> evolveCost;

  OperatorLevelPhaseModel.fromJson(Map<String, dynamic> json)
      : characterPrefabKey = json['characterPrefabKey'],
        rangeId = json['rangeId'],
        maxLevel = json['maxLevel'],
        attributesKeyFrames = [
          if (json['attributesKeyFrames'] != null)
            for (var data in json['attributesKeyFrames'])
              OperatorLevelPhaseAttrKeyFrameModel.fromJson(data)
        ],
        evolveCost = [
          if (json['evolveCost'] != null)
            for (var data in json['evolveCost']) EvolveCostModel.fromJson(data)
        ];
}

class OperatorLevelPhaseAttrKeyFrameModel {
  final int level;
  final OperatorStatsDataModel data;

  OperatorLevelPhaseAttrKeyFrameModel.fromJson(Map<String, dynamic> json)
      : level = json['level'],
        data = OperatorStatsDataModel.fromJson(json['data']);
}

// OPERATOR SKILLS MODEL
class OperatorSkillsModel {
  final String? skillId;
  final List<OperatorSkillslevelUpCostCondModel> levelUpCostCond;
  final OperatorUnlockCondModel unlockCond;

  OperatorSkillsModel.fromJson(Map<String, dynamic> json)
      : skillId = json['skillId'],
        levelUpCostCond = [
          if (json['levelUpCostCond'] != null)
            for (var data in json['levelUpCostCond'])
              OperatorSkillslevelUpCostCondModel.fromJson(data)
        ],
        unlockCond = OperatorUnlockCondModel.fromJson(json['unlockCond'] ?? {});
}

class OperatorSkillslevelUpCostCondModel {
  final OperatorUnlockCondModel unlockCond;
  final int? lvlUpTime;
  final List<EvolveCostModel> levelUpCost;

  OperatorSkillslevelUpCostCondModel.fromJson(Map<String, dynamic> json)
      : unlockCond = OperatorUnlockCondModel.fromJson(json['unlockCond'] ?? {}),
        lvlUpTime = json['lvlUpTime'],
        levelUpCost = [
          if (json['levelUpCost'] != null)
            for (var data in json['levelUpCost']) EvolveCostModel.fromJson(data)
        ];
}

class OperatorAllSkillLvlupModel {
  final OperatorUnlockCondModel unlockCond;
  final List<EvolveCostModel> lvlUpCost;

  OperatorAllSkillLvlupModel.fromJson(Map<String, dynamic> json)
      : unlockCond = OperatorUnlockCondModel.fromJson(json['unlockCond'] ?? {}),
        lvlUpCost = [
          if (json['lvlUpCost'] != null)
            for (var data in json['lvlUpCost']) EvolveCostModel.fromJson(data)
        ];
}

// OPERATOR TALENTS MODEL
class OperatorTalentsModel {
  final List<OperatorTalentsCandidatesModel> candidates;

  OperatorTalentsModel.fromJson(Map<String, dynamic> json)
      : candidates = [
          if (json['candidates'] != null)
            for (var data in json['candidates'])
              OperatorTalentsCandidatesModel.fromJson(data)
        ];
}

class OperatorTalentsCandidatesModel implements PotentialRank {
  @override
  final OperatorUnlockCondModel unlockCondition;
  @override
  final int? requiredPotentialRank;
  final String? name, description;
  final List<BlackboardModel> blackboard;

  OperatorTalentsCandidatesModel.fromJson(Map<String, dynamic> json)
      : unlockCondition =
            OperatorUnlockCondModel.fromJson(json['unlockCondition'] ?? {}),
        requiredPotentialRank = json['requiredPotentialRank'],
        name = json['name'],
        description = json['description'],
        blackboard = [
          if (json['blackboard'] != null)
            for (var data in json['blackboard']) BlackboardModel.fromJson(data)
        ];
}

// OPERATOR POTENTIAL RANKS MODEL
class OperatorPotentialRanksModel {
  final int? type;
  final String? description;

  OperatorPotentialRanksModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        description = json['description'];
}

// OPERATOR ETC MODEL
class OperatorStatsDataModel {
  final double maxHp,
      atk,
      def,
      magicResistance,
      cost,
      blockCnt,
      respawnTime,
      attackSpeed;

  OperatorStatsDataModel.fromJson(Map<String, dynamic> json)
      : maxHp = json['maxHp'].toDouble(),
        atk = json['atk'].toDouble(),
        def = json['def'].toDouble(),
        magicResistance = json['magicResistance'],
        cost = json['cost'].toDouble(),
        blockCnt = json['blockCnt'].toDouble(),
        respawnTime = json['respawnTime'].toDouble(),
        attackSpeed = json['baseAttackTime'];
}

class OperatorUnlockCondModel {
  final int? phase, level;

  OperatorUnlockCondModel.fromJson(Map<String, dynamic> json)
      : phase = json['phase'],
        level = json['level'];
}
