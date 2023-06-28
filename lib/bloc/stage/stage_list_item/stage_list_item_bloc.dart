import 'dart:convert';

import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_event.dart';
import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_state.dart';
import 'package:arkhive/models/stage_list_model.dart';
import 'package:arkhive/models/stage_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageListItemBloc extends Bloc<StageListItemEvent, StageListItemState> {
  StageListItemBloc() : super(StageListItemInitState()) {
    on<StageListItemOnTabEvent>(_stageListItemOnTabEventHandler);
  }

  Future<void> _stageListItemOnTabEventHandler(
    StageListItemOnTabEvent event,
    Emitter<StageListItemState> emit,
  ) async {
    emit(StageListItemLoadedState(
      loadedActId: event.actId,
      actIsOpenMap: state.actIsOpenMap
        ..addAll({
          event.actId: state.actIsOpenMap[event.actId] == null
              ? true
              : !state.actIsOpenMap[event.actId]!,
        }),
      zoneToStageMap: state.zoneToStageMap,
    ));

    // 처음 여는 경우
    if (event.zones.any((zone) => state.zoneToStageMap[zone.zoneId] == null)) {
      emit(StageListItemLoadingState(
        loadingActId: event.actId,
        actIsOpenMap: state.actIsOpenMap,
        zoneToStageMap: state.zoneToStageMap,
      ));

      Map<String, List<StageListModel>> zoneToStages = {};

      try {
        String jsonString = await rootBundle
            .loadString('${getGameDataRoot()}excel/stage_table.json');
        Map<String, dynamic> jsonData = await json.decode(jsonString)['stages'];

        for (var stage in jsonData.values) {
          var stageModel = StageModel.fromJson(stage);
          if (stageModel.zoneId == null) continue;

          if (event.zones.any((zone) => zone.zoneId == stageModel.zoneId)) {
            if (zoneToStages[stageModel.zoneId] == null) {
              zoneToStages[stageModel.zoneId!] = [];
            }
            zoneToStages[stageModel.zoneId]!.add(
              StageListModel(
                stageId: stageModel.stageId!,
                zoneId: stageModel.zoneId!,
                code: stageModel.code!,
                name: stageModel.name!,
                difficulty: stageModel.difficulty!,
                diffGroup: stageModel.diffGroup!,
              ),
            );
          }
        }
      } catch (_) {}
      emit(StageListItemLoadedState(
        loadedActId: event.actId,
        actIsOpenMap: state.actIsOpenMap,
        zoneToStageMap: state.zoneToStageMap..addAll(zoneToStages),
      ));
    }
  }
}
