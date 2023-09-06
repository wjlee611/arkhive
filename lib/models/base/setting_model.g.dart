// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingModel _$SettingModelFromJson(Map<String, dynamic> json) => SettingModel(
      isDarkTheme: json['isDarkTheme'] as bool?,
      isFirst: json['isFirst'] as bool?,
      dbRegion: $enumDecodeNullable(_$RegionEnumMap, json['dbRegion']),
    );

Map<String, dynamic> _$SettingModelToJson(SettingModel instance) =>
    <String, dynamic>{
      'isDarkTheme': instance.isDarkTheme,
      'isFirst': instance.isFirst,
      'dbRegion': _$RegionEnumMap[instance.dbRegion],
    };

const _$RegionEnumMap = {
  Region.kr: 'kr',
  Region.cn: 'cn',
};
