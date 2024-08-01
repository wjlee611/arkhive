// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StageModel _$StageModelFromJson(Map<String, dynamic> json) => StageModel(
      stageType: json['stageType'] as String,
      stageId: json['stageId'] as String,
      difficulty: json['difficulty'] as String,
      diffGroup: json['diffGroup'] as String,
      zoneId: json['zoneId'] as String,
      code: json['code'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      apCost: (json['apCost'] as num).toInt(),
      apFailReturn: (json['apFailReturn'] as num).toInt(),
      stageDropInfo: StageDropInfoModel.fromJson(
          json['stageDropInfo'] as Map<String, dynamic>),
      isStoryOnly: json['isStoryOnly'] as bool,
      isPredefined: json['isPredefined'] as bool,
      isStagePatch: json['isStagePatch'] as bool,
    );

StageDropInfoModel _$StageDropInfoModelFromJson(Map<String, dynamic> json) =>
    StageDropInfoModel(
      displayDetailRewards: (json['displayDetailRewards'] as List<dynamic>)
          .map((e) => StageItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

StageItemModel _$StageItemModelFromJson(Map<String, dynamic> json) =>
    StageItemModel(
      occPercent: fromJsonToString(json['occPercent']),
      type: json['type'] as String,
      id: json['id'] as String,
      dropType: fromJsonToString(json['dropType']),
    );
