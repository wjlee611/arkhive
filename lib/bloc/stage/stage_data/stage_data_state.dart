import 'package:arkhive/models/stage/stage_model.dart';
import 'package:equatable/equatable.dart';

abstract class StageDataState extends Equatable {
  const StageDataState();

  @override
  List<Object?> get props => [];
}

class StageDataInitState extends StageDataState {
  const StageDataInitState();

  @override
  List<Object?> get props => [];
}

class StageDataLoadingState extends StageDataState {
  const StageDataLoadingState();

  @override
  List<Object?> get props => [];
}

class StageDataLoadedState extends StageDataState {
  final StageModel stage;

  const StageDataLoadedState({
    required this.stage,
  });

  @override
  List<Object?> get props => [stage];
}

class StageDataErrorState extends StageDataState {
  final String message;

  const StageDataErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
