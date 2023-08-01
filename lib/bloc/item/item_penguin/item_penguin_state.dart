import 'package:arkhive/models/base/penguin_model.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:equatable/equatable.dart';

class ItemPenguinState extends Equatable {
  final List<PenguinSortModel>? sortedPenguin;
  final CommonLoadState? status;

  const ItemPenguinState({
    this.sortedPenguin,
    this.status,
  });

  @override
  List<Object?> get props => [
        sortedPenguin,
        status,
      ];
}

enum PenguinSortOption {
  sanity('이성 효율'),
  rate('드랍률'),
  times('보고서 수');

  final String message;

  const PenguinSortOption(this.message);
}
