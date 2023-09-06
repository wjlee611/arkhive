import 'package:arkhive/models/base/penguin_model.dart';
import 'package:arkhive/enums/common_load_state.dart';
import 'package:equatable/equatable.dart';

class StagePenguinState extends Equatable {
  final List<PenguinStageModel>? sortedPenguin;
  final int? times;
  final CommonLoadState? status;

  const StagePenguinState({
    this.sortedPenguin,
    this.times,
    this.status,
  });

  StagePenguinState copyWith({
    List<PenguinStageModel>? sortedPenguin,
    int? times,
    CommonLoadState? status,
  }) =>
      StagePenguinState(
        sortedPenguin: sortedPenguin ?? this.sortedPenguin,
        times: times ?? this.times,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        sortedPenguin,
        times,
        status,
      ];
}
