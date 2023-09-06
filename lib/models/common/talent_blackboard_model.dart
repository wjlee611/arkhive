import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_blackboard_model.g.dart';

@JsonSerializable()
class TalentBlackboardModel extends Equatable {
  final String key;
  final double value;
  final String? valueStr; // CN

  const TalentBlackboardModel({
    required this.key,
    required this.value,
    this.valueStr,
  });

  factory TalentBlackboardModel.fromJson(Map<String, dynamic> json) =>
      _$TalentBlackboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$TalentBlackboardModelToJson(this);

  @override
  List<Object?> get props => [
        key,
        value,
        valueStr,
      ];
}
