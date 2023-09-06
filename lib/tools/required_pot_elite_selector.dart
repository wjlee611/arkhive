import 'package:arkhive/enums/operator_phase.dart';
import 'package:arkhive/interface/candidates_interface.dart';

T? reqPotEliteSelector<T extends ICandidate>({
  required List<T>? candidates,
  required int currPot,
  int currElite = 2,
  int currLevel = 60,
}) {
  T? result;

  for (var candidate in candidates ?? []) {
    if (operatorPhaseConverter(candidate.unlockCondition.phase).value <=
            currElite &&
        candidate.unlockCondition.level <= currLevel) {
      if (candidate.requiredPotentialRank <= currPot) {
        result = candidate;
      }
    }
  }

  return result;
}
