import 'package:equatable/equatable.dart';
import 'package:arkhive/models/enemy/enemy_model.dart';

abstract class EnemyDataState extends Equatable {
  const EnemyDataState();

  @override
  List<Object?> get props => [];
}

class EnemyDataInitState extends EnemyDataState {
  const EnemyDataInitState();

  @override
  List<Object?> get props => [];
}

class EnemyDataLoadingState extends EnemyDataState {
  const EnemyDataLoadingState();

  @override
  List<Object?> get props => [];
}

class EnemyDataLoadedState extends EnemyDataState {
  final EnemyModel enemy;
  final EnemyDataModel enemyData;

  const EnemyDataLoadedState({
    required this.enemy,
    required this.enemyData,
  });

  @override
  List<Object?> get props => [
        enemy,
        enemyData,
      ];
}

class EnemyDataErrorState extends EnemyDataState {
  final String message;

  const EnemyDataErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
