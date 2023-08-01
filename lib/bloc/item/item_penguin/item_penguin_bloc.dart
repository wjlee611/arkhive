import 'dart:convert';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_event.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_state.dart';
import 'package:arkhive/models/base/penguin_model.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/models/stage_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemPenguinBloc extends Bloc<ItemPenguinEvent, ItemPenguinState> {
  final List<PenguinModel> _penguins;

  ItemPenguinBloc(this._penguins)
      : super(const ItemPenguinState(status: CommonLoadState.init)) {
    on<ItemPenguinSanitySortEvent>(_itemPenguinSanitySortEventHandler);
    // on<ItemPenguinRateSortEvent>(_itemPenguinRateSortEventHandler);
    // on<ItemPenguinTimesSortEvent>(_itemPenguinTimesSortEventHandler);
  }

  Future<void> _itemPenguinSanitySortEventHandler(
    ItemPenguinSanitySortEvent event,
    Emitter<ItemPenguinState> emit,
  ) async {
    emit(ItemPenguinState(
      sortedPenguin: state.sortedPenguin,
      status: CommonLoadState.loading,
    ));

    try {
      // loading stage data
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/stage_table.json');

      Map<String, dynamic> stagesData = await json.decode(jsonString)['stages'];
      Map<String, StageModel> stages = {};
      for (var stageData in stagesData.entries) {
        stages[stageData.key] = StageModel.fromJson(stageData.value);
      }

      // analyse
      List<PenguinSortModel> result = [];
      for (var penguin in _penguins) {
        var stageId = penguin.stageId?.replaceAll('_perm', '');

        var sanity = stages[stageId]?.apCost ?? 99;
        var rate = (penguin.quantity ?? 0.00001) / (penguin.times ?? 1);
        var sanityEffx1000 = (sanity / rate * 1000).ceil();

        if (sanityEffx1000 <= 0) continue;
        if (stages[stageId]?.code == null) continue;

        result.add(PenguinSortModel(
          penguin: penguin,
          stageCode: stages[stageId]?.code,
          sanityx1000: sanityEffx1000,
        ));
      }

      // sort
      result.sort((a, b) => a.sanityx1000!.compareTo(b.sanityx1000!));

      emit(ItemPenguinState(
        sortedPenguin: result,
        status: CommonLoadState.loaded,
      ));
    } catch (e) {
      emit(ItemPenguinState(
        sortedPenguin: state.sortedPenguin,
        status: CommonLoadState.error,
      ));
    }
  }
}
