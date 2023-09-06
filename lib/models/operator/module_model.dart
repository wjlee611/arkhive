import 'package:arkhive/interface/candidates_interface.dart';
import 'package:arkhive/models/common/item_cost_model.dart';
import 'package:arkhive/models/common/talent_blackboard_model.dart';
import 'package:arkhive/models/common/unlock_condition_model.dart';
import 'package:arkhive/tools/modeling_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'module_model.g.dart';

@JsonSerializable(createToJson: false)
class ModuleModel extends Equatable {
  final String? uniEquipId;
  final String? uniEquipName;
  final String? uniEquipIcon;
  final String? uniEquipDesc;
  final String? typeIcon;
  final String? typeName1;
  final String? typeName2;
  final String? equipShiningColor;
  @JsonKey(fromJson: fromJsonToString)
  final String? showEvolvePhase;
  @JsonKey(fromJson: fromJsonToString)
  final String? unlockEvolvePhase;
  final String? charId;
  final String? tmplId;
  final int? showLevel;
  final int? unlockLevel;
  final int? unlockFavorPoint;
  final List<String>? missionList;
  final Map<String, List<ItemCostModel>>? itemCost;
  final String? type;
  final int? uniEquipGetTime;
  final int? charEquipOrder;

  const ModuleModel({
    this.uniEquipId,
    this.uniEquipName,
    this.uniEquipIcon,
    this.uniEquipDesc,
    this.typeIcon,
    this.typeName1,
    this.typeName2,
    this.equipShiningColor,
    this.showEvolvePhase,
    this.unlockEvolvePhase,
    this.charId,
    this.tmplId,
    this.showLevel,
    this.unlockLevel,
    this.unlockFavorPoint,
    this.missionList,
    this.itemCost,
    this.type,
    this.uniEquipGetTime,
    this.charEquipOrder,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);

  @override
  List<Object?> get props => [
        uniEquipId,
        uniEquipName,
        uniEquipIcon,
        uniEquipDesc,
        typeIcon,
        typeName1,
        typeName2,
        equipShiningColor,
        showEvolvePhase,
        unlockEvolvePhase,
        charId,
        tmplId,
        showLevel,
        unlockLevel,
        unlockFavorPoint,
        missionList,
        itemCost,
        type,
        uniEquipGetTime,
        charEquipOrder,
      ];
}

/// Module Data below ///
@JsonSerializable(createToJson: false)
class ModuleDataModel extends Equatable {
  final List<ModuleDataPhasesModel> phases;

  const ModuleDataModel({required this.phases});

  factory ModuleDataModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleDataModelFromJson(json);

  @override
  List<Object?> get props => [phases];
}

@JsonSerializable(createToJson: false)
class ModuleDataPhasesModel extends Equatable {
  final int? equipLevel;
  final List<ModuleDataPartsModel>? parts;
  final List<TalentBlackboardModel>? attributeBlackboard;
  // "tokenAttributeBlackboard": {}

  const ModuleDataPhasesModel({
    this.equipLevel,
    this.parts,
    this.attributeBlackboard,
  });

  factory ModuleDataPhasesModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleDataPhasesModelFromJson(json);

  @override
  List<Object?> get props => [
        equipLevel,
        parts,
        attributeBlackboard,
      ];
}

@JsonSerializable(createToJson: false)
class ModuleDataPartsModel extends Equatable {
  final String? resKey;
  final String? target;
  final bool? isToken;
  final ModuleDataTalentBundleModel? addOrOverrideTalentDataBundle;
  final ModuleDataTraitBundleModel? overrideTraitDataBundle;

  const ModuleDataPartsModel({
    this.resKey,
    this.target,
    this.isToken,
    this.addOrOverrideTalentDataBundle,
    this.overrideTraitDataBundle,
  });

  factory ModuleDataPartsModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleDataPartsModelFromJson(json);

  @override
  List<Object?> get props => [
        resKey,
        target,
        isToken,
        addOrOverrideTalentDataBundle,
        overrideTraitDataBundle,
      ];
}

@JsonSerializable(createToJson: false)
class ModuleDataTalentBundleModel extends Equatable {
  final List<ModuleDataTalentCandidateModel>? candidates;

  const ModuleDataTalentBundleModel({this.candidates});

  factory ModuleDataTalentBundleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleDataTalentBundleModelFromJson(json);

  @override
  List<Object?> get props => [candidates];
}

@JsonSerializable(createToJson: false)
class ModuleDataTalentCandidateModel extends Equatable implements ICandidate {
  @override
  final UnlockConditionModel unlockCondition;
  @override
  final int requiredPotentialRank;
  final bool? displayRangeId;
  final String? upgradeDescription;
  final int? talentIndex;
  final String? prefabKey;
  final String? name;
  final String? description;
  final String? rangeId;
  final List<TalentBlackboardModel>? blackboard;

  const ModuleDataTalentCandidateModel({
    required this.unlockCondition,
    required this.requiredPotentialRank,
    this.displayRangeId,
    this.upgradeDescription,
    this.talentIndex,
    this.prefabKey,
    this.name,
    this.description,
    this.rangeId,
    this.blackboard,
  });

  factory ModuleDataTalentCandidateModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleDataTalentCandidateModelFromJson(json);

  @override
  List<Object?> get props => [
        unlockCondition,
        requiredPotentialRank,
        displayRangeId,
        upgradeDescription,
        talentIndex,
        prefabKey,
        name,
        description,
        rangeId,
        blackboard,
      ];
}

@JsonSerializable(createToJson: false)
class ModuleDataTraitBundleModel extends Equatable {
  final List<ModuleDataTraitCandidateModel>? candidates;

  const ModuleDataTraitBundleModel({this.candidates});

  factory ModuleDataTraitBundleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleDataTraitBundleModelFromJson(json);

  @override
  List<Object?> get props => [candidates];
}

@JsonSerializable(createToJson: false)
class ModuleDataTraitCandidateModel extends Equatable implements ICandidate {
  @override
  final UnlockConditionModel unlockCondition;
  @override
  final int requiredPotentialRank;
  final String? additionalDescription;
  final List<TalentBlackboardModel>? blackboard;
  final String? overrideDescripton;
  final String? prefabKey;
  final String? rangeId;

  const ModuleDataTraitCandidateModel({
    required this.unlockCondition,
    required this.requiredPotentialRank,
    this.additionalDescription,
    this.blackboard,
    this.overrideDescripton,
    this.prefabKey,
    this.rangeId,
  });

  factory ModuleDataTraitCandidateModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleDataTraitCandidateModelFromJson(json);

  @override
  List<Object?> get props => [
        unlockCondition,
        requiredPotentialRank,
        additionalDescription,
        blackboard,
        overrideDescripton,
        prefabKey,
        rangeId,
      ];
}
