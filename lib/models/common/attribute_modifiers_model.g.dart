// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_modifiers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeModifiersModel _$AttributeModifiersModelFromJson(
        Map<String, dynamic> json) =>
    AttributeModifiersModel(
      attributeType: fromJsonToString(json['attributeType']),
      formulaItem: fromJsonToString(json['formulaItem']),
      value: (json['value'] as num).toDouble(),
      loadFromBlackboard: json['loadFromBlackboard'] as bool,
      fetchBaseValueFromSourceEntity:
          json['fetchBaseValueFromSourceEntity'] as bool,
    );

Map<String, dynamic> _$AttributeModifiersModelToJson(
        AttributeModifiersModel instance) =>
    <String, dynamic>{
      'attributeType': instance.attributeType,
      'formulaItem': instance.formulaItem,
      'value': instance.value,
      'loadFromBlackboard': instance.loadFromBlackboard,
      'fetchBaseValueFromSourceEntity': instance.fetchBaseValueFromSourceEntity,
    };
