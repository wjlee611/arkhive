import 'package:arkhive/models/interface/candidates_interface.dart';
import 'package:arkhive/models/common/attribute_model.dart';
import 'package:arkhive/models/common/attribute_modifiers_model.dart';
import 'package:arkhive/models/common/item_cost_model.dart';
import 'package:arkhive/models/common/talent_blackboard_model.dart';
import 'package:arkhive/models/common/unlock_condition_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operator_model.g.dart';

@JsonSerializable(createToJson: false)
class OperatorModel extends Equatable {
  final String? name;
  final String? description;
  final bool? canUseGeneralPotentialItem;
  final bool? canUseActivityPotentialItem;
  final String? potentialItemId;
  final String? activityPotentialItemId;
  final String? classicPotentialItemId; // CN
  final String? nationId;
  final String? groupId;
  final String? teamId;
  final String? displayNumber;
  final String? tokenKey; // deprecated in CN
  final String? appellation;
  final String? position;
  final List<String>? tagList;
  final String? itemUsage;
  final String? itemDesc;
  final String? itemObtainApproach;
  final bool? isNotObtainable;
  final bool? isSpChar;
  final int? maxPotentialLevel;
  final String? rarity; // CN: 5 -> TIER_6
  final String? profession;
  final String? subProfessionId;
  final OperatorTraitModel? trait;
  final List<OperatorPhasesModel>? phases;
  final List<OperatorSkillsModel>? skills;
  final List<OperatorTalentsModel>? talents;
  final List<OperatorPotnetialRanksModel>? potentialRanks;
  final List<OperatorFavorKeyFramesModel>? favorKeyFrames;
  final List<OperatorAllSkillLvlupModel>? allSkillLvlup;

  const OperatorModel({
    this.name,
    this.description,
    this.canUseActivityPotentialItem,
    this.canUseGeneralPotentialItem,
    this.potentialItemId,
    this.activityPotentialItemId,
    this.classicPotentialItemId,
    this.nationId,
    this.groupId,
    this.teamId,
    this.displayNumber,
    this.tokenKey,
    this.appellation,
    this.position,
    this.tagList,
    this.itemUsage,
    this.itemDesc,
    this.itemObtainApproach,
    this.isNotObtainable,
    this.isSpChar,
    this.maxPotentialLevel,
    this.rarity,
    this.profession,
    this.subProfessionId,
    this.trait,
    this.phases,
    this.skills,
    this.talents,
    this.potentialRanks,
    this.favorKeyFrames,
    this.allSkillLvlup,
  });

  factory OperatorModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorModelFromJson(json);

  @override
  List<Object?> get props => [
        name,
        description,
        canUseActivityPotentialItem,
        canUseGeneralPotentialItem,
        potentialItemId,
        activityPotentialItemId,
        classicPotentialItemId,
        nationId,
        groupId,
        teamId,
        displayNumber,
        tokenKey,
        appellation,
        position,
        tagList,
        itemUsage,
        itemDesc,
        itemObtainApproach,
        isNotObtainable,
        isSpChar,
        maxPotentialLevel,
        rarity,
        profession,
        subProfessionId,
        trait,
        phases,
        skills,
        talents,
        potentialRanks,
        favorKeyFrames,
        allSkillLvlup,
      ];
}

// trait //
@JsonSerializable(createToJson: false)
class OperatorTraitModel extends Equatable {
  final List<OperatorTraitCandidatesModel>? candidates;

  const OperatorTraitModel({this.candidates});

  factory OperatorTraitModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorTraitModelFromJson(json);

  @override
  List<Object?> get props => [candidates];
}

@JsonSerializable(createToJson: false)
class OperatorTraitCandidatesModel extends Equatable implements ICandidate {
  @override
  final UnlockConditionModel unlockCondition;
  @override
  final int requiredPotentialRank;
  final List<TalentBlackboardModel>? blackboard;
  final String? overrideDescripton;
  final String? prefabKey;
  final String? rangeId;

  const OperatorTraitCandidatesModel({
    required this.unlockCondition,
    required this.requiredPotentialRank,
    this.blackboard,
    this.overrideDescripton,
    this.prefabKey,
    this.rangeId,
  });

  factory OperatorTraitCandidatesModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorTraitCandidatesModelFromJson(json);

  @override
  List<Object?> get props => [
        unlockCondition,
        requiredPotentialRank,
        blackboard,
        overrideDescripton,
        prefabKey,
        rangeId,
      ];
}
// end of trait //

// phases //
@JsonSerializable(createToJson: false)
class OperatorPhasesModel extends Equatable {
  final String? characterPrefabKey;
  final String? rangeId;
  final int? maxLevel;
  final List<OperatorAttrKeyFramesModel>? attributesKeyFrames;
  final List<ItemCostModel>? evolveCost;

  const OperatorPhasesModel({
    this.characterPrefabKey,
    this.rangeId,
    this.maxLevel,
    this.attributesKeyFrames,
    this.evolveCost,
  });

  factory OperatorPhasesModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorPhasesModelFromJson(json);

  @override
  List<Object?> get props => [
        characterPrefabKey,
        rangeId,
        maxLevel,
        attributesKeyFrames,
        evolveCost,
      ];
}

@JsonSerializable(createToJson: false)
class OperatorAttrKeyFramesModel extends Equatable {
  final int level;
  final AttributeModel data;

  const OperatorAttrKeyFramesModel({
    required this.level,
    required this.data,
  });

  factory OperatorAttrKeyFramesModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorAttrKeyFramesModelFromJson(json);

  @override
  List<Object?> get props => [
        level,
        data,
      ];
}
// end of phases //

// skills //
@JsonSerializable(createToJson: false)
class OperatorSkillsModel extends Equatable {
  final String? skillId;
  final String? overridePrefabKey;
  final String? overrideTokenKey;
  final List<OperatorSkillLevelupCostCondModel>? levelUpCostCond;
  final UnlockConditionModel? unlockCond;

  const OperatorSkillsModel({
    this.skillId,
    this.overridePrefabKey,
    this.overrideTokenKey,
    this.levelUpCostCond,
    this.unlockCond,
  });

  factory OperatorSkillsModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorSkillsModelFromJson(json);

  @override
  List<Object?> get props => [
        skillId,
        overridePrefabKey,
        overrideTokenKey,
        levelUpCostCond,
        unlockCond,
      ];
}

@JsonSerializable(createToJson: false)
class OperatorSkillLevelupCostCondModel extends Equatable {
  final UnlockConditionModel? unlockCond;
  final int? lvlUpTime;
  final List<ItemCostModel>? levelUpCost;

  const OperatorSkillLevelupCostCondModel({
    this.unlockCond,
    this.lvlUpTime,
    this.levelUpCost,
  });

  factory OperatorSkillLevelupCostCondModel.fromJson(
          Map<String, dynamic> json) =>
      _$OperatorSkillLevelupCostCondModelFromJson(json);

  @override
  List<Object?> get props => [
        unlockCond,
        lvlUpTime,
        levelUpCost,
      ];
}
// end of skills //

// talents //
@JsonSerializable(createToJson: false)
class OperatorTalentsModel extends Equatable {
  final List<OperatorTalentCandidatesModel>? candidates;

  const OperatorTalentsModel({this.candidates});

  factory OperatorTalentsModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorTalentsModelFromJson(json);

  @override
  List<Object?> get props => [candidates];
}

@JsonSerializable(createToJson: false)
class OperatorTalentCandidatesModel extends Equatable implements ICandidate {
  @override
  final UnlockConditionModel unlockCondition;
  @override
  final int requiredPotentialRank;
  final String? prefabKey;
  final String? name;
  final String? description;
  final String? rangeId;
  final List<TalentBlackboardModel>? blackboard;

  const OperatorTalentCandidatesModel({
    required this.unlockCondition,
    required this.requiredPotentialRank,
    this.prefabKey,
    this.name,
    this.description,
    this.rangeId,
    this.blackboard,
  });

  factory OperatorTalentCandidatesModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorTalentCandidatesModelFromJson(json);

  @override
  List<Object?> get props => [
        unlockCondition,
        requiredPotentialRank,
        prefabKey,
        name,
        description,
        rangeId,
        blackboard,
      ];
}
// end of talents //

// potentialRanks //
@JsonSerializable(createToJson: false)
class OperatorPotnetialRanksModel extends Equatable {
  // "type": "BUFF"
  final String? description;
  final OperatorPotentialBuffModel? buff;
  // "equivalentCost": null

  const OperatorPotnetialRanksModel({
    this.description,
    this.buff,
  });

  factory OperatorPotnetialRanksModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorPotnetialRanksModelFromJson(json);

  @override
  List<Object?> get props => [
        description,
        buff,
      ];
}

@JsonSerializable(createToJson: false)
class OperatorPotentialBuffModel extends Equatable {
  final OperatorPotentialBuffAttrModel? attributes;

  const OperatorPotentialBuffModel({this.attributes});

  factory OperatorPotentialBuffModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorPotentialBuffModelFromJson(json);

  @override
  List<Object?> get props => [attributes];
}

@JsonSerializable(createToJson: false)
class OperatorPotentialBuffAttrModel extends Equatable {
  // "abnormalFlags": null,
  // "abnormalImmunes": null,
  // "abnormalAntis": null,
  // "abnormalCombos": null,
  // "abnormalComboImmunes": null,
  final List<AttributeModifiersModel>? attributeModifiers;

  const OperatorPotentialBuffAttrModel({this.attributeModifiers});

  factory OperatorPotentialBuffAttrModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorPotentialBuffAttrModelFromJson(json);

  @override
  List<Object?> get props => [attributeModifiers];
}
// end of potentialRanks //

// favorKeyFrames //
@JsonSerializable(createToJson: false)
class OperatorFavorKeyFramesModel extends Equatable {
  final int level;
  final AttributeModel data;

  const OperatorFavorKeyFramesModel({
    required this.level,
    required this.data,
  });

  factory OperatorFavorKeyFramesModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorFavorKeyFramesModelFromJson(json);

  @override
  List<Object?> get props => [
        level,
        data,
      ];
}
// end of favorKeyFrames //

// allSkillLvlup //
@JsonSerializable(createToJson: false)
class OperatorAllSkillLvlupModel extends Equatable {
  final UnlockConditionModel unlockCond;
  final List<ItemCostModel> lvlUpCost;

  const OperatorAllSkillLvlupModel({
    required this.unlockCond,
    required this.lvlUpCost,
  });

  factory OperatorAllSkillLvlupModel.fromJson(Map<String, dynamic> json) =>
      _$OperatorAllSkillLvlupModelFromJson(json);

  @override
  List<Object?> get props => [
        unlockCond,
        lvlUpCost,
      ];
}
// end of allSkillLvlup //