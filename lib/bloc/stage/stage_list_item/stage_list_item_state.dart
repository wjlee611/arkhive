import 'package:arkhive/models/stage_list_model.dart';
import 'package:equatable/equatable.dart';

class StageListItemState extends Equatable {
  final Map<String, bool> actIsOpenMap;
  final Map<String, List<StageListModel>> zoneToStageMap;

  const StageListItemState({
    required this.actIsOpenMap,
    required this.zoneToStageMap,
  });

  StageListItemState.init()
      : actIsOpenMap = {},
        zoneToStageMap = {};

  @override
  List<Object?> get props => [
        actIsOpenMap,
        zoneToStageMap,
      ];
}

class StageListItemInitState extends StageListItemState {
  StageListItemInitState() : super.init();

  @override
  List<Object?> get props => [
        actIsOpenMap,
        zoneToStageMap,
      ];
}

class StageListItemLoadingState extends StageListItemState {
  final String loadingActId;

  const StageListItemLoadingState({
    required this.loadingActId,
    required Map<String, bool> actIsOpenMap,
    required Map<String, List<StageListModel>> zoneToStageMap,
  }) : super(
          actIsOpenMap: actIsOpenMap,
          zoneToStageMap: zoneToStageMap,
        );

  @override
  List<Object?> get props => [
        loadingActId,
        actIsOpenMap,
        zoneToStageMap,
      ];
}

class StageListItemLoadedState extends StageListItemState {
  final String loadedActId;

  const StageListItemLoadedState({
    required this.loadedActId,
    required Map<String, bool> actIsOpenMap,
    required Map<String, List<StageListModel>> zoneToStageMap,
  }) : super(
          actIsOpenMap: actIsOpenMap,
          zoneToStageMap: zoneToStageMap,
        );

  @override
  List<Object?> get props => [
        loadedActId,
        actIsOpenMap,
        zoneToStageMap,
      ];
}
