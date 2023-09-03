import 'package:arkhive/models/common/unlock_condition_model.dart';
import 'package:equatable/equatable.dart';

abstract class ABSCandidate extends Equatable {
  final UnlockConditionModel unlockCondition;
  final int requiredPotentialRank;

  const ABSCandidate({
    required this.unlockCondition,
    required this.requiredPotentialRank,
  });

  @override
  List<Object?> get props => [
        unlockCondition,
        requiredPotentialRank,
      ];
}
