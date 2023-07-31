import 'package:arkhive/models/common_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagsCubit extends Cubit<TagsState> {
  TagsCubit() : super(const TagsState(status: CommonLoadState.init));

  Future<void> loadTags() async {
    emit(state.copyWith(status: CommonLoadState.loading));

    await Future.delayed(const Duration(milliseconds: 1000));

    emit(state.copyWith(status: CommonLoadState.loaded));
  }
}

class TagsState extends Equatable {
  // TODO: modeling tags
  final CommonLoadState? status;

  const TagsState({
    this.status,
  });

  TagsState copyWith({
    CommonLoadState? status,
  }) =>
      TagsState(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status];
}
