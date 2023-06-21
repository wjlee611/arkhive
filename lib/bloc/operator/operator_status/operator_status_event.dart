import 'package:arkhive/models/operator_model.dart';
import 'package:equatable/equatable.dart';

abstract class OperatorStatusEvent extends Equatable {
  const OperatorStatusEvent();

  @override
  List<Object?> get props => [];
}

class OperatorStatusInitEvent extends OperatorStatusEvent {
  final OperatorModel operator_;

  const OperatorStatusInitEvent({
    required this.operator_,
  });

  @override
  List<Object?> get props => [operator_];
}

class OperatorStatusPotentialChangeEvent extends OperatorStatusEvent {
  final int potential;

  const OperatorStatusPotentialChangeEvent({
    required this.potential,
  });

  @override
  List<Object?> get props => [potential];
}

class OperatorStatusEliteChangeEvent extends OperatorStatusEvent {
  final int elite;

  const OperatorStatusEliteChangeEvent({
    required this.elite,
  });

  @override
  List<Object?> get props => [elite];
}

class OperatorStatusLevelChangeEvent extends OperatorStatusEvent {
  final int level;

  const OperatorStatusLevelChangeEvent({
    required this.level,
  });

  @override
  List<Object?> get props => [level];
}

class OperatorStatusFavorChangeEvent extends OperatorStatusEvent {
  final int favor;

  const OperatorStatusFavorChangeEvent({
    required this.favor,
  });

  @override
  List<Object?> get props => [favor];
}
