import 'package:equatable/equatable.dart';

abstract class StageListEvent extends Equatable {
  const StageListEvent();

  @override
  List<Object?> get props => [];
}

class StageListInitEvent extends StageListEvent {
  const StageListInitEvent();

  @override
  List<Object?> get props => [];
}

class StageListActOpenTapEvent extends StageListEvent {
  final String actId;

  const StageListActOpenTapEvent({
    required this.actId,
  });

  @override
  List<Object?> get props => [actId];
}
