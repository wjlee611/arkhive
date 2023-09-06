import 'package:arkhive/models/operator/operator_list_model.dart';
import 'package:equatable/equatable.dart';

enum SortOptions {
  starUp,
  starDown,
  nameUp,
  nameDown,
}

enum Professions {
  all,
  vanguard,
  guard,
  defender,
  sniper,
  caster,
  medic,
  supporter,
  specialist,
  perparation
}

abstract class OperatorListState extends Equatable {
  final List<OperatorListModel>? operatorList;

  final Professions? selectedProfession;
  final SortOptions? selectedSortOption;
  final String? searchQuery;

  const OperatorListState({
    this.operatorList,
    this.selectedProfession,
    this.selectedSortOption,
    this.searchQuery,
  });
}

class OperatorListInitState extends OperatorListState {
  OperatorListInitState()
      : super(
          operatorList: [],
          selectedProfession: Professions.all,
          selectedSortOption: SortOptions.starUp,
          searchQuery: "",
        );

  @override
  List<Object?> get props => [
        operatorList,
        selectedProfession,
        selectedSortOption,
        searchQuery,
      ];
}

class OperatorListLoadingState extends OperatorListState {
  const OperatorListLoadingState({
    super.operatorList,
    super.selectedProfession,
    super.selectedSortOption,
    super.searchQuery,
  });

  @override
  List<Object?> get props => [
        operatorList,
        selectedProfession,
        selectedSortOption,
        searchQuery,
      ];
}

class OperatorListLoadedState extends OperatorListState {
  final List<OperatorListModel> filteredOperatorList;

  const OperatorListLoadedState({
    super.operatorList,
    required this.filteredOperatorList,
    super.selectedProfession,
    super.selectedSortOption,
    super.searchQuery,
  });

  @override
  List<Object?> get props => [
        operatorList,
        filteredOperatorList,
        selectedProfession,
        selectedSortOption,
        searchQuery,
      ];
}

class OperatorListErrorState extends OperatorListState {
  final String message;

  const OperatorListErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
