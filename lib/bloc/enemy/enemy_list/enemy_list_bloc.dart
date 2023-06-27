import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_event.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_state.dart';
import 'package:arkhive/models/enemy_list_model.dart';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyListBloc extends Bloc<EnemyListEvent, EnemyListState> {
  EnemyListBloc() : super(EnemyListInitState()) {
    on<EnemyListInitEvent>(_enemyListInitEventHandler);
    on<EnemyListSelectFiltersEvent>(_enemyListSelectFiltersEventHandler);
    on<EnemyListSearchEvent>(_enemyListSearchEventHandler);
  }

  // initialize event
  Future<void> _enemyListInitEventHandler(
    EnemyListInitEvent event,
    Emitter<EnemyListState> emit,
  ) async {
    emit(const EnemyListLoadingState());

    try {
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/enemy_handbook_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeEnemyListModel,
        [port.sendPort, jsonString],
      );
      var result = await port.first;
      port.close();

      emit(EnemyListLoadedState(
        enemyList: result,
        filteredEnemyList: result,
        selectedFilterOption: const [true, true, true],
        searchQuery: "",
      ));
    } catch (e) {
      emit(EnemyListErrorState(message: e.toString()));
    }
  }

  Future<void> _enemyListSelectFiltersEventHandler(
    EnemyListSelectFiltersEvent event,
    Emitter<EnemyListState> emit,
  ) async {
    if (state.enemyList == null || state.enemyList!.isEmpty) return;

    emit(EnemyListLoadingState(
      enemyList: state.enemyList,
      selectedFilterOption: event.filters,
      searchQuery: state.searchQuery,
    ));

    List<EnemyListModel> result = [];
    for (var enemy in state.enemyList!) {
      if (event.filters[0] && enemy.level == 'NORMAL') {
        result.add(enemy);
        continue;
      }
      if (event.filters[1] && enemy.level == 'ELITE') {
        result.add(enemy);
        continue;
      }
      if (event.filters[2] && enemy.level == 'BOSS') {
        result.add(enemy);
      }
    }

    emit(EnemyListLoadedState(
      enemyList: state.enemyList,
      filteredEnemyList: result,
      selectedFilterOption: event.filters,
      searchQuery: state.searchQuery,
    ));
  }

  Future<void> _enemyListSearchEventHandler(
    EnemyListSearchEvent event,
    Emitter<EnemyListState> emit,
  ) async {
    if (state.enemyList == null || state.enemyList!.isEmpty) return;

    emit(EnemyListLoadingState(
      enemyList: state.enemyList,
      selectedFilterOption: state.selectedFilterOption,
      searchQuery: event.searchQuery,
    ));

    List<EnemyListModel> result = [];
    for (var enemy in state.enemyList!) {
      if (enemy.name.toLowerCase().contains(event.searchQuery.toLowerCase()) ||
          enemy.enemyIndex
              .toLowerCase()
              .contains(event.searchQuery.toLowerCase())) {
        result.add(enemy);
      }
    }

    emit(EnemyListLoadedState(
      enemyList: state.enemyList,
      filteredEnemyList: result,
      selectedFilterOption: state.selectedFilterOption,
      searchQuery: event.searchQuery,
    ));
  }

  // Isolate
  static void _deserializeEnemyListModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    List<EnemyListModel> result = [];

    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    for (var enemyData in jsonData.entries) {
      var enemy = EnemyModel.fromJson(enemyData.value);
      if (enemy.hideInHandbook ?? true) continue;

      result.add(EnemyListModel(
        enemyKey: enemy.enemyId!,
        enemyIndex: enemy.enemyIndex!,
        name: enemy.name!,
        level: enemy.enemyLevel!,
        tags: enemy.tags,
      ));
    }

    Isolate.exit(sendPort, result);
  }
}
