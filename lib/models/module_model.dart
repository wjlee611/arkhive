import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/models/operator_model.dart';

class ModuleModel {
  final String? uniEquipId, uniEquipName, uniEquipIcon, typeIcon, charId;
  final List<String> missionList;
  final Map<String, List<EvolveCostModel>> itemCost;

  ModuleModel.fromJson(Map<String, dynamic> json)
      : uniEquipId = json['uniEquipId'],
        uniEquipName = json['uniEquipName'],
        uniEquipIcon = json['uniEquipIcon'],
        typeIcon = json['typeIcon'],
        charId = json['charId'],
        missionList = [
          if (json['missionList'] != null)
            for (var data in json['missionList']) data
        ],
        itemCost = {
          if (json['itemCost'] != null)
            for (var key in json['itemCost'].keys)
              key: [
                for (var data in json['itemCost'][key])
                  EvolveCostModel.fromJson(data)
              ]
        };
}

class ModuleMissionModel {
  final String? desc, jumpStageId;

  ModuleMissionModel.fromJson(Map<String, dynamic> json)
      : desc = json['desc'],
        jumpStageId = json['jumpStageId'];
}

// MODULE SPEC DATA
class ModuleDataModel {
  final List<ModuleDataPhaseModel> phases;

  ModuleDataModel.fromJson(Map<String, dynamic> json)
      : phases = [
          if (json['phases'] != null)
            for (var data in json['phases']) ModuleDataPhaseModel.fromJson(data)
        ];
}

class ModuleDataPhaseModel {
  final int? equipLevel;
  final List<ModuleDataPartsModel> parts;
  final List<BlackboardModel> attributeBlackboard;

  ModuleDataPhaseModel.fromJson(Map<String, dynamic> json)
      : equipLevel = json['equipLevel'],
        parts = [
          if (json['parts'] != null)
            for (var data in json['parts']) ModuleDataPartsModel.fromJson(data)
        ],
        attributeBlackboard = [
          if (json['attributeBlackboard'] != null)
            for (var data in json['attributeBlackboard'])
              BlackboardModel.fromJson(data)
        ];
}

class ModuleDataPartsModel {
  final String? target;
  final List<ModuleTalentDataBundleModel> addOrOverrideTalentDataBundle;
  final List<ModuleTraitDataBundleModel> overrideTraitDataBundle;

  ModuleDataPartsModel.fromJson(Map<String, dynamic> json)
      : target = json['target'],
        addOrOverrideTalentDataBundle = [
          if (json['addOrOverrideTalentDataBundle']['candidates'] != null)
            for (var data in json['addOrOverrideTalentDataBundle']
                ['candidates'])
              ModuleTalentDataBundleModel.fromJson(data)
        ],
        overrideTraitDataBundle = [
          if (json['overrideTraitDataBundle']['candidates'] != null)
            for (var data in json['overrideTraitDataBundle']['candidates'])
              ModuleTraitDataBundleModel.fromJson(data)
        ];
}

class ModuleTalentDataBundleModel implements PotentialRank {
  final String? upgradeDescription, name;
  final int? talentIndex;
  @override
  final int? requiredPotentialRank;
  @override
  final OperatorUnlockCondModel unlockCondition;
  final List<BlackboardModel> blackboard;

  ModuleTalentDataBundleModel.fromJson(Map<String, dynamic> json)
      : upgradeDescription = json['upgradeDescription'],
        talentIndex = json['talentIndex'],
        unlockCondition =
            OperatorUnlockCondModel.fromJson(json['unlockCondition'] ?? {}),
        requiredPotentialRank = json['requiredPotentialRank'],
        name = json['name'],
        blackboard = [
          if (json['blackboard'] != null)
            for (var data in json['blackboard']) BlackboardModel.fromJson(data)
        ];
}

class ModuleTraitDataBundleModel implements PotentialRank {
  final String? additionalDescription;
  @override
  final OperatorUnlockCondModel unlockCondition;
  @override
  final int? requiredPotentialRank;
  final List<BlackboardModel> blackboard;

  ModuleTraitDataBundleModel.fromJson(Map<String, dynamic> json)
      : additionalDescription = json['additionalDescription'],
        unlockCondition =
            OperatorUnlockCondModel.fromJson(json['unlockCondition'] ?? {}),
        requiredPotentialRank = json['requiredPotentialRank'],
        blackboard = [
          if (json['blackboard'] != null)
            for (var data in json['blackboard']) BlackboardModel.fromJson(data)
        ];
}
