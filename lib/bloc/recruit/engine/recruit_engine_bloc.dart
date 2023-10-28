import 'package:arkhive/bloc/recruit/engine/recruit_engine_event.dart';
import 'package:arkhive/bloc/recruit/engine/recruit_engine_state.dart';
import 'package:arkhive/enums/operator_profession.dart';
import 'package:arkhive/models/operator/operator_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitEngineBloc extends Bloc<RecruitEngineEvent, RecruitEngineState> {
  final List<OperatorListModel> operators;

  RecruitEngineBloc({
    required this.operators,
  }) : super(RecruitEngineState.init(operators)) {
    on<RecruitEngineChangeStar>(_recruitEngineChangeStarHandler);
    on<RecruitEngineChangeRange>(_recruitEngineChangeRangeHandler);
    on<RecruitEngineChangeProfession>(_recruitEngineChangeProfessionHandler);
    on<RecruitEngineChangeTag>(_recruitEngineChangeTagHandler);
  }

  Future<void> _recruitEngineChangeStarHandler(
    RecruitEngineChangeStar event,
    Emitter<RecruitEngineState> emit,
  ) async {
    Map<RecruitStar, bool> newTag = {};
    newTag
      ..addAll(state.star!)
      ..update(event.star, (value) => !value);

    emit(state.copyWith(star: newTag));
  }

  Future<void> _recruitEngineChangeRangeHandler(
    RecruitEngineChangeRange event,
    Emitter<RecruitEngineState> emit,
  ) async {
    Map<RecruitRange, bool> newTag = {};
    newTag
      ..addAll(state.range!)
      ..update(event.range, (value) => !value);

    emit(state.copyWith(range: newTag));
  }

  Future<void> _recruitEngineChangeProfessionHandler(
    RecruitEngineChangeProfession event,
    Emitter<RecruitEngineState> emit,
  ) async {
    Map<EOperatorProfession, bool> newTag = {};
    newTag
      ..addAll(state.profession!)
      ..update(event.profession, (value) => !value);

    emit(state.copyWith(profession: newTag));
  }

  Future<void> _recruitEngineChangeTagHandler(
    RecruitEngineChangeTag event,
    Emitter<RecruitEngineState> emit,
  ) async {
    Map<String, bool> newTag = {};
    newTag
      ..addAll(state.tags!)
      ..update(event.tag, (value) => !value);

    emit(state.copyWith(tags: newTag));
  }
}
