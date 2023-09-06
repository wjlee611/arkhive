import 'package:arkhive/tools/modeling_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stage_model.g.dart';

@JsonSerializable(createToJson: false)
class StageModel extends Equatable {
  final String stageType;
  final String stageId;
  final String difficulty;
  final String diffGroup;
  final String zoneId;
  final String code;
  final String? name;
  final String? description;
  final int apCost;
  final int apFailReturn;
  final StageDropInfoModel stageDropInfo;
  final bool isStoryOnly;
  final bool isPredefined;
  final bool isStagePatch;

  const StageModel({
    required this.stageType,
    required this.stageId,
    required this.difficulty,
    required this.diffGroup,
    required this.zoneId,
    required this.code,
    this.name,
    this.description,
    required this.apCost,
    required this.apFailReturn,
    required this.stageDropInfo,
    required this.isStoryOnly,
    required this.isPredefined,
    required this.isStagePatch,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) =>
      _$StageModelFromJson(json);

  @override
  List<Object?> get props => [
        stageType,
        stageId,
        difficulty,
        diffGroup,
        zoneId,
        code,
        name,
        description,
        apCost,
        apFailReturn,
        stageDropInfo,
        isStoryOnly,
        isPredefined,
        isStagePatch,
      ];
}

@JsonSerializable(createToJson: false)
class StageDropInfoModel extends Equatable {
  final List<StageItemModel> displayDetailRewards;

  const StageDropInfoModel({required this.displayDetailRewards});

  factory StageDropInfoModel.fromJson(Map<String, dynamic> json) =>
      _$StageDropInfoModelFromJson(json);

  @override
  List<Object?> get props => [displayDetailRewards];
}

@JsonSerializable(createToJson: false)
class StageItemModel extends Equatable {
  @JsonKey(fromJson: fromJsonToString)
  final String? occPercent; // CN: int -> String
  final String type;
  final String id;
  @JsonKey(fromJson: fromJsonToString)
  final String dropType; // CN: int -> String

  const StageItemModel({
    this.occPercent,
    required this.type,
    required this.id,
    required this.dropType,
  });

  factory StageItemModel.fromJson(Map<String, dynamic> json) =>
      _$StageItemModelFromJson(json);

  @override
  List<Object?> get props => [
        occPercent,
        type,
        id,
        dropType,
      ];
}
