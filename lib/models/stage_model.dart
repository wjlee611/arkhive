class StagesModel {
  final String? nameFirst, nameSecond;
  final bool isEvent;
  final int? open, close, shopClose;
  List<String> zones;

  StagesModel({
    this.nameFirst,
    this.nameSecond,
    required this.isEvent,
    this.open,
    this.close,
    this.shopClose,
    required this.zones,
  });

  void addZone({required String zone}) {
    zones.add(zone);
  }
}

class ZoneModel {
  final String? zoneId, type, zoneNameFirst, zoneNameSecond;

  ZoneModel.fromJson(Map<String, dynamic> json)
      : zoneId = json['zoneID'],
        type = json['type'],
        zoneNameFirst = json['zoneNameFirst'],
        zoneNameSecond = json['zoneNameSecond'];
}

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

class StageModel {
  final String? difficulty, zoneId, code, name, description;
  final int? apCost, apFailReturn;
  final StageRewordModel? stageDropInfo;
  final bool? isStoryOnly, isPredefined, isStagePatch;

  StageModel.fromJson(Map<String, dynamic> json)
      : difficulty = json['difficulty'],
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
          if (json['displayRewards'] != null)
            for (var reword in json['displayRewards'])
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

class StagesIndexingModel {
  Map<String, List<String>> zone;

  StagesIndexingModel.init() : zone = {};

  StagesIndexingModel.fromJson(Map<String, dynamic> json)
      : zone = {
          for (var key in json.keys)
            key: [
              for (var stage in json[key]) stage,
            ],
        };

  void setStages({
    required String zone,
    required List<String> stages,
  }) {
    this.zone[zone] = stages;
  }

  void addStage({
    required String zone,
    required String stage,
  }) {
    if (this.zone[zone] == null) this.zone[zone] = [];
    this.zone[zone]!.add(stage);
  }
}
