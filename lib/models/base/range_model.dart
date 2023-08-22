import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'range_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RangeModel extends Equatable {
  final String? id;
  final int? direction;
  final List<RangeGridModel>? grids;

  const RangeModel({
    this.id,
    this.direction,
    this.grids,
  });

  factory RangeModel.fromJson(Map<String, dynamic> json) =>
      _$RangeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RangeModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        direction,
        grids,
      ];
}

@JsonSerializable()
class RangeGridModel extends Equatable {
  final int? row;
  final int? col;

  const RangeGridModel({
    this.row,
    this.col,
  });

  factory RangeGridModel.fromJson(Map<String, dynamic> json) =>
      _$RangeGridModelFromJson(json);

  Map<String, dynamic> toJson() => _$RangeGridModelToJson(this);

  @override
  List<Object?> get props => [
        row,
        col,
      ];
}
