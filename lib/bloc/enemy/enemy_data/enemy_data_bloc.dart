import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/bloc/enemy/enemy_data/enemy_data_event.dart';
import 'package:arkhive/bloc/enemy/enemy_data/enemy_data_state.dart';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyDataBloc extends Bloc<EnemyDataEvent, EnemyDataState> {
  EnemyDataBloc() : super(const EnemyDataInitState()) {
    on<EnemyDataLoadEvent>(_enemyDataLoadEventHandler);
  }

  Future<void> _enemyDataLoadEventHandler(
    EnemyDataLoadEvent event,
    Emitter<EnemyDataState> emit,
  ) async {
    emit(const EnemyDataLoadingState());

    EnemyModel? enemy;
    EnemyDataModel? enemyData;

    // Loading Enemy
    try {
      ReceivePort port = ReceivePort();
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/enemy_handbook_table.json');

      final isolate = await Isolate.spawn(
        _deserializeEnemyModel,
        [port.sendPort, jsonString, event.enemyKey],
      );

      enemy = await port.first;
    } catch (e) {
      emit(const EnemyDataErrorState(message: '적'));
      return;
    }

    // Loading Enemy Data
    try {
      ReceivePort port = ReceivePort();
      String jsonString = await rootBundle.loadString(
          '${getGameDataRoot()}levels/enemydata/enemy_database.json');

      final isolate = await Isolate.spawn(
        _deserializeEnemyDataModel,
        [port.sendPort, jsonString, event.enemyKey],
      );

      enemyData = await port.first;
    } catch (e) {
      emit(const EnemyDataErrorState(message: '적 데이터'));
      return;
    }

    if (enemy == null) {
      emit(const EnemyDataErrorState(message: '적'));
      return;
    }
    if (enemyData == null) {
      emit(const EnemyDataErrorState(message: '적 데이터'));
      return;
    }

    emit(EnemyDataLoadedState(
      enemy: enemy,
      enemyData: enemyData,
    ));
  }

  static void _deserializeEnemyModel(List<dynamic> values) {
    SendPort sendPort = values[0];
    String jsonString = values[1];
    String enemyKey = values[2];

    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    Isolate.exit(sendPort, EnemyModel.fromJson(jsonData[enemyKey]));
  }

  static void _deserializeEnemyDataModel(List<dynamic> values) {
    SendPort sendPort = values[0];
    String jsonString = values[1];
    String enemyKey = values[2];

    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    List<dynamic> enemyDataList = jsonData['enemies'];

    for (var data in enemyDataList) {
      if (data['Key'] == enemyKey) {
        Isolate.exit(sendPort, EnemyDataModel.fromJson(data));
      }
    }
  }
}
