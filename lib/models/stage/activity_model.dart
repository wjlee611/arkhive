import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@JsonSerializable(createToJson: false)
class ActivityModel extends Equatable {
  final String id;
  final String type;
  final String? displayType;
  final String name;
  final int startTime;
  final int endTime;
  final int rewardEndTime;
  final bool displayOnHome;
  final bool hasStage;
  final String? templateShopId;
  final String? medalGroupId;
  final List<String>? ungroupedMedalIds;
  final bool isReplicate;
  final bool? needFixedSync; // CN

  const ActivityModel({
    required this.id,
    required this.type,
    this.displayType,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.rewardEndTime,
    required this.displayOnHome,
    required this.hasStage,
    this.templateShopId,
    this.medalGroupId,
    this.ungroupedMedalIds,
    required this.isReplicate,
    this.needFixedSync,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        type,
        displayType,
        name,
        startTime,
        endTime,
        rewardEndTime,
        displayOnHome,
        hasStage,
        templateShopId,
        medalGroupId,
        ungroupedMedalIds,
        isReplicate,
      ];
}
