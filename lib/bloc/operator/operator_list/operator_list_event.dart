import 'package:arkhive/bloc/operator/operator_list/operator_list_state.dart';
import 'package:equatable/equatable.dart';

abstract class OperatorListEvent extends Equatable {
  const OperatorListEvent();

  @override
  List<Object?> get props => [];
}

class OperatorListInitEvent extends OperatorListEvent {
  const OperatorListInitEvent();

  @override
  List<Object?> get props => [];
}

class OperatorListSelectProfessionsEvent extends OperatorListEvent {
  final Professions profession;

  const OperatorListSelectProfessionsEvent({
    required this.profession,
  });

  @override
  List<Object?> get props => [profession];
}

class OperatorListSortEvent extends OperatorListEvent {
  final SortOptions sortOption;

  const OperatorListSortEvent({
    required this.sortOption,
  });

  @override
  List<Object?> get props => [sortOption];
}

class OperatorListSearchEvent extends OperatorListEvent {
  final String searchQuery;

  const OperatorListSearchEvent({
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [searchQuery];
}
