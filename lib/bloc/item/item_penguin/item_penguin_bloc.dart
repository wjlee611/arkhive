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
    on<ItemPenguinRateSortEvent>(_itemPenguinRateSortEventHandler);
    on<ItemPenguinTimesSortEvent>(_itemPenguinTimesSortEventHandler);
    on<ItemPenguinToggleEvent>(_itemPenguinToggleEventHandler);
  }

  Future<void> _itemPenguinSanitySortEventHandler(
    ItemPenguinSanitySortEvent event,
    Emitter<ItemPenguinState> emit,
  ) async {
    emit(state.copyWith(
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
        var sanity = stages[penguin.stageId]?.apCost ?? 99;
        var rate = (penguin.quantity ?? 0.00001) / (penguin.times ?? 1);
        var sanityEffx1000 = (sanity / rate * 1000).ceil();

        if (sanityEffx1000 <= 0) continue;
        if (stages[penguin.stageId]?.code == null) continue;

        result.add(PenguinSortModel(
          penguin: penguin,
          stageCode: stages[penguin.stageId]?.code,
          diffGroup: stages[penguin.stageId]?.diffGroup,
          stageType: stages[penguin.stageId]?.stageType,
          sanityx1000: sanityEffx1000,
        ));
      }

      // sort
      result.sort((a, b) => a.sanityx1000!.compareTo(b.sanityx1000!));

      emit(state.copyWith(
        sortOption: PenguinSortOption.sanity,
        sortedPenguin: result,
      ));

      // filter
      _itemPenguinToggleEventHandler(
        ItemPenguinToggleEvent(isIncludePerm: state.isIncludePerm),
        emit,
      );
    } catch (e) {
      emit(ItemPenguinState(
        sortedPenguin: state.sortedPenguin,
        status: CommonLoadState.error,
      ));
    }
  }

  Future<void> _itemPenguinRateSortEventHandler(
    ItemPenguinRateSortEvent event,
    Emitter<ItemPenguinState> emit,
  ) async {
    emit(state.copyWith(
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
        var sanity = stages[penguin.stageId]?.apCost ?? 99;
        var rate = (penguin.quantity ?? 0.00001) / (penguin.times ?? 1);

        if (sanity <= 0) continue;
        if (stages[penguin.stageId]?.code == null) continue;

        result.add(PenguinSortModel(
          penguin: penguin,
          stageCode: stages[penguin.stageId]?.code,
          diffGroup: stages[penguin.stageId]?.diffGroup,
          stageType: stages[penguin.stageId]?.stageType,
          ratex1000: (rate * 1000).ceil(),
        ));
      }

      // sort
      result.sort((a, b) => b.ratex1000!.compareTo(a.ratex1000!));

      emit(state.copyWith(
        sortOption: PenguinSortOption.rate,
        sortedPenguin: result,
      ));

      // filter
      _itemPenguinToggleEventHandler(
        ItemPenguinToggleEvent(isIncludePerm: state.isIncludePerm),
        emit,
      );
    } catch (e) {
      emit(ItemPenguinState(
        sortedPenguin: state.sortedPenguin,
        status: CommonLoadState.error,
      ));
    }
  }

  Future<void> _itemPenguinTimesSortEventHandler(
    ItemPenguinTimesSortEvent event,
    Emitter<ItemPenguinState> emit,
  ) async {
    emit(state.copyWith(
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
        var sanity = stages[penguin.stageId]?.apCost ?? 99;

        if (sanity <= 0) continue;
        if (stages[penguin.stageId]?.code == null) continue;

        result.add(PenguinSortModel(
          penguin: penguin,
          stageCode: stages[penguin.stageId]?.code,
          diffGroup: stages[penguin.stageId]?.diffGroup,
          stageType: stages[penguin.stageId]?.stageType,
          times: penguin.times,
        ));
      }

      // sort
      result.sort((a, b) => b.times!.compareTo(a.times!));

      emit(state.copyWith(
        sortOption: PenguinSortOption.times,
        sortedPenguin: result,
      ));

      // filter
      _itemPenguinToggleEventHandler(
        ItemPenguinToggleEvent(isIncludePerm: state.isIncludePerm),
        emit,
      );
    } catch (e) {
      emit(ItemPenguinState(
        sortedPenguin: state.sortedPenguin,
        status: CommonLoadState.error,
      ));
    }
  }

  Future<void> _itemPenguinToggleEventHandler(
    ItemPenguinToggleEvent event,
    Emitter<ItemPenguinState> emit,
  ) async {
    emit(state.copyWith(status: CommonLoadState.loading));

    if (event.isIncludePerm) {
      emit(state.copyWith(
        isIncludePerm: true,
        filteredPenguin: state.sortedPenguin,
        status: CommonLoadState.loaded,
      ));
    } else {
      List<PenguinSortModel> result = [];
      for (var penguin in state.sortedPenguin ?? [] as List<PenguinSortModel>) {
        if (penguin.stageType == 'ACTIVITY') continue;
        result.add(penguin);
      }

      emit(state.copyWith(
        isIncludePerm: false,
        filteredPenguin: result,
        status: CommonLoadState.loaded,
      ));
    }
  }
}
