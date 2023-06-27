import 'dart:convert';
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
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/enemy_handbook_table.json');
      Map<String, dynamic> jsonData = await json.decode(jsonString);
      enemy = EnemyModel.fromJson(jsonData[event.enemyKey]);
    } catch (_) {
      emit(const EnemyDataErrorState(message: '적'));
      return;
    }

    // Loading Enemy Data
    try {
      String jsonString = await rootBundle.loadString(
          '${getGameDataRoot()}levels/enemydata/enemy_database.json');
      Map<String, dynamic> jsonData = await json.decode(jsonString);
      List<dynamic> enemyDataList = jsonData['enemies'];

      for (var data in enemyDataList) {
        if (data['Key'] == event.enemyKey) {
          enemyData = EnemyDataModel.fromJson(data);
          break;
        }
      }
    } catch (e) {
      emit(const EnemyDataErrorState(message: '적 데이터'));
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
}
