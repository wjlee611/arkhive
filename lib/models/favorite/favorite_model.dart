import 'package:arkhive/tools/gamedata_root.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_model.g.dart';

enum FavorCategory {
  item('창고 아이템'),
  stage('스테이지'),
  oper('오퍼레이터'),
  enemy('적');

  final String message;

  const FavorCategory(this.message);
}

@JsonSerializable()
class FavoriteModel extends Equatable {
  final String? key;
  final String? iconId;
  final String? name;
  final String? diffGroup, difficulty; // only stage
  final FavorCategory? category;
  final Region? saveRegion;

  const FavoriteModel({
    this.key,
    this.iconId,
    this.name,
    this.diffGroup,
    this.difficulty,
    this.category,
    this.saveRegion,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);

  @override
  List<Object?> get props => [
        key,
        category,
      ];
}
