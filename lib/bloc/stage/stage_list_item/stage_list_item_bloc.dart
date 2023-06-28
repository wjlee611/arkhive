import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_event.dart';
import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_state.dart';
import 'package:arkhive/models/stage_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageListItemBloc extends Bloc<StageListItemEvent, StageListItemState> {
  StageListItemBloc() : super(StageListItemState.init()) {
    on<StageListItemOnTabEvent>(_stageListItemOnTabEventHandler);
  }

  Future<void> _stageListItemOnTabEventHandler(
    StageListItemOnTabEvent event,
    Emitter<StageListItemState> emit,
  ) async {
    // 처음 여는 경우
    if (state.zoneToStageMap[event.zoneId] == null) {
      List<StageListModel> stages = [];
      // TODO: Get stages
      emit(state.addStages(
        zoneId: event.zoneId,
        stages: stages,
      ));
    }

    emit(state.toggleZoneIsOpen(zoneId: event.zoneId));
  }
}
