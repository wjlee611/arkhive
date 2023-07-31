import 'package:arkhive/models/common_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RangeCubit extends Cubit<RangeState> {
  RangeCubit() : super(const RangeState(status: CommonLoadState.init));

  Future<void> loadRange() async {
    emit(state.copyWith(status: CommonLoadState.loading));

    await Future.delayed(const Duration(milliseconds: 1000));

    emit(state.copyWith(status: CommonLoadState.loaded));
  }
}

class RangeState extends Equatable {
  // TODO: modeling tags
  final CommonLoadState? status;

  const RangeState({
    this.status,
  });

  RangeState copyWith({
    CommonLoadState? status,
  }) =>
      RangeState(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status];
}
