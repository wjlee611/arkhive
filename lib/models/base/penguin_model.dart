import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'penguin_model.g.dart';

@JsonSerializable()
class PenguinModel extends Equatable {
  final String? stageId;
  final String? itemId;
  final int? times;
  final int? quantity;
  final int? start;

  PenguinModel({
    String? stageId,
    this.itemId,
    this.times,
    this.quantity,
    this.start,
  }) : stageId = stageId?.replaceAll('_perm', '');

  factory PenguinModel.fromJson(Map<String, dynamic> json) =>
      _$PenguinModelFromJson(json);

  Map<String, dynamic> toJson() => _$PenguinModelToJson(this);

  @override
  List<Object?> get props => [
        stageId,
        itemId,
      ];
}

// 스테이지별 아이템 모델
class PenguinStageModel extends Equatable {
  final PenguinModel? penguin;
  final String? name, iconId;
  final bool isFirstDrop;
  final int? sanityx1000;
  final int? ratex1000;
  final int? times;

  const PenguinStageModel({
    this.penguin,
    this.name,
    this.iconId,
    bool? isFirstDrop,
    this.sanityx1000,
    this.ratex1000,
    this.times,
  }) : isFirstDrop = isFirstDrop ?? false;

  @override
  List<Object?> get props => [
        penguin,
        name,
        iconId,
        isFirstDrop,
        sanityx1000,
        ratex1000,
        times,
      ];
}

// 아이템별 스테이지 모델
class PenguinItemModel extends Equatable {
  final PenguinModel penguin;
  final String? stageCode, diffGroup, difficulty, stageType;
  final int? sanityx1000;
  final int? ratex1000;
  final int? times;

  const PenguinItemModel({
    required this.penguin,
    this.stageCode,
    this.diffGroup,
    this.difficulty,
    this.stageType,
    this.sanityx1000,
    this.ratex1000,
    this.times,
  });

  @override
  List<Object?> get props => [
        penguin,
        stageCode,
        diffGroup,
        stageType,
        sanityx1000,
        ratex1000,
        times,
      ];
}

// 스테이지별 아이템 드랍률
class PenguinStage extends Equatable {
  final Map<String, List<PenguinModel>>? withId;

  const PenguinStage({
    this.withId,
  });

  PenguinStage copyWith({
    required PenguinModel penguin,
  }) {
    Map<String, List<PenguinModel>> withId = this.withId ?? {};

    if (penguin.stageId == null) {
      return PenguinStage(withId: withId);
    }
    // except randomMaterial
    if ((penguin.stageId?.contains('randomMaterial') ?? true) ||
        (penguin.itemId?.contains('randomMaterial') ?? true)) {
      return PenguinStage(withId: withId);
    }

    if (withId[penguin.stageId!] == null) {
      withId[penguin.stageId!] = [];
    }

    if (withId[penguin.stageId!]!.contains(penguin)) {
      // update
      int idx = withId[penguin.stageId!]!.indexOf(penguin);
      if ((withId[penguin.stageId!]![idx].start ?? 0) < (penguin.start ?? 0)) {
        withId[penguin.stageId!]![idx] = penguin;
      }
    } else {
      // add
      withId[penguin.stageId!]!.add(penguin);
    }

    return PenguinStage(withId: withId);
  }

  @override
  List<Object?> get props => [withId];
}

// 아이템별 스테이지 드랍률
class PenguinItem extends Equatable {
  final Map<String, List<PenguinModel>>? withId;

  const PenguinItem({
    this.withId,
  });

  PenguinItem copyWith({
    required PenguinModel penguin,
  }) {
    Map<String, List<PenguinModel>> withId = this.withId ?? {};

    if (penguin.itemId == null) {
      return PenguinItem(withId: withId);
    }
    // except randomMaterial
    if ((penguin.stageId?.contains('randomMaterial') ?? true) ||
        (penguin.itemId?.contains('randomMaterial') ?? true)) {
      return PenguinItem(withId: withId);
    }

    if (withId[penguin.itemId!] == null) {
      withId[penguin.itemId!] = [];
    }

    if (withId[penguin.itemId!]!.contains(penguin)) {
      // update
      int idx = withId[penguin.itemId!]!.indexOf(penguin);
      if ((withId[penguin.itemId!]![idx].start ?? 0) < (penguin.start ?? 0)) {
        withId[penguin.itemId!]![idx] = penguin;
      }
    } else {
      // add
      withId[penguin.itemId!]!.add(penguin);
    }

    return PenguinItem(withId: withId);
  }

  @override
  List<Object?> get props => [withId];
}
