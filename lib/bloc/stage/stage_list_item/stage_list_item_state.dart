import 'package:arkhive/models/stage_list_model.dart';
import 'package:equatable/equatable.dart';

class StageListItemState extends Equatable {
  final Map<String, bool> zoneIsOpenMap;
  final Map<String, List<StageListModel>> zoneToStageMap;

  const StageListItemState({
    required this.zoneIsOpenMap,
    required this.zoneToStageMap,
  });

  StageListItemState.init()
      : zoneIsOpenMap = {},
        zoneToStageMap = {};

  StageListItemState toggleZoneIsOpen({
    required String zoneId,
  }) =>
      StageListItemState(
        zoneIsOpenMap: zoneIsOpenMap
          ..addAll({
            zoneId:
                zoneIsOpenMap[zoneId] == null ? true : !zoneIsOpenMap[zoneId]!,
          }),
        zoneToStageMap: zoneToStageMap,
      );

  StageListItemState addStages({
    required String zoneId,
    required List<StageListModel> stages,
  }) =>
      StageListItemState(
        zoneIsOpenMap: zoneIsOpenMap,
        zoneToStageMap: zoneToStageMap
          ..addAll({
            zoneId: stages,
          }),
      );

  @override
  List<Object?> get props => [zoneToStageMap];
}
