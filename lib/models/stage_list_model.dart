// For StageListBloc //
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
    activityMap[activity.actId] = activity;
  }

  void addZone({
    required String targetAct,
    required ZoneListModel zone,
  }) {
    activityMap[targetAct]?.zones.add(zone);
  }
}

// 스툴티페라 나비스, ...
class ActivityListModel {
  final String title; // 언더 타이즈
  final String actId; // act18d3(언더 타이즈), act11sre(언더 타이즈 재개방)
  final StageTimeStampModel? timeStamps; // 각 이벤트 시작, 종료, 상점 개방일
  List<ZoneListModel> zones; // 그랑파로, ...

  ActivityListModel({
    required this.title,
    required this.actId,
    this.timeStamps,
    required this.zones,
  });

  ActivityListModel copyWith({
    String? title,
    String? actId,
    StageTimeStampModel? timeStamps,
    List<ZoneListModel>? zones,
  }) =>
      ActivityListModel(
        title: title ?? this.title,
        actId: actId ?? this.actId,
        timeStamps: timeStamps ?? this.timeStamps,
        zones: zones ?? this.zones,
      );
}

class ZoneListModel {
  final String title;
  final String zoneId;
  final String type;

  ZoneListModel({
    required this.title,
    required this.zoneId,
    required this.type,
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

// For StageListItemBloc //
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
