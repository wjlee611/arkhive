import 'package:arkhive/models/common/unlock_condition_model.dart';

abstract class ICandidate {
  UnlockConditionModel get unlockCondition;
  int get requiredPotentialRank;
}
