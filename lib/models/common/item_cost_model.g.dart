// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_cost_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCostModel _$ItemCostModelFromJson(Map<String, dynamic> json) =>
    ItemCostModel(
      id: json['id'] as String,
      count: (json['count'] as num).toInt(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$ItemCostModelToJson(ItemCostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'type': instance.type,
    };
