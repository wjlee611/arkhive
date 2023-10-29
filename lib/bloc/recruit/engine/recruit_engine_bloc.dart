import 'package:arkhive/bloc/recruit/engine/recruit_engine_event.dart';
import 'package:arkhive/bloc/recruit/engine/recruit_engine_state.dart';
import 'package:arkhive/enums/operator_position.dart';
import 'package:arkhive/enums/operator_profession.dart';
import 'package:arkhive/enums/rarity_tier.dart';
import 'package:arkhive/models/operator/operator_list_model.dart';
import 'package:arkhive/models/recruit/recruit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitEngineBloc extends Bloc<RecruitEngineEvent, RecruitEngineState> {
  final List<OperatorListModel> operators;

  RecruitEngineBloc({
    required this.operators,
  }) : super(RecruitEngineState.init(operators)) {
    on<RecruitEngineChangeStar>(_recruitEngineChangeStarHandler);
    on<RecruitEngineChangePosition>(_recruitEngineChangePositionHandler);
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

    _runEngine(emit);
  }

  Future<void> _recruitEngineChangePositionHandler(
    RecruitEngineChangePosition event,
    Emitter<RecruitEngineState> emit,
  ) async {
    Map<EOperatorPosition, bool> newTag = {};
    newTag
      ..addAll(state.position!)
      ..update(event.position, (value) => !value);

    emit(state.copyWith(position: newTag));

    _runEngine(emit);
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

    _runEngine(emit);
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

    _runEngine(emit);
  }

  Future<void> _runEngine(Emitter<RecruitEngineState> emit) async {
    List<RecruitModel> recruitList = [];

    // Star
    for (var tag in state.star!.entries) {
      if (tag.value) {
        recruitList.addAll(_generateList(
          recruitList,
          star: tag.key,
        ));
      }
    }

    // Range
    for (var tag in state.position!.entries) {
      if (tag.value) {
        recruitList.addAll(_generateList(
          recruitList,
          position: tag.key,
        ));
      }
    }

    // Profession
    for (var tag in state.profession!.entries) {
      if (tag.value) {
        recruitList.addAll(_generateList(
          recruitList,
          profession: tag.key,
        ));
      }
    }

    // Tag
    for (var tag in state.tags!.entries) {
      if (tag.value) {
        recruitList.addAll(_generateList(
          recruitList,
          tag: tag.key,
        ));
      }
    }

    for (var item in recruitList) {
      for (var op in item.operators) {
        print(op.name);
      }
    }
  }

  List<RecruitModel> _generateList(
    List<RecruitModel> prevList, {
    RecruitStar? star,
    EOperatorPosition? position,
    EOperatorProfession? profession,
    String? tag,
  }) {
    List<OperatorListModel> operatorResult = [];
    ERarityTier minTier = ERarityTier.max;

    // first run
    if (prevList.isEmpty) {
      if (star != null) {
        for (var op in operators) {
          if (rarityTierConverter(op.rarity) == star.tier) {
            operatorResult.add(op);
            if (minTier.value > rarityTierConverter(op.rarity).value) {
              minTier = rarityTierConverter(op.rarity);
            }
          }
        }
        return [
          RecruitModel(
            tags: [star.title],
            operators: operatorResult,
            minTier: minTier,
          )
        ];
      } else if (position != null) {
        for (var op in operators) {
          if (operatorPositionSelector(op.position) == position) {
            operatorResult.add(op);
            if (minTier.value > rarityTierConverter(op.rarity).value) {
              minTier = rarityTierConverter(op.rarity);
            }
          }
        }
        return [
          RecruitModel(
            tags: [position.value],
            operators: operatorResult,
            minTier: minTier,
          )
        ];
      } else if (profession != null) {
        for (var op in operators) {
          if (operatorProfessionSelector(op.profession) == profession) {
            operatorResult.add(op);
            if (minTier.value > rarityTierConverter(op.rarity).value) {
              minTier = rarityTierConverter(op.rarity);
            }
          }
        }
        return [
          RecruitModel(
            tags: [profession.ko],
            operators: operatorResult,
            minTier: minTier,
          )
        ];
      } else {}
    }
    // after run
    else {
      if (star != null) {
      } else if (position != null) {
      } else if (profession != null) {
      } else {}
    }
    return [];
  }
}
