import 'package:arkhive/models/operator/operator_list_model.dart';

abstract class RecruitListEvent {}

class RecruitListInitEvent extends RecruitListEvent {}

class RecruitListOpInitEvent extends RecruitListEvent {
  final List<OperatorListModel> operators;

  RecruitListOpInitEvent(this.operators);
}
