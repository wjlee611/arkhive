import 'package:arkhive/bloc/recruit/engine/recruit_engine_state.dart';
import 'package:arkhive/enums/operator_profession.dart';

abstract class RecruitEngineEvent {}

class RecruitEngineChangeStar extends RecruitEngineEvent {
  final RecruitStar star;

  RecruitEngineChangeStar(this.star);
}

class RecruitEngineChangeRange extends RecruitEngineEvent {
  final RecruitRange range;

  RecruitEngineChangeRange(this.range);
}

class RecruitEngineChangeProfession extends RecruitEngineEvent {
  final EOperatorProfession profession;

  RecruitEngineChangeProfession(this.profession);
}

class RecruitEngineChangeTag extends RecruitEngineEvent {
  final String tag;

  RecruitEngineChangeTag(this.tag);
}
