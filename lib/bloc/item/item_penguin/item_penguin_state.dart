import 'package:arkhive/models/base/penguin_model.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:equatable/equatable.dart';

class ItemPenguinState extends Equatable {
  final List<PenguinSortModel>? sortedPenguin;
  final PenguinSortOption? sortOption;
  final CommonLoadState? status;

  const ItemPenguinState({
    this.sortedPenguin,
    this.sortOption,
    this.status,
  });

  ItemPenguinState copyWith({
    List<PenguinSortModel>? sortedPenguin,
    PenguinSortOption? sortOption,
    CommonLoadState? status,
  }) =>
      ItemPenguinState(
        sortedPenguin: sortedPenguin ?? this.sortedPenguin,
        sortOption: sortOption ?? this.sortOption,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        sortedPenguin,
        sortOption,
        status,
      ];
}

enum PenguinSortOption {
  sanity('이성 효율', '이성/1개'),
  rate('드랍률', '%'),
  times('보고서 수', '개');

  final String message;
  final String unit;

  const PenguinSortOption(
    this.message,
    this.unit,
  );
}
