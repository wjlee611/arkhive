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
      mValue: _$nullableGenericFromJson(json['m_value'], fromJsonT),
    );

Map<String, dynamic> _$AttributeMModelToJson<T>(
  AttributeMModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'm_defined': instance.mDefined,
      'm_value': _$nullableGenericToJson(instance.mValue, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
