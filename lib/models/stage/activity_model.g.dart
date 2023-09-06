// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      id: json['id'] as String,
      type: json['type'] as String,
      displayType: json['displayType'] as String?,
      name: json['name'] as String,
      startTime: json['startTime'] as int,
      endTime: json['endTime'] as int,
      rewardEndTime: json['rewardEndTime'] as int,
      displayOnHome: json['displayOnHome'] as bool,
      hasStage: json['hasStage'] as bool,
      templateShopId: json['templateShopId'] as String?,
      medalGroupId: json['medalGroupId'] as String?,
      ungroupedMedalIds: (json['ungroupedMedalIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isReplicate: json['isReplicate'] as bool,
      needFixedSync: json['needFixedSync'] as bool?,
    );
