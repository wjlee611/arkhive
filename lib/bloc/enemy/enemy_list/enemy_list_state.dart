import 'package:equatable/equatable.dart';
import 'package:arkhive/models/enemy_list_model.dart';

abstract class EnemyListState extends Equatable {
  final List<EnemyListModel>? enemyList;

  /// [normal, elite, boss]
  final List<bool>? selectedFilterOption;
  final String? searchQuery;

  const EnemyListState({
    this.enemyList,
    this.selectedFilterOption,
    this.searchQuery,
  });
}

class EnemyListInitState extends EnemyListState {
  EnemyListInitState()
      : super(
          enemyList: [],
          selectedFilterOption: [true, true, true],
          searchQuery: "",
        );

  @override
  List<Object?> get props => [
        enemyList,
        selectedFilterOption,
        searchQuery,
      ];
}

class EnemyListLoadingState extends EnemyListState {
  const EnemyListLoadingState({
    super.enemyList,
    super.selectedFilterOption,
    super.searchQuery,
  });

  @override
  List<Object?> get props => [
        enemyList,
        selectedFilterOption,
        searchQuery,
      ];
}

class EnemyListLoadedState extends EnemyListState {
  final List<EnemyListModel> filteredEnemyList;

  const EnemyListLoadedState({
    super.enemyList,
    required this.filteredEnemyList,
    super.selectedFilterOption,
    super.searchQuery,
  });

  @override
  List<Object?> get props => [
        enemyList,
        filteredEnemyList,
        selectedFilterOption,
        searchQuery,
      ];
}

class EnemyListErrorState extends EnemyListState {
  final String message;

  const EnemyListErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
