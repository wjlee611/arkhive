import 'package:equatable/equatable.dart';

abstract class EnemyDataEvent extends Equatable {
  const EnemyDataEvent();

  @override
  List<Object?> get props => [];
}

class EnemyDataLoadEvent extends EnemyDataEvent {
  final String enemyKey;

  const EnemyDataLoadEvent({
    required this.enemyKey,
  });

  @override
  List<Object?> get props => [enemyKey];
}
