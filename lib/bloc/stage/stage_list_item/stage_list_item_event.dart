import 'package:equatable/equatable.dart';

abstract class StageListItemEvent extends Equatable {
  const StageListItemEvent();

  @override
  List<Object?> get props => [];
}

class StageListItemOnTabEvent extends StageListItemEvent {
  final String zoneId;

  const StageListItemOnTabEvent({
    required this.zoneId,
  });

  @override
  List<Object?> get props => [zoneId];
}
