// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penguin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PenguinModel _$PenguinModelFromJson(Map<String, dynamic> json) => PenguinModel(
      stageId: json['stageId'] as String?,
      itemId: json['itemId'] as String?,
      times: json['times'] as int?,
      quantity: json['quantity'] as int?,
      start: json['start'] as int?,
    );

Map<String, dynamic> _$PenguinModelToJson(PenguinModel instance) =>
    <String, dynamic>{
      'stageId': instance.stageId,
      'itemId': instance.itemId,
      'times': instance.times,
      'quantity': instance.quantity,
      'start': instance.start,
    };
