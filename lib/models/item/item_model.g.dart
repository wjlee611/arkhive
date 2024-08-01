// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      itemId: json['itemId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      rarity: fromJsonToString(json['rarity']),
      iconId: json['iconId'] as String,
      sortId: (json['sortId'] as num).toInt(),
      usage: json['usage'] as String?,
      obtainApproach: json['obtainApproach'] as String?,
      classifyType: json['classifyType'] as String,
      itemType: json['itemType'] as String,
    );
