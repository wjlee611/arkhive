import 'package:arkhive/models/interface/candidates_interface.dart';
import 'package:arkhive/tools/cn_update_converter.dart';

T? reqPotEliteSelector<T extends ICandidate>({
  required List<T>? candidates,
  required int currPot,
  int currElite = 2,
  int currLevel = 60,
}) {
  T? result;

  for (var candidate in candidates ?? []) {
    if (phaseConverter(candidate.unlockCondition.phase) <= currElite &&
        candidate.unlockCondition.level <= currLevel) {
      if (candidate.requiredPotentialRank <= currPot) {
        result = candidate;
      }
    }
  }

  return result;
}
