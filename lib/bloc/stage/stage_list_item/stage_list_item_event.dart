import 'package:arkhive/models/stage/stage_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class StageListItemEvent extends Equatable {
  const StageListItemEvent();

  @override
  List<Object?> get props => [];
}

class StageListItemOnTabEvent extends StageListItemEvent {
  final String actId;
  final List<ZoneListModel> zones;

  const StageListItemOnTabEvent({
    required this.actId,
    required this.zones,
  });

  @override
  List<Object?> get props => [actId];
}
