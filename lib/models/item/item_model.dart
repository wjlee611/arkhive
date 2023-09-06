import 'package:arkhive/tools/modeling_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable(createToJson: false)
class ItemModel extends Equatable {
  final String itemId;
  final String name;
  final String? description;
  @JsonKey(fromJson: fromJsonToString)
  final String rarity; // CN: 4 -> TIER_5
  final String iconId;
  final int sortId;
  final String? usage;
  final String? obtainApproach;
  final String classifyType;
  final String itemType;

  const ItemModel({
    required this.itemId,
    required this.name,
    this.description,
    required this.rarity,
    required this.iconId,
    required this.sortId,
    this.usage,
    this.obtainApproach,
    required this.classifyType,
    required this.itemType,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  @override
  List<Object?> get props => [
        itemId,
        name,
        description,
        rarity,
        iconId,
        sortId,
        usage,
        obtainApproach,
        classifyType,
        itemType,
      ];
}
