import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_event.dart';
import 'package:arkhive/bloc/item/stage_penguin/stage_penguin_state.dart';
import 'package:arkhive/models/base/penguin_model.dart';
import 'package:arkhive/enums/common_load_state.dart';
import 'package:arkhive/models/item/item_model.dart';
import 'package:arkhive/models/stage/stage_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StagePenguinBloc extends Bloc<StagePenguinEvent, StagePenguinState> {
  final Region dbRegion;
  final StageModel stage;

  List<PenguinModel> _penguins = [];

  StagePenguinBloc({
    required this.dbRegion,
    required this.stage,
  }) : super(const StagePenguinState(status: CommonLoadState.init)) {
    on<StagePenguinInitEvent>(_stagePenguinInitEventHandler);
  }

  Future<void> _stagePenguinInitEventHandler(
    StagePenguinInitEvent event,
    Emitter<StagePenguinState> emit,
  ) async {
    emit(state.copyWith(
      status: CommonLoadState.loading,
    ));

    _penguins = event.penguinSrc;

    try {
      // loading item data
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot(dbRegion)}excel/item_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeItemModel,
        [port.sendPort, jsonString],
      );
      Map<String, ItemModel> items = await port.first;
      port.close();

      // analyse
      // from ingame data - 첫 드랍(2: 일반, 3: 특수, 4: 추가 제외) 정보
      List<PenguinStageModel> result = [];
      for (var item in stage.stageDropInfo.displayDetailRewards) {
        if (item.dropType == '3' || item.dropType == '4') {
          continue;
        }

        var name = items[item.id]?.name ?? item.id;
        if (name.contains('furni') == true) {
          name = '이벤트 가구';
        }

        bool isIcon = false;
        if (['MATERIAL', 'DIAMOND', 'CARD_EXP', 'GOLD']
            .contains(items[item.id]?.itemType)) {
          isIcon = true;
        }

        result.add(PenguinStageModel(
          iconId: isIcon ? items[item.id]?.iconId : null,
          name: name,
          isFirstDrop: true,
          sanityx1000: 0,
        ));

        if (item.type == 'ACTIVITY_ITEM' && stage.difficulty == 'NORMAL') {
          result.add(PenguinStageModel(
            iconId: isIcon ? items[item.id]?.iconId : null,
            name: name,
            sanityx1000: 1000,
            ratex1000: (stage.apCost) * 1000,
          ));
        }
      }

      // from penguin data - 확률 드랍 정보
      int? times;
      for (var penguin in _penguins) {
        var sanity = stage.apCost;
        var rate = (penguin.quantity ?? 0.00001) / (penguin.times ?? 1);
        var sanityEffx1000 = (sanity / rate * 1000).ceil();

        if (penguin.itemId?.contains('furni') == true) continue;
        if (penguin.itemId?.contains('ap_supply') == true) continue;

        times = times ?? penguin.times;

        bool isIcon = false;

        if (['MATERIAL', 'DIAMOND', 'CARD_EXP']
            .contains(items[penguin.itemId]?.itemType)) {
          isIcon = true;
        }

        result.add(PenguinStageModel(
          penguin: penguin,
          iconId: isIcon ? items[penguin.itemId]?.iconId : null,
          name: items[penguin.itemId]?.name ?? penguin.itemId,
          sanityx1000: sanityEffx1000,
          ratex1000: (rate * 1000).ceil(),
          times: penguin.times,
        ));
      }

      // sort
      result.sort((a, b) => (a.sanityx1000 ?? double.infinity)
          .compareTo((b.sanityx1000 ?? double.infinity)));

      emit(state.copyWith(
        sortedPenguin: result,
        times: times,
        status: CommonLoadState.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CommonLoadState.error,
      ));
    }
  }

  // Isolate
  static void _deserializeItemModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];

    Map<String, dynamic> stagesData = jsonDecode(jsonString)['items'];
    Map<String, ItemModel> result = {};
    for (var stageData in stagesData.entries) {
      result[stageData.key] = ItemModel.fromJson(stageData.value);
    }

    Isolate.exit(sendPort, result);
  }
}
