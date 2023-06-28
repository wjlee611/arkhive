import 'package:arkhive/models/stage_list_model.dart';
import 'package:equatable/equatable.dart';

abstract class StageListState extends Equatable {
  const StageListState();

  @override
  List<Object?> get props => [];
}

class StageListInitState extends StageListState {
  const StageListInitState();

  @override
  List<Object?> get props => [];
}

class StageListLoadingState extends StageListState {
  const StageListLoadingState();

  @override
  List<Object?> get props => [];
}

class StageListLoadedState extends StageListState {
  final List<CategoryListModel> categories;

  const StageListLoadedState({
    required this.categories,
  });

  @override
  List<Object?> get props => [categories];
}

class StageListErrorState extends StageListState {
  final String message;

  const StageListErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
