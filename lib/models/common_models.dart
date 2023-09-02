import 'package:arkhive/models/operator/operator_model.dart';

enum CommonLoadState {
  init,
  loading,
  loaded,
  error,
}

class EvolveCostModel {
  final String? id, type;
  final int? count;

  EvolveCostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        count = json['count'];
}

// ABSTRACT CLASS
abstract class PotentialRank {
  int? get requiredPotentialRank;
  OperatorUnlockCondModel get unlockCondition;
}
