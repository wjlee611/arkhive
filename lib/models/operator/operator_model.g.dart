// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperatorModel _$OperatorModelFromJson(Map<String, dynamic> json) =>
    OperatorModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      canUseActivityPotentialItem: json['canUseActivityPotentialItem'] as bool?,
      canUseGeneralPotentialItem: json['canUseGeneralPotentialItem'] as bool?,
      potentialItemId: json['potentialItemId'] as String?,
      activityPotentialItemId: json['activityPotentialItemId'] as String?,
      classicPotentialItemId: json['classicPotentialItemId'] as String?,
      nationId: json['nationId'] as String?,
      groupId: json['groupId'] as String?,
      teamId: json['teamId'] as String?,
      displayNumber: json['displayNumber'] as String?,
      tokenKey: json['tokenKey'] as String?,
      appellation: json['appellation'] as String?,
      position: json['position'] as String?,
      tagList:
          (json['tagList'] as List<dynamic>?)?.map((e) => e as String).toList(),
      itemUsage: json['itemUsage'] as String?,
      itemDesc: json['itemDesc'] as String?,
      itemObtainApproach: json['itemObtainApproach'] as String?,
      isNotObtainable: json['isNotObtainable'] as bool?,
      isSpChar: json['isSpChar'] as bool?,
      maxPotentialLevel: (json['maxPotentialLevel'] as num?)?.toInt(),
      rarity: fromJsonToString(json['rarity']),
      profession: json['profession'] as String?,
      subProfessionId: json['subProfessionId'] as String?,
      trait: json['trait'] == null
          ? null
          : OperatorTraitModel.fromJson(json['trait'] as Map<String, dynamic>),
      phases: (json['phases'] as List<dynamic>)
          .map((e) => OperatorPhasesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      skills: (json['skills'] as List<dynamic>)
          .map((e) => OperatorSkillsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      talents: (json['talents'] as List<dynamic>?)
          ?.map((e) => OperatorTalentsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      potentialRanks: (json['potentialRanks'] as List<dynamic>)
          .map((e) =>
              OperatorPotnetialRanksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      favorKeyFrames: (json['favorKeyFrames'] as List<dynamic>)
          .map((e) =>
              OperatorFavorKeyFramesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      allSkillLvlup: (json['allSkillLvlup'] as List<dynamic>)
          .map((e) =>
              OperatorAllSkillLvlupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

OperatorTraitModel _$OperatorTraitModelFromJson(Map<String, dynamic> json) =>
    OperatorTraitModel(
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((e) =>
              OperatorTraitCandidatesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

OperatorTraitCandidatesModel _$OperatorTraitCandidatesModelFromJson(
        Map<String, dynamic> json) =>
    OperatorTraitCandidatesModel(
      unlockCondition: UnlockConditionModel.fromJson(
          json['unlockCondition'] as Map<String, dynamic>),
      requiredPotentialRank: (json['requiredPotentialRank'] as num).toInt(),
      blackboard: (json['blackboard'] as List<dynamic>?)
          ?.map(
              (e) => TalentBlackboardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      overrideDescripton: json['overrideDescripton'] as String?,
      prefabKey: json['prefabKey'] as String?,
      rangeId: json['rangeId'] as String?,
    );

OperatorPhasesModel _$OperatorPhasesModelFromJson(Map<String, dynamic> json) =>
    OperatorPhasesModel(
      characterPrefabKey: json['characterPrefabKey'] as String?,
      rangeId: json['rangeId'] as String?,
      maxLevel: (json['maxLevel'] as num?)?.toInt(),
      attributesKeyFrames: (json['attributesKeyFrames'] as List<dynamic>?)
          ?.map((e) =>
              OperatorAttrKeyFramesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      evolveCost: (json['evolveCost'] as List<dynamic>?)
          ?.map((e) => ItemCostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

OperatorAttrKeyFramesModel _$OperatorAttrKeyFramesModelFromJson(
        Map<String, dynamic> json) =>
    OperatorAttrKeyFramesModel(
      level: (json['level'] as num).toInt(),
      data: KeyFrameDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

OperatorSkillsModel _$OperatorSkillsModelFromJson(Map<String, dynamic> json) =>
    OperatorSkillsModel(
      skillId: json['skillId'] as String?,
      overridePrefabKey: json['overridePrefabKey'] as String?,
      overrideTokenKey: json['overrideTokenKey'] as String?,
      levelUpCostCond: (json['levelUpCostCond'] as List<dynamic>?)
          ?.map((e) => OperatorSkillLevelupCostCondModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      unlockCond: json['unlockCond'] == null
          ? null
          : UnlockConditionModel.fromJson(
              json['unlockCond'] as Map<String, dynamic>),
    );

OperatorSkillLevelupCostCondModel _$OperatorSkillLevelupCostCondModelFromJson(
        Map<String, dynamic> json) =>
    OperatorSkillLevelupCostCondModel(
      unlockCond: json['unlockCond'] == null
          ? null
          : UnlockConditionModel.fromJson(
              json['unlockCond'] as Map<String, dynamic>),
      lvlUpTime: (json['lvlUpTime'] as num?)?.toInt(),
      levelUpCost: (json['levelUpCost'] as List<dynamic>?)
          ?.map((e) => ItemCostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

OperatorTalentsModel _$OperatorTalentsModelFromJson(
        Map<String, dynamic> json) =>
    OperatorTalentsModel(
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((e) =>
              OperatorTalentCandidatesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

OperatorTalentCandidatesModel _$OperatorTalentCandidatesModelFromJson(
        Map<String, dynamic> json) =>
    OperatorTalentCandidatesModel(
      unlockCondition: UnlockConditionModel.fromJson(
          json['unlockCondition'] as Map<String, dynamic>),
      requiredPotentialRank: (json['requiredPotentialRank'] as num).toInt(),
      prefabKey: json['prefabKey'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      rangeId: json['rangeId'] as String?,
      blackboard: (json['blackboard'] as List<dynamic>?)
          ?.map(
              (e) => TalentBlackboardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

OperatorPotnetialRanksModel _$OperatorPotnetialRanksModelFromJson(
        Map<String, dynamic> json) =>
    OperatorPotnetialRanksModel(
      description: json['description'] as String?,
      buff: json['buff'] == null
          ? null
          : OperatorPotentialBuffModel.fromJson(
              json['buff'] as Map<String, dynamic>),
    );

OperatorPotentialBuffModel _$OperatorPotentialBuffModelFromJson(
        Map<String, dynamic> json) =>
    OperatorPotentialBuffModel(
      attributes: json['attributes'] == null
          ? null
          : OperatorPotentialBuffAttrModel.fromJson(
              json['attributes'] as Map<String, dynamic>),
    );

OperatorPotentialBuffAttrModel _$OperatorPotentialBuffAttrModelFromJson(
        Map<String, dynamic> json) =>
    OperatorPotentialBuffAttrModel(
      attributeModifiers: (json['attributeModifiers'] as List<dynamic>?)
          ?.map((e) =>
              AttributeModifiersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

OperatorFavorKeyFramesModel _$OperatorFavorKeyFramesModelFromJson(
        Map<String, dynamic> json) =>
    OperatorFavorKeyFramesModel(
      level: (json['level'] as num).toInt(),
      data: KeyFrameDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

OperatorAllSkillLvlupModel _$OperatorAllSkillLvlupModelFromJson(
        Map<String, dynamic> json) =>
    OperatorAllSkillLvlupModel(
      unlockCond: UnlockConditionModel.fromJson(
          json['unlockCond'] as Map<String, dynamic>),
      lvlUpCost: (json['lvlUpCost'] as List<dynamic>?)
          ?.map((e) => ItemCostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
