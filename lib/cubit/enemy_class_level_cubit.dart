import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/models/base/enemy_class_level_model.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyClassLevelCubit extends Cubit<EnemyClassLevelState> {
  EnemyClassLevelCubit()
      : super(const EnemyClassLevelState(status: CommonLoadState.init));

  Future<void> loadEnemyClassLevel({
    required Region dbRegion,
  }) async {
    emit(state.copyWith(status: CommonLoadState.loading));

    // CN
    if (dbRegion != Region.cn) {
      emit(state.copyWith(status: CommonLoadState.loaded));
      return;
    }

    // Loading Enemy
    try {
      String jsonString = await rootBundle.loadString(
          '${getGameDataRoot(dbRegion)}excel/enemy_handbook_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeEnemyModel,
        [port.sendPort, jsonString],
      );
      List<EnemyClassLevelModel> res = await port.first;
      port.close();

      emit(state.copyWith(
        status: CommonLoadState.loaded,
        enemyClassLevels: res,
      ));
    } catch (e) {
      emit(state.copyWith(status: CommonLoadState.error));
      return;
    }
  }

  // Isolate
  static void _deserializeEnemyModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];

    List<EnemyClassLevelModel> enemyClassLevels = [];

    List<dynamic> jsonData = jsonDecode(jsonString)['levelInfoList'];
    for (var classLevel in jsonData) {
      enemyClassLevels.add(EnemyClassLevelModel.fromJson(classLevel));
    }
    Isolate.exit(sendPort, enemyClassLevels);
  }
}

class EnemyClassLevelState extends Equatable {
  final List<EnemyClassLevelModel>? enemyClassLevels;
  final CommonLoadState? status;

  const EnemyClassLevelState({
    this.enemyClassLevels,
    this.status,
  });

  EnemyClassLevelState copyWith({
    List<EnemyClassLevelModel>? enemyClassLevels,
    CommonLoadState? status,
  }) =>
      EnemyClassLevelState(
        enemyClassLevels: enemyClassLevels ?? this.enemyClassLevels,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        enemyClassLevels,
        status,
      ];
}
