import 'package:arkhive/tools/modeling_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unlock_condition_model.g.dart';

@JsonSerializable()
class UnlockConditionModel extends Equatable {
  @JsonKey(fromJson: fromJsonToString)
  final String phase; // CN: 0 -> PHASE_0
  final int level;

  const UnlockConditionModel({
    required this.phase,
    required this.level,
  });

  factory UnlockConditionModel.fromJson(Map<String, dynamic> json) =>
      _$UnlockConditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnlockConditionModelToJson(this);

  @override
  List<Object?> get props => [
        phase,
        level,
      ];
}
