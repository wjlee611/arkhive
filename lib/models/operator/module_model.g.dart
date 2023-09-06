// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleModel _$ModuleModelFromJson(Map<String, dynamic> json) => ModuleModel(
      uniEquipId: json['uniEquipId'] as String?,
      uniEquipName: json['uniEquipName'] as String?,
      uniEquipIcon: json['uniEquipIcon'] as String?,
      uniEquipDesc: json['uniEquipDesc'] as String?,
      typeIcon: json['typeIcon'] as String?,
      typeName1: json['typeName1'] as String?,
      typeName2: json['typeName2'] as String?,
      equipShiningColor: json['equipShiningColor'] as String?,
      showEvolvePhase: fromJsonToString(json['showEvolvePhase']),
      unlockEvolvePhase: fromJsonToString(json['unlockEvolvePhase']),
      charId: json['charId'] as String?,
      tmplId: json['tmplId'] as String?,
      showLevel: json['showLevel'] as int?,
      unlockLevel: json['unlockLevel'] as int?,
      unlockFavorPoint: json['unlockFavorPoint'] as int?,
      missionList: (json['missionList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      itemCost: (json['itemCost'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => ItemCostModel.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      type: json['type'] as String?,
      uniEquipGetTime: json['uniEquipGetTime'] as int?,
      charEquipOrder: json['charEquipOrder'] as int?,
    );

ModuleDataModel _$ModuleDataModelFromJson(Map<String, dynamic> json) =>
    ModuleDataModel(
      phases: (json['phases'] as List<dynamic>)
          .map((e) => ModuleDataPhasesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ModuleDataPhasesModel _$ModuleDataPhasesModelFromJson(
        Map<String, dynamic> json) =>
    ModuleDataPhasesModel(
      equipLevel: json['equipLevel'] as int?,
      parts: (json['parts'] as List<dynamic>?)
          ?.map((e) => ModuleDataPartsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributeBlackboard: (json['attributeBlackboard'] as List<dynamic>?)
          ?.map(
              (e) => TalentBlackboardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ModuleDataPartsModel _$ModuleDataPartsModelFromJson(
        Map<String, dynamic> json) =>
    ModuleDataPartsModel(
      resKey: json['resKey'] as String?,
      target: json['target'] as String?,
      isToken: json['isToken'] as bool?,
      addOrOverrideTalentDataBundle: json['addOrOverrideTalentDataBundle'] ==
              null
          ? null
          : ModuleDataTalentBundleModel.fromJson(
              json['addOrOverrideTalentDataBundle'] as Map<String, dynamic>),
      overrideTraitDataBundle: json['overrideTraitDataBundle'] == null
          ? null
          : ModuleDataTraitBundleModel.fromJson(
              json['overrideTraitDataBundle'] as Map<String, dynamic>),
    );

ModuleDataTalentBundleModel _$ModuleDataTalentBundleModelFromJson(
        Map<String, dynamic> json) =>
    ModuleDataTalentBundleModel(
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((e) => ModuleDataTalentCandidateModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

ModuleDataTalentCandidateModel _$ModuleDataTalentCandidateModelFromJson(
        Map<String, dynamic> json) =>
    ModuleDataTalentCandidateModel(
      unlockCondition: UnlockConditionModel.fromJson(
          json['unlockCondition'] as Map<String, dynamic>),
      requiredPotentialRank: json['requiredPotentialRank'] as int,
      displayRangeId: json['displayRangeId'] as bool?,
      upgradeDescription: json['upgradeDescription'] as String?,
      talentIndex: json['talentIndex'] as int?,
      prefabKey: json['prefabKey'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      rangeId: json['rangeId'] as String?,
      blackboard: (json['blackboard'] as List<dynamic>?)
          ?.map(
              (e) => TalentBlackboardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ModuleDataTraitBundleModel _$ModuleDataTraitBundleModelFromJson(
        Map<String, dynamic> json) =>
    ModuleDataTraitBundleModel(
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((e) =>
              ModuleDataTraitCandidateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ModuleDataTraitCandidateModel _$ModuleDataTraitCandidateModelFromJson(
        Map<String, dynamic> json) =>
    ModuleDataTraitCandidateModel(
      unlockCondition: UnlockConditionModel.fromJson(
          json['unlockCondition'] as Map<String, dynamic>),
      requiredPotentialRank: json['requiredPotentialRank'] as int,
      additionalDescription: json['additionalDescription'] as String?,
      blackboard: (json['blackboard'] as List<dynamic>?)
          ?.map(
              (e) => TalentBlackboardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      overrideDescripton: json['overrideDescripton'] as String?,
      prefabKey: json['prefabKey'] as String?,
      rangeId: json['rangeId'] as String?,
    );
