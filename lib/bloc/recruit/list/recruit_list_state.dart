import 'package:arkhive/enums/common_load_state.dart';
import 'package:arkhive/models/operator/operator_list_model.dart';
import 'package:equatable/equatable.dart';

class RecruitListState extends Equatable {
  final List<String>? operatorNames;
  final List<OperatorListModel>? operators;
  final CommonLoadState status;

  const RecruitListState({
    this.operatorNames,
    this.operators,
    required this.status,
  });

  RecruitListState copyWith({
    List<String>? operatorNames,
    List<OperatorListModel>? operators,
    CommonLoadState? status,
  }) =>
      RecruitListState(
        operatorNames: operatorNames ?? this.operatorNames,
        operators: operators ?? this.operators,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        operatorNames,
        operators,
        status,
      ];
}
