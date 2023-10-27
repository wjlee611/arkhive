import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/bloc/recruit/list/recruit_list_state.dart';
import 'package:arkhive/bloc/recruit/list/recurit_list_event.dart';
import 'package:arkhive/enums/common_load_state.dart';
import 'package:arkhive/models/operator/operator_list_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitListBloc extends Bloc<RecruitListEvent, RecruitListState> {
  RecruitListBloc()
      : super(const RecruitListState(status: CommonLoadState.init)) {
    on<RecruitListInitEvent>(_recruitListInitEventHandler);
    on<RecruitListOpInitEvent>(_recruitListOpInitEventHandler);
  }

  Future<void> _recruitListInitEventHandler(
    RecruitListInitEvent event,
    Emitter<RecruitListState> emit,
  ) async {
    emit(state.copyWith(status: CommonLoadState.loading));

    try {
      List<String> operatorNames = [];

      String jsonString = await rootBundle
          .loadString('${getGameDataRoot(Region.kr)}excel/gacha_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeRecruitList,
        [port.sendPort, jsonString],
      );
      operatorNames = await port.first;
      port.close();

      emit(state.copyWith(
        operatorNames: operatorNames,
      ));
    } catch (_) {
      emit(state.copyWith(status: CommonLoadState.error));
    }
  }

  Future<void> _recruitListOpInitEventHandler(
    RecruitListOpInitEvent event,
    Emitter<RecruitListState> emit,
  ) async {
    try {
      List<OperatorListModel> operators = [];

      for (var operator_ in event.operators) {
        if (state.operatorNames?.contains(operator_.name.replaceAll(' ', '')) ==
            true) {
          operators.add(operator_);
        }
      }

      emit(state.copyWith(
        operators: operators,
        status: CommonLoadState.loaded,
      ));
    } catch (_) {
      emit(state.copyWith(status: CommonLoadState.error));
    }
  }

  // Isolate
  static void _deserializeRecruitList(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    List<String> result = [];

    String jsonData = jsonDecode(jsonString)['recruitDetail'];
    result = jsonData
        .replaceAll(RegExp(r'<.*?>'), '')
        .replaceAll('\n', '')
        .replaceAll('--', '')
        .split('★')
      ..removeAt(0);
    result = result.map((e) => e.split('/')).expand((e) => e).toList();
    result = result
        .where((e) => e.isNotEmpty)
        .map((e) => e.replaceAll(' ', ''))
        .toList();

    Isolate.exit(sendPort, result);
  }
}
