import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc //
class OperatorStatBloc
    extends Bloc<OperatorStatChangeEvent, OperatorStatState> {
  OperatorStatBloc() : super(const OperatorStatState.init()) {
    on<OperatorPotentialChangeEvent>(
      (event, emit) => emit(state.copyWith(potential: event.potential)),
    );

    on<OperatorEliteChangeEvent>(
      (event, emit) => emit(state.copyWith(elite: event.elite)),
    );

    on<OperatorLevelChangeEvent>(
      (event, emit) => emit(state.copyWith(level: event.level)),
    );

    on<OperatorFavorChangeEvent>(
      (event, emit) => emit(state.copyWith(favor: event.favor)),
    );
  }
}

// Event //
abstract class OperatorStatChangeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OperatorPotentialChangeEvent extends OperatorStatChangeEvent {
  final int potential;

  OperatorPotentialChangeEvent({required this.potential});
}

class OperatorEliteChangeEvent extends OperatorStatChangeEvent {
  final int elite;

  OperatorEliteChangeEvent({required this.elite});
}

class OperatorLevelChangeEvent extends OperatorStatChangeEvent {
  final int level;

  OperatorLevelChangeEvent({required this.level});
}

class OperatorFavorChangeEvent extends OperatorStatChangeEvent {
  final int favor;

  OperatorFavorChangeEvent({required this.favor});
}

// State //
class OperatorStatState extends Equatable {
  final int potential, elite, level, favor;

  const OperatorStatState({
    required this.potential,
    required this.elite,
    required this.level,
    required this.favor,
  });

  const OperatorStatState.init()
      : this(
          potential: 0,
          elite: 0,
          level: 1,
          favor: 0,
        );

  OperatorStatState copyWith({
    int? potential,
    int? elite,
    int? level,
    int? favor,
  }) {
    return OperatorStatState(
      potential: potential ?? this.potential,
      elite: elite ?? this.elite,
      level: level ?? this.level,
      favor: favor ?? this.favor,
    );
  }

  @override
  List<Object?> get props => [
        potential,
        elite,
        level,
        favor,
      ];
}
