import 'package:arkhive/models/common_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PenguinCubit extends Cubit<PenguinState> {
  PenguinCubit() : super(const PenguinState(status: CommonLoadState.init));

  Future<void> loadPenguin() async {
    emit(state.copyWith(status: CommonLoadState.loading));

    await Future.delayed(const Duration(milliseconds: 1000));

    emit(state.copyWith(status: CommonLoadState.loaded));
  }
}

class PenguinState extends Equatable {
  // TODO: modeling tags
  final CommonLoadState? status;

  const PenguinState({
    this.status,
  });

  PenguinState copyWith({
    CommonLoadState? status,
  }) =>
      PenguinState(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status];
}
