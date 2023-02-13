import 'package:arkhive/models/operator_model.dart';

class BlackboardModel {
  final String key;
  final double value;

  BlackboardModel.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        value = json['value'];
}

class EvolveCostModel {
  final String id, type;
  final int count;

  EvolveCostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        count = json['count'];
}

// ABSTRACT CLASS
abstract class PotentialRank {
  int get requiredPotentialRank;
  OperatorUnlockCondModel get unlockCondition;
}
