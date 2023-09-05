import 'package:arkhive/models/common/attribute_m_model.dart';
import 'package:arkhive/models/common/attribute_model.dart';
import 'package:arkhive/models/common/talent_blackboard_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enemy_data_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createToJson: false,
)
class EnemyDataModel extends Equatable {
  @JsonKey(name: 'Key')
  final String? key;
  @JsonKey(name: 'Value')
  final List<EnemyDataValueModel>? value;

  const EnemyDataModel({
    this.key,
    this.value,
  });

  factory EnemyDataModel.fromJson(Map<String, dynamic> json) =>
      _$EnemyDataModelFromJson(json);

  @override
  List<Object?> get props => [
        key,
        value,
      ];
}

@JsonSerializable(explicitToJson: true)
class EnemyDataValueModel extends Equatable {
  final int? level;
  final EnemyDataDatasModel? enemyData;

  const EnemyDataValueModel({
    this.level,
    this.enemyData,
  });

  factory EnemyDataValueModel.fromJson(Map<String, dynamic> json) =>
      _$EnemyDataValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnemyDataValueModelToJson(this);

  @override
  List<Object?> get props => [
        level,
        enemyData,
      ];
}

@JsonSerializable(explicitToJson: true)
class EnemyDataDatasModel extends Equatable {
  final AttributeMModel<String>? name;
  final AttributeMModel<String>? description;
  final AttributeMModel<String>? prefabKey;
  final AttributeModel? attributes;
  final AttributeMModel<String>? applyWay; // CN: ALL, MELEE, NONE, RANGED
  final AttributeMModel<String>? motion; // CN
  final AttributeMModel<List<String>>? enemyTags; // CN
  final AttributeMModel<int>? lifePointReduce;
  final AttributeMModel<String>? levelType; // CN: int -> String
  final AttributeMModel<double>? rangeRadius;
  final AttributeMModel<int>? numOfExtraDrops;
  final AttributeMModel<double>? viewRadius;
  final AttributeMModel<bool>? notCountInTotal; // CN
  final List<TalentBlackboardModel>? talentBlackboard;
  // "skills": null,
  // "spData": null

  const EnemyDataDatasModel({
    this.name,
    this.description,
    this.prefabKey,
    this.attributes,
    this.applyWay,
    this.motion,
    this.enemyTags,
    this.lifePointReduce,
    this.levelType,
    this.rangeRadius,
    this.numOfExtraDrops,
    this.viewRadius,
    this.notCountInTotal,
    this.talentBlackboard,
  });

  factory EnemyDataDatasModel.fromJson(Map<String, dynamic> json) =>
      _$EnemyDataDatasModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnemyDataDatasModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        description,
        prefabKey,
        attributes,
        applyWay,
        motion,
        enemyTags,
        lifePointReduce,
        levelType,
        rangeRadius,
        numOfExtraDrops,
        viewRadius,
        notCountInTotal,
        talentBlackboard,
      ];
}
