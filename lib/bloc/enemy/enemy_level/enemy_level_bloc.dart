import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_event.dart';
import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyLevelBloc extends Bloc<EnemyLevelEvent, EnemyLevelState> {
  EnemyLevelBloc({int level = 0}) : super(EnemyLevelState(level: level)) {
    on<EnemyLevelSetEvent>(_enemyLevelSetEventHandler);
  }

  Future<void> _enemyLevelSetEventHandler(
    EnemyLevelSetEvent event,
    Emitter<EnemyLevelState> emit,
  ) async {
    emit(EnemyLevelState(level: event.level));
  }
}
