import 'dart:convert';
import 'dart:isolate';

import 'package:arkhive/bloc/stage/stage_data/stage_data_event.dart';
import 'package:arkhive/bloc/stage/stage_data/stage_data_state.dart';
import 'package:arkhive/models/stage/stage_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageDataBloc extends Bloc<StageDataEvent, StageDataState> {
  final Region dbRegion;

  StageDataBloc({
    required this.dbRegion,
  }) : super(const StageDataInitState()) {
    on<StageDataLoadEvent>(_stageDataLoadEventHandler);
  }

  Future<void> _stageDataLoadEventHandler(
    StageDataLoadEvent event,
    Emitter<StageDataState> emit,
  ) async {
    emit(const StageDataLoadingState());

    StageModel? stage;

    // Loading Stage
    try {
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot(dbRegion)}excel/stage_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeStageModel,
        [port.sendPort, jsonString, event.stageKey],
      );
      stage = await port.first;
      port.close();
    } catch (e) {
      emit(const StageDataErrorState(message: '스테이지'));
      return;
    }

    if (stage == null) {
      emit(const StageDataErrorState(message: '스테이지'));
      return;
    }

    emit(StageDataLoadedState(stage: stage));
  }

// Isolate
  static void _deserializeStageModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    String stageKey = args[2];

    Map<String, dynamic> jsonData = jsonDecode(jsonString)['stages'];
    sendPort.send(StageModel.fromJson(jsonData[stageKey]));
  }
}
