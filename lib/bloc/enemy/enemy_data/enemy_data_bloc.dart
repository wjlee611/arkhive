import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/bloc/enemy/enemy_data/enemy_data_event.dart';
import 'package:arkhive/bloc/enemy/enemy_data/enemy_data_state.dart';
import 'package:arkhive/models/enemy/enemy_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyDataBloc extends Bloc<EnemyDataEvent, EnemyDataState> {
  final Region dbRegion;

  EnemyDataBloc({
    required this.dbRegion,
  }) : super(const EnemyDataInitState()) {
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
      String jsonString = await rootBundle.loadString(
          '${getGameDataRoot(dbRegion)}excel/enemy_handbook_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeEnemyModel,
        [port.sendPort, jsonString, event.enemyKey, dbRegion],
      );
      enemy = await port.first;
      port.close();
    } catch (e) {
      emit(const EnemyDataErrorState(message: '적'));
      return;
    }

    // Loading Enemy Data
    try {
      String jsonString = await rootBundle.loadString(
          '${getGameDataRoot(dbRegion)}levels/enemydata/enemy_database.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeEnemyDataModel,
        [port.sendPort, jsonString, event.enemyKey],
      );
      enemyData = await port.first;
      port.close();
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

  // Isolate
  static void _deserializeEnemyModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    String enemyKey = args[2];
    Region dbRegion = args[3];

    Map<String, dynamic>? jsonData;
    if (dbRegion == Region.cn) {
      jsonData = jsonDecode(jsonString)['enemyData'];
    } else {
      jsonData = jsonDecode(jsonString);
    }
    Isolate.exit(sendPort, EnemyModel.fromJson(jsonData![enemyKey]));
  }

  static void _deserializeEnemyDataModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    String enemyKey = args[2];

    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    List<dynamic> enemyDataList = jsonData['enemies'];

    for (var data in enemyDataList) {
      if (data['Key'] == enemyKey) {
        Isolate.exit(sendPort, EnemyDataModel.fromJson(data));
      }
    }
  }
}
