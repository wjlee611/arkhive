import 'dart:convert';
import 'dart:isolate';

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

        ReceivePort port = ReceivePort();
        await Isolate.spawn(
          _deserializeZoneToStages,
          [port.sendPort, jsonString, event.zones],
        );
        zoneToStages = await port.first;
        port.close();
      } catch (_) {}

      emit(StageListItemLoadedState(
        loadedActId: event.actId,
        actIsOpenMap: state.actIsOpenMap,
        zoneToStageMap: state.zoneToStageMap..addAll(zoneToStages),
      ));
    }
  }

  static void _deserializeZoneToStages(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    List<ZoneListModel> zones = args[2];
    Map<String, List<StageListModel>> result = {};

    Map<String, dynamic> jsonData = jsonDecode(jsonString)['stages'];

    for (var stage in jsonData.values) {
      var stageModel = StageModel.fromJson(stage);
      if (stageModel.zoneId == null) continue;
      // stageModel.isPredefined 는 일단 제외
      if (stageModel.isStagePatch == true || stageModel.isStoryOnly == true) {
        continue;
      }

      String zoneIdKey = stageModel.zoneId!;
      if (stageModel.stageType == 'MAIN') {
        zoneIdKey = '${stageModel.zoneId!}_${stageModel.diffGroup!}';
      }

      if (zones.any((zone) => zone.zoneId == zoneIdKey)) {
        if (result[zoneIdKey] == null) {
          result[zoneIdKey] = [];
        }
        result[zoneIdKey]!.add(
          StageListModel(
            stageId: stageModel.stageId!,
            zoneId: zoneIdKey,
            code: stageModel.code!,
            name: stageModel.name!,
            difficulty: stageModel.difficulty!,
            diffGroup: stageModel.diffGroup!,
          ),
        );
      }
    }

    sendPort.send(result);
  }
}
