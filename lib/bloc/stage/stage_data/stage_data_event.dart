import 'package:equatable/equatable.dart';

abstract class StageDataEvent extends Equatable {
  const StageDataEvent();

  @override
  List<Object?> get props => [];
}

class StageDataLoadEvent extends StageDataEvent {
  final String stageKey;

  const StageDataLoadEvent({
    required this.stageKey,
  });

  @override
  List<Object?> get props => [stageKey];
}
