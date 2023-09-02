import 'package:arkhive/models/operator/module_model.dart';
import 'package:arkhive/models/operator/operator_model.dart';
import 'package:arkhive/models/operator/skill_model.dart';
import 'package:equatable/equatable.dart';

abstract class OperatorDataState extends Equatable {
  const OperatorDataState();

  @override
  List<Object?> get props => [];
}

class OperatorDataInitState extends OperatorDataState {
  const OperatorDataInitState();

  @override
  List<Object?> get props => [];
}

class OperatorDataLoadingState extends OperatorDataState {
  const OperatorDataLoadingState();

  @override
  List<Object?> get props => [];
}

class OperatorDataLoadedState extends OperatorDataState {
  final OperatorModel operator_;
  final List<SkillModel> skills;
  final List<ModuleModel> modules;
  final Map<String, ModuleDataModel> moduleDatas;

  const OperatorDataLoadedState({
    required this.operator_,
    required this.skills,
    required this.modules,
    required this.moduleDatas,
  });

  @override
  List<Object?> get props => [
        operator_,
        skills,
        modules,
        moduleDatas,
      ];
}

class OperatorDataErrorState extends OperatorDataState {
  final String message;

  const OperatorDataErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
