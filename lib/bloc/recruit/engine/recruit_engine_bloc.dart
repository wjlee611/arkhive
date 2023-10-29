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

    // 고특채인 경우에만 6성 오퍼 포함
    // 그리고 레어도 순 정렬
    for (var item in recruitList) {
      if (!item.tags.contains(RecruitStar.advSpecial.title)) {
        item.operators.removeWhere(
            (op) => rarityTierConverter(op.rarity) == ERarityTier.tier6);
      }
      item.operators.sort(
        (a, b) =>
            rarityTierConverter(b.rarity).value -
            rarityTierConverter(a.rarity).value,
      );
    }

    // 고벨류 우선 정렬
    // 이후 확신 타겟 우선 정렬
    recruitList.sort((a, b) {
      int cmp = b.minTier.value - a.minTier.value;
      if (cmp != 0) return cmp;
      return a.operators.length - b.operators.length;
    });

    emit(state.copyWith(recruitList: recruitList));
  }

  List<RecruitModel> _generateList(
    List<RecruitModel> prevList, {
    RecruitStar? star,
    EOperatorPosition? position,
    EOperatorProfession? profession,
    String? tag,
  }) {
    List<RecruitModel> copyPrevList = [];
    List<RecruitModel> result = [];
    ERarityTier minTier = ERarityTier.max;

    copyPrevList
      ..addAll(prevList)
      ..add(RecruitModel(
        tags: const [],
        operators: operators,
        minTier: minTier,
      ));

    // Ganarate List with adding Star
    if (star != null) {
      for (var prev in copyPrevList) {
        List<OperatorListModel> operatorResult = [];
        // filtering operator
        for (var prevOp in prev.operators) {
          if (rarityTierConverter(prevOp.rarity) == star.tier) {
            operatorResult.add(prevOp);
            if (minTier.value > rarityTierConverter(prevOp.rarity).value) {
              minTier = rarityTierConverter(prevOp.rarity);
            }
          }
        }

        if (operatorResult.isEmpty) continue;

        result.add(RecruitModel(
          tags: [...prev.tags, star.title],
          operators: operatorResult,
          minTier: minTier,
        ));
      }
      return result;
    }
    // Ganarate List with adding Position
    else if (position != null) {
      for (var prev in copyPrevList) {
        List<OperatorListModel> operatorResult = [];
        // filtering operator
        for (var prevOp in prev.operators) {
          if (operatorPositionSelector(prevOp.position) == position) {
            operatorResult.add(prevOp);
            if (minTier.value > rarityTierConverter(prevOp.rarity).value) {
              minTier = rarityTierConverter(prevOp.rarity);
            }
          }
        }

        if (operatorResult.isEmpty) continue;

        result.add(RecruitModel(
          tags: [...prev.tags, position.value],
          operators: operatorResult,
          minTier: minTier,
        ));
      }
      return result;
    }
    // Ganarate List with adding Profession
    else if (profession != null) {
      for (var prev in copyPrevList) {
        List<OperatorListModel> operatorResult = [];
        // filtering operator
        for (var prevOp in prev.operators) {
          if (operatorProfessionSelector(prevOp.profession) == profession) {
            operatorResult.add(prevOp);
            if (minTier.value > rarityTierConverter(prevOp.rarity).value) {
              minTier = rarityTierConverter(prevOp.rarity);
            }
          }
        }

        if (operatorResult.isEmpty) continue;

        result.add(RecruitModel(
          tags: [...prev.tags, profession.ko],
          operators: operatorResult,
          minTier: minTier,
        ));
      }
      return result;
    }
    // Ganarate List with adding Tag
    else if (tag != null) {
      for (var prev in copyPrevList) {
        List<OperatorListModel> operatorResult = [];
        // filtering operator
        for (var prevOp in prev.operators) {
          if (prevOp.tagList.contains(tag)) {
            operatorResult.add(prevOp);
            if (minTier.value > rarityTierConverter(prevOp.rarity).value) {
              minTier = rarityTierConverter(prevOp.rarity);
            }
          }
        }

        if (operatorResult.isEmpty) continue;

        result.add(RecruitModel(
          tags: [...prev.tags, tag],
          operators: operatorResult,
          minTier: minTier,
        ));
      }
      return result;
    }

    return [];
  }
}
