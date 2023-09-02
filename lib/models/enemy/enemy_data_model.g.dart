// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enemy_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnemyDataModel _$EnemyDataModelFromJson(Map<String, dynamic> json) =>
    EnemyDataModel(
      key: json['Key'] as String?,
      value: (json['Value'] as List<dynamic>?)
          ?.map((e) => EnemyDataValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

EnemyDataValueModel _$EnemyDataValueModelFromJson(Map<String, dynamic> json) =>
    EnemyDataValueModel(
      level: json['level'] as int?,
      enemyData: json['enemyData'] == null
          ? null
          : EnemyDataDatasModel.fromJson(
              json['enemyData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EnemyDataValueModelToJson(
        EnemyDataValueModel instance) =>
    <String, dynamic>{
      'level': instance.level,
      'enemyData': instance.enemyData?.toJson(),
    };

EnemyDataDatasModel _$EnemyDataDatasModelFromJson(Map<String, dynamic> json) =>
    EnemyDataDatasModel(
      name: json['name'] == null
          ? null
          : AttributeMModel<String>.fromJson(
              json['name'] as Map<String, dynamic>),
      description: json['description'] == null
          ? null
          : AttributeMModel<String>.fromJson(
              json['description'] as Map<String, dynamic>),
      prefabKey: json['prefabKey'] == null
          ? null
          : AttributeMModel<String>.fromJson(
              json['prefabKey'] as Map<String, dynamic>),
      attributes: json['attributes'] == null
          ? null
          : AttributeModel.fromJson(json['attributes'] as Map<String, dynamic>),
      applyWay: json['applyWay'] == null
          ? null
          : AttributeMModel<String>.fromJson(
              json['applyWay'] as Map<String, dynamic>),
      motion: json['motion'] == null
          ? null
          : AttributeMModel<String>.fromJson(
              json['motion'] as Map<String, dynamic>),
      enemyTags: json['enemyTags'] == null
          ? null
          : AttributeMModel<List<String>>.fromJson(
              json['enemyTags'] as Map<String, dynamic>),
      lifePointReduce: json['lifePointReduce'] == null
          ? null
          : AttributeMModel<int>.fromJson(
              json['lifePointReduce'] as Map<String, dynamic>),
      levelType: json['levelType'] == null
          ? null
          : AttributeMModel<String>.fromJson(
              json['levelType'] as Map<String, dynamic>),
      rangeRadius: json['rangeRadius'] == null
          ? null
          : AttributeMModel<double>.fromJson(
              json['rangeRadius'] as Map<String, dynamic>),
      numOfExtraDrops: json['numOfExtraDrops'] == null
          ? null
          : AttributeMModel<int>.fromJson(
              json['numOfExtraDrops'] as Map<String, dynamic>),
      viewRadius: json['viewRadius'] == null
          ? null
          : AttributeMModel<double>.fromJson(
              json['viewRadius'] as Map<String, dynamic>),
      notCountInTotal: json['notCountInTotal'] == null
          ? null
          : AttributeMModel<bool>.fromJson(
              json['notCountInTotal'] as Map<String, dynamic>),
      talentBlackboard: (json['talentBlackboard'] as List<dynamic>?)
          ?.map(
              (e) => TalentBlackboardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EnemyDataDatasModelToJson(
        EnemyDataDatasModel instance) =>
    <String, dynamic>{
      'name': instance.name?.toJson(),
      'description': instance.description?.toJson(),
      'prefabKey': instance.prefabKey?.toJson(),
      'attributes': instance.attributes?.toJson(),
      'applyWay': instance.applyWay?.toJson(),
      'motion': instance.motion?.toJson(),
      'enemyTags': instance.enemyTags?.toJson(),
      'lifePointReduce': instance.lifePointReduce?.toJson(),
      'levelType': instance.levelType?.toJson(),
      'rangeRadius': instance.rangeRadius?.toJson(),
      'numOfExtraDrops': instance.numOfExtraDrops?.toJson(),
      'viewRadius': instance.viewRadius?.toJson(),
      'notCountInTotal': instance.notCountInTotal?.toJson(),
      'talentBlackboard':
          instance.talentBlackboard?.map((e) => e.toJson()).toList(),
    };
