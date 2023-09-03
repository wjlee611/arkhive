import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unlock_condition_model.g.dart';

@JsonSerializable()
class UnlockConditionModel extends Equatable {
  @JsonKey(fromJson: _fromJsonToString)
  final String phase; // CN: 0 -> PHASE_0
  final int level;

  const UnlockConditionModel({
    required this.phase,
    required this.level,
  });

  factory UnlockConditionModel.fromJson(Map<String, dynamic> json) =>
      _$UnlockConditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnlockConditionModelToJson(this);

  static String _fromJsonToString(dynamic value) => value.toString();

  @override
  List<Object?> get props => [
        phase,
        level,
      ];
}
