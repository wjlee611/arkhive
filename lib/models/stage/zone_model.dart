import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'zone_model.g.dart';

@JsonSerializable(createToJson: false)
class ZoneModel extends Equatable {
  final String zoneID;
  final int zoneIndex;
  final String type;
  final String? zoneNameFirst;
  final String? zoneNameSecond;
  final String? zoneNameTitleCurrent;
  final String? zoneNameTitleUnCurrent;
  final String? zoneNameTitleEx;
  final String? zoneNameThird;
  final String? lockedText;
  final bool canPreview;

  const ZoneModel({
    required this.zoneID,
    required this.zoneIndex,
    required this.type,
    this.zoneNameFirst,
    this.zoneNameSecond,
    this.zoneNameTitleCurrent,
    this.zoneNameTitleUnCurrent,
    this.zoneNameTitleEx,
    this.zoneNameThird,
    this.lockedText,
    required this.canPreview,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) =>
      _$ZoneModelFromJson(json);

  @override
  List<Object?> get props => [
        zoneID,
        zoneIndex,
        type,
        zoneNameFirst,
        zoneNameSecond,
        zoneNameTitleCurrent,
        zoneNameTitleUnCurrent,
        zoneNameTitleEx,
        zoneNameThird,
        lockedText,
        canPreview,
      ];
}
