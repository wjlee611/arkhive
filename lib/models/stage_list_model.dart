// 메인, 이벤트, 파밍, 섬멸전, 보안파견, ...

class CategoryListModel {
  final String category;
  final String type; // MAINLINE, WEEKLY, ACTIVITY, ...
  Map<String, ActivityListModel> activityMap;

  CategoryListModel({
    required this.category,
    required this.type,
    required this.activityMap,
  });

  void addActivity(ActivityListModel activity) {
    activityMap[activity.actIds] = activity;
  }

  void addZone({
    required String targetAct,
    required ZoneListModel zone,
  }) {
    activityMap[targetAct]?.addZone(zone);
  }
}

// 스툴티페라 나비스, ...
class ActivityListModel {
  final String title; // 언더 타이즈
  final String actIds; // act18d3(언더 타이즈), act11sre(언더 타이즈 재개방)
  final List<StageTimeStampModel> timeStamps; // 각 이벤트 시작, 종료, 상점 개방일
  List<ZoneListModel> zones; // 그랑파로, ...
  final bool isOpen; // track folder open (for sliver widget)

  ActivityListModel({
    required this.title,
    required this.actIds,
    required this.timeStamps,
    required this.zones,
    this.isOpen = false,
  });

  ActivityListModel copyWith({
    String? title,
    String? actIds,
    List<StageTimeStampModel>? timeStamps,
    List<ZoneListModel>? zones,
    bool? isOpen,
  }) =>
      ActivityListModel(
        title: title ?? this.title,
        actIds: actIds ?? this.actIds,
        timeStamps: timeStamps ?? this.timeStamps,
        zones: zones ?? this.zones,
        isOpen: isOpen ?? this.isOpen,
      );

  void addZone(ZoneListModel zone) {
    zones.add(zone);
  }
}

class ZoneListModel {
  final String title;
  final String zoneId;
  final String type;
  final List<StageListModel> stages; // SV-1, SV-2, ...

  ZoneListModel({
    required this.title,
    required this.zoneId,
    required this.type,
    required this.stages,
  });
}

// SN-1, SN-2, ...
class StageListModel {
  final String stageId;
  final String zoneId; // act17side_zone1, 2, ... (for grouping)
  final String code, name;
  final String difficulty; // NORMAL, FOUR_STAR
  final String diffGroup; // EASY, NORMAL, TOUGH

  StageListModel({
    required this.stageId,
    required this.zoneId,
    required this.code,
    required this.name,
    required this.difficulty,
    required this.diffGroup,
  });
}

class StageTimeStampModel {
  final int startTime, endTime, rewardEndTime;

  StageTimeStampModel({
    required this.startTime,
    required this.endTime,
    required this.rewardEndTime,
  });
}
