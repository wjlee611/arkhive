import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/bloc/operator/operator_list/operator_list_event.dart';
import 'package:arkhive/bloc/operator/operator_list/operator_list_state.dart';
import 'package:arkhive/models/operator/operator_list_model.dart';
import 'package:arkhive/models/operator/operator_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorListBloc extends Bloc<OperatorListEvent, OperatorListState> {
  final Region dbRegion;

  OperatorListBloc({
    required this.dbRegion,
  }) : super(OperatorListInitState()) {
    on<OperatorListInitEvent>(_operatorListInitEventHandler);
    on<OperatorListSelectProfessionsEvent>(
        _operatorListSelectProfessionsEventHandler);
    on<OperatorListSortEvent>(_operatorListSortEventHandler);
    on<OperatorListSearchEvent>(_operatorListSearchEventHandler);
  }

  // initialize event
  Future<void> _operatorListInitEventHandler(
    OperatorListInitEvent event,
    Emitter<OperatorListState> emit,
  ) async {
    emit(const OperatorListLoadingState());

    try {
      List<OperatorListModel> result = [];

      // For normal
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot(dbRegion)}excel/character_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeOperatorListModel,
        [port.sendPort, jsonString],
      );
      result.addAll(await port.first);
      port.close();

      // For promotion
      jsonString = await rootBundle.loadString(
          '${getGameDataRoot(dbRegion)}excel/char_patch_table.json');

      port = ReceivePort();
      await Isolate.spawn(
        _deserializePromotionOperatorListModel,
        [port.sendPort, jsonString],
      );
      result.addAll(await port.first);
      port.close();

      result = _sortByOption(
        target: result,
        option: SortOptions.starUp,
      );

      emit(OperatorListLoadedState(
        operatorList: result,
        filteredOperatorList: result,
        selectedProfession: Professions.all,
        selectedSortOption: SortOptions.starUp,
        searchQuery: '',
      ));
    } catch (e) {
      emit(OperatorListErrorState(message: e.toString()));
    }
  }

  Future<void> _operatorListSelectProfessionsEventHandler(
    OperatorListSelectProfessionsEvent event,
    Emitter<OperatorListState> emit,
  ) async {
    if (state.operatorList == null || state.operatorList!.isEmpty) return;
    // 검색어가 있다면 필터링 안 함
    if (state.searchQuery!.isNotEmpty) return;

    List<OperatorListModel> result = [];

    for (var op in state.operatorList!) {
      switch (event.profession) {
        case Professions.all:
          result.add(op);
          break;
        case Professions.vanguard:
          if (op.profession == "PIONEER") result.add(op);
          break;
        case Professions.guard:
          if (op.profession == "WARRIOR") result.add(op);
          break;
        case Professions.defender:
          if (op.profession == "TANK") result.add(op);
          break;
        case Professions.sniper:
          if (op.profession == "SNIPER") result.add(op);
          break;
        case Professions.caster:
          if (op.profession == "CASTER") result.add(op);
          break;
        case Professions.medic:
          if (op.profession == "MEDIC") result.add(op);
          break;
        case Professions.supporter:
          if (op.profession == "SUPPORT") result.add(op);
          break;
        case Professions.specialist:
          if (op.profession == "SPECIAL") result.add(op);
          break;
        case Professions.perparation:
          if (op.profession == "PREPARE") result.add(op);
          break;
      }
    }

    result = _sortByOption(
      target: result,
      option: state.selectedSortOption!,
    );

    emit(OperatorListLoadedState(
      filteredOperatorList: result,
      selectedProfession: event.profession,
      operatorList: state.operatorList,
      searchQuery: state.searchQuery,
      selectedSortOption: state.selectedSortOption,
    ));
  }

  Future<void> _operatorListSortEventHandler(
    OperatorListSortEvent event,
    Emitter<OperatorListState> emit,
  ) async {
    if (state.operatorList == null || state.operatorList!.isEmpty) return;

    List<OperatorListModel> result =
        (state as OperatorListLoadedState).filteredOperatorList;

    result = _sortByOption(
      target: result,
      option: event.sortOption,
    );

    emit(OperatorListLoadedState(
      filteredOperatorList: result,
      selectedSortOption: event.sortOption,
      operatorList: state.operatorList,
      searchQuery: state.searchQuery,
      selectedProfession: state.selectedProfession,
    ));
  }

  Future<void> _operatorListSearchEventHandler(
    OperatorListSearchEvent event,
    Emitter<OperatorListState> emit,
  ) async {
    if (state.operatorList == null || state.operatorList!.isEmpty) return;

    List<OperatorListModel> result = [];

    for (var op in state.operatorList!) {
      if (op.name.toLowerCase().contains(event.searchQuery.toLowerCase())) {
        result.add(op);
      }
    }

    result = _sortByOption(
      target: result,
      option: state.selectedSortOption!,
    );

    emit(OperatorListLoadedState(
      filteredOperatorList: result,
      selectedProfession: Professions.all,
      searchQuery: event.searchQuery,
      operatorList: state.operatorList,
      selectedSortOption: state.selectedSortOption,
    ));
  }

  List<OperatorListModel> _sortByOption({
    required List<OperatorListModel> target,
    required SortOptions option,
  }) {
    List<OperatorListModel> result = target;

    switch (option) {
      case SortOptions.starUp:
        result.sort((a, b) => a.rarity.compareTo(b.rarity));
        break;
      case SortOptions.starDown:
        result.sort((a, b) => b.rarity.compareTo(a.rarity));
        break;
      case SortOptions.nameUp:
        result.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOptions.nameDown:
        result.sort((a, b) => b.name.compareTo(a.name));
        break;
    }

    return result;
  }

  // Isolate
  static void _deserializeOperatorListModel(List<dynamic> args) async {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    List<OperatorListModel> result = [];

    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    for (var operatorData in jsonData.entries) {
      // 오직 캐릭터만
      if (!operatorData.key.startsWith('char_')) continue;
      // 샬렘 중복 제외
      if (operatorData.key == 'char_512_aprot') continue;

      var operator_ = OperatorModel.fromJson(operatorData.value);
      result.add(OperatorListModel(
        operatorKey: operatorData.key,
        name: operator_.name!,
        // 예비 인원의 경우 별도의 처리
        profession:
            operator_.isNotObtainable! ? 'PREPARE' : operator_.profession!,
        rarity: operator_.rarity!,
      ));
    }

    Isolate.exit(sendPort, result);
  }

  static void _deserializePromotionOperatorListModel(List<dynamic> args) async {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    List<OperatorListModel> result = [];

    Map<String, dynamic> jsonData = jsonDecode(jsonString)['patchChars'];

    for (var operatorData in jsonData.entries) {
      // 오직 캐릭터만
      if (!operatorData.key.startsWith('char_')) continue;

      var operator_ = OperatorModel.fromJson(operatorData.value);
      result.add(OperatorListModel(
        operatorKey: operatorData.key,
        name: operator_.name!,
        // 예비 인원의 경우 별도의 처리
        profession:
            operator_.isNotObtainable! ? 'PREPARE' : operator_.profession!,
        rarity: operator_.rarity!,
      ));
    }

    Isolate.exit(sendPort, result);
  }
}
