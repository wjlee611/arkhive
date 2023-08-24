// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      key: json['key'] as String?,
      iconId: json['iconId'] as String?,
      name: json['name'] as String?,
      diffGroup: json['diffGroup'] as String?,
      difficulty: json['difficulty'] as String?,
      category: $enumDecodeNullable(_$FavorCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'iconId': instance.iconId,
      'name': instance.name,
      'diffGroup': instance.diffGroup,
      'difficulty': instance.difficulty,
      'category': _$FavorCategoryEnumMap[instance.category],
    };

const _$FavorCategoryEnumMap = {
  FavorCategory.item: 'item',
  FavorCategory.stage: 'stage',
  FavorCategory.oper: 'oper',
  FavorCategory.enemy: 'enemy',
};
