import 'package:equatable/equatable.dart';

abstract class EnemyListEvent extends Equatable {
  const EnemyListEvent();

  @override
  List<Object?> get props => [];
}

class EnemyListInitEvent extends EnemyListEvent {
  const EnemyListInitEvent();

  @override
  List<Object?> get props => [];
}

class EnemyListSelectFiltersEvent extends EnemyListEvent {
  final List<bool> filters;

  const EnemyListSelectFiltersEvent({
    required this.filters,
  });

  @override
  List<Object?> get props => [filters];
}

class EnemyListSearchEvent extends EnemyListEvent {
  final String searchQuery;

  const EnemyListSearchEvent({
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [searchQuery];
}
