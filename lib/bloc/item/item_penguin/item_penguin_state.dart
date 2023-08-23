import 'package:arkhive/models/base/penguin_model.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:equatable/equatable.dart';

class ItemPenguinState extends Equatable {
  final List<PenguinItemModel>? sortedPenguin;
  final List<PenguinItemModel>? filteredPenguin;
  final PenguinSortOption? sortOption;
  final bool isIncludePerm;
  final CommonLoadState? status;

  const ItemPenguinState({
    this.sortedPenguin,
    this.filteredPenguin,
    this.sortOption,
    this.isIncludePerm = true,
    this.status,
  });

  ItemPenguinState copyWith({
    List<PenguinItemModel>? sortedPenguin,
    List<PenguinItemModel>? filteredPenguin,
    PenguinSortOption? sortOption,
    bool? isIncludePerm,
    CommonLoadState? status,
  }) =>
      ItemPenguinState(
        sortedPenguin: sortedPenguin ?? this.sortedPenguin,
        filteredPenguin: filteredPenguin ?? this.filteredPenguin,
        sortOption: sortOption ?? this.sortOption,
        isIncludePerm: isIncludePerm ?? this.isIncludePerm,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        sortedPenguin,
        filteredPenguin,
        sortOption,
        isIncludePerm,
        status,
      ];
}

enum PenguinSortOption {
  sanity('이성 효율', '이성/1개'),
  rate('드랍률', '(%)'),
  times('보고서 수', '개');

  final String message;
  final String unit;

  const PenguinSortOption(
    this.message,
    this.unit,
  );
}
