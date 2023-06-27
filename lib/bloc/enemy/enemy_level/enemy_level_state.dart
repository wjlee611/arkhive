import 'package:equatable/equatable.dart';

class EnemyLevelState extends Equatable {
  final int level;

  const EnemyLevelState({
    required this.level,
  });

  @override
  List<Object?> get props => [level];
}
