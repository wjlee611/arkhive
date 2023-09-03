import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_cost_model.g.dart';

@JsonSerializable()
class ItemCostModel extends Equatable {
  final String id;
  final int count;
  final String type;

  const ItemCostModel({
    required this.id,
    required this.count,
    required this.type,
  });

  factory ItemCostModel.fromJson(Map<String, dynamic> json) =>
      _$ItemCostModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCostModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        count,
        type,
      ];
}
