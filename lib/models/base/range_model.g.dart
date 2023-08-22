// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'range_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RangeModel _$RangeModelFromJson(Map<String, dynamic> json) => RangeModel(
      id: json['id'] as String?,
      direction: json['direction'] as int?,
      grids: (json['grids'] as List<dynamic>?)
          ?.map((e) => RangeGridModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RangeModelToJson(RangeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'direction': instance.direction,
      'grids': instance.grids?.map((e) => e.toJson()).toList(),
    };

RangeGridModel _$RangeGridModelFromJson(Map<String, dynamic> json) =>
    RangeGridModel(
      row: json['row'] as int?,
      col: json['col'] as int?,
    );

Map<String, dynamic> _$RangeGridModelToJson(RangeGridModel instance) =>
    <String, dynamic>{
      'row': instance.row,
      'col': instance.col,
    };
