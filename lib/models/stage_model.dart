class ActivityModel {
  final String? id, name;
  final int? startTime, endTime, rewardEndTime;
  final bool? hasStage, isReplicate;

  ActivityModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        rewardEndTime = json['rewardEndTime'],
        hasStage = json['hasStage'],
        isReplicate = json['isReplicate'];
}

class ZoneModel {
  final String? zoneId, type, zoneNameFirst, zoneNameSecond;

  ZoneModel.fromJson(Map<String, dynamic> json)
      : zoneId = json['zoneID'],
        type = json['type'],
        zoneNameFirst = json['zoneNameFirst'],
        zoneNameSecond = json['zoneNameSecond'];
}

class StageModel {
  final String? stageType,
      stageId,
      difficulty,
      diffGroup,
      zoneId,
      code,
      name,
      description;
  final int? apCost, apFailReturn;
  final StageRewordModel? stageDropInfo;
  final bool? isStoryOnly, isPredefined, isStagePatch;

  StageModel.fromJson(Map<String, dynamic> json)
      : stageType = json['stageType'],
        stageId = json['stageId'],
        difficulty = json['difficulty'],
        diffGroup = json['diffGroup'],
        zoneId = json['zoneId'],
        code = json['code'],
        name = json['name'],
        description = json['description'],
        apCost = json['apCost'],
        apFailReturn = json['apFailReturn'],
        stageDropInfo = StageRewordModel.fromJson(json['stageDropInfo']),
        isStoryOnly = json['isStoryOnly'],
        isPredefined = json['isPredefined'],
        isStagePatch = json['isStagePatch'];
}

class StageRewordModel {
  final List<StageItemModel> rewords;

  StageRewordModel.fromJson(Map<String, dynamic> json)
      : rewords = [
          if (json['displayDetailRewards'] != null)
            for (var reword in json['displayDetailRewards'])
              StageItemModel.fromJson(reword)
        ];
}

class StageItemModel {
  final String? type, id;
  final int? dropType;

  StageItemModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        id = json['id'],
        dropType = json['dropType'];
}
