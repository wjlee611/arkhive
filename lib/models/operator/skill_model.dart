import 'package:arkhive/models/common/talent_blackboard_model.dart';
import 'package:arkhive/tools/modeling_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skill_model.g.dart';

@JsonSerializable(createToJson: false)
class SkillModel extends Equatable {
  final String? skillId;
  final String? iconId;
  final bool? hidden;
  final List<SkillLevelsModel> levels;

  const SkillModel({
    this.skillId,
    this.iconId,
    this.hidden,
    required this.levels,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) =>
      _$SkillModelFromJson(json);

  @override
  List<Object?> get props => [
        skillId,
        iconId,
        hidden,
        levels,
      ];
}

@JsonSerializable(createToJson: false)
class SkillLevelsModel extends Equatable {
  final String? name;
  final String? rangeId;
  final String? description;
  @JsonKey(fromJson: fromJsonToString)
  final String? skillType;
  @JsonKey(fromJson: fromJsonToString)
  final String? durationType;
  final SkillSpDataModel? spData;
  final String? prefabId;
  final double? duration;
  final List<TalentBlackboardModel>? blackboard;

  const SkillLevelsModel({
    this.name,
    this.rangeId,
    this.description,
    this.skillType,
    this.durationType,
    this.spData,
    this.prefabId,
    this.duration,
    this.blackboard,
  });

  factory SkillLevelsModel.fromJson(Map<String, dynamic> json) =>
      _$SkillLevelsModelFromJson(json);

  @override
  List<Object?> get props => [
        name,
        rangeId,
        description,
        skillType,
        durationType,
        spData,
        prefabId,
        duration,
        blackboard,
      ];
}

@JsonSerializable(createToJson: false)
class SkillSpDataModel extends Equatable {
  @JsonKey(fromJson: fromJsonToString)
  final String? spType;
  // "levelUpCost": null,
  final int? maxChargeTime;
  final int? spCost;
  final int? initSp;
  final double? increment;

  const SkillSpDataModel({
    this.spType,
    this.maxChargeTime,
    this.spCost,
    this.initSp,
    this.increment,
  });

  factory SkillSpDataModel.fromJson(Map<String, dynamic> json) =>
      _$SkillSpDataModelFromJson(json);

  @override
  List<Object?> get props => [
        spType,
        maxChargeTime,
        spCost,
        initSp,
        increment,
      ];
}
