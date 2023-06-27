import 'package:equatable/equatable.dart';

abstract class EnemyLevelEvent extends Equatable {
  const EnemyLevelEvent();

  @override
  List<Object?> get props => [];
}

class EnemyLevelSetEvent extends EnemyLevelEvent {
  final int level;

  const EnemyLevelSetEvent({
    required this.level,
  });

  @override
  List<Object?> get props => [level];
}
