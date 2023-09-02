// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_m_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeMModel<T> _$AttributeMModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    AttributeMModel<T>(
      mDefined: json['m_defined'] as bool,
      mValue: fromJsonT(json['m_value']),
    );

Map<String, dynamic> _$AttributeMModelToJson<T>(
  AttributeMModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'm_defined': instance.mDefined,
      'm_value': toJsonT(instance.mValue),
    };
