import 'dart:convert';
import 'dart:isolate';

import 'package:arkhive/models/base/penguin_model.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PenguinCubit extends Cubit<PenguinState> {
  PenguinCubit() : super(const PenguinState(status: CommonLoadState.init));

  Future<void> loadPenguin() async {
    emit(state.copyWith(status: CommonLoadState.loading));

    try {
      String jsonString =
          await rootBundle.loadString('assets/data/penguin_matrix.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializePenguinModel,
        [port.sendPort, jsonString],
      );
      List<dynamic> response = await port.first;
      PenguinStage stage = response[0];
      PenguinItem item = response[1];
      port.close();

      emit(state.copyWith(
        stages: stage,
        items: item,
        status: CommonLoadState.loaded,
      ));
      return;
    } catch (e) {
      emit(state.copyWith(status: CommonLoadState.error));
      return;
    }
  }

  // Isolate
  static void _deserializePenguinModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];

    PenguinStage stage = const PenguinStage();
    PenguinItem item = const PenguinItem();

    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    List<dynamic> penguinMatrix = jsonData['matrix'];

    for (var penguinData in penguinMatrix) {
      var penguin = PenguinModel.fromJson(penguinData);
      stage = stage.copyWith(penguin: penguin);
      item = item.copyWith(penguin: penguin);
    }

    Isolate.exit(sendPort, [stage, item]);
  }
}

class PenguinState extends Equatable {
  final PenguinStage? stages;
  final PenguinItem? items;
  final CommonLoadState? status;

  const PenguinState({
    this.stages,
    this.items,
    this.status,
  });

  PenguinState copyWith({
    PenguinStage? stages,
    PenguinItem? items,
    CommonLoadState? status,
  }) =>
      PenguinState(
        stages: stages ?? this.stages,
        items: items ?? this.items,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status];
}
