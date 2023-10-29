import 'package:arkhive/enums/rarity_tier.dart';
import 'package:arkhive/models/operator/operator_list_model.dart';
import 'package:equatable/equatable.dart';

class RecruitModel extends Equatable {
  final List<String> tags;
  final List<OperatorListModel> operators;
  final ERarityTier minTier;

  const RecruitModel({
    required this.tags,
    required this.operators,
    required this.minTier,
  });

  @override
  List<Object?> get props => [
        tags,
        operators,
        minTier,
      ];
}
