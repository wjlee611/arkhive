import 'package:arkhive/bloc/recruit/engine/recruit_engine_state.dart';
import 'package:arkhive/enums/operator_position.dart';
import 'package:arkhive/enums/operator_profession.dart';

abstract class RecruitEngineEvent {}

class RecruitEngineChangeStar extends RecruitEngineEvent {
  final RecruitStar star;

  RecruitEngineChangeStar(this.star);
}

class RecruitEngineChangePosition extends RecruitEngineEvent {
  final EOperatorPosition position;

  RecruitEngineChangePosition(this.position);
}

class RecruitEngineChangeProfession extends RecruitEngineEvent {
  final EOperatorProfession profession;

  RecruitEngineChangeProfession(this.profession);
}

class RecruitEngineChangeTag extends RecruitEngineEvent {
  final String tag;

  RecruitEngineChangeTag(this.tag);
}
