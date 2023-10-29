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
    on<RecruitEngineResetTag>(_recruitEngineResetTagHandler);
  }

  Future<void> _recruitEngineChangeStarHandler(
    RecruitEngineChangeStar event,
    Emitter<RecruitEngineState> emit,
  ) async {
    if (state.star?[event.star] == false && _isFullChecked()) {
      return;
    }

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
    if (state.position?[event.position] == false && _isFullChecked()) {
      return;
    }

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
    if (state.profession?[event.profession] == false && _isFullChecked()) {
      return;
    }

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
    if (state.tags?[event.tag] == false && _isFullChecked()) {
      return;
    }

    Map<String, bool> newTag = {};
    newTag
      ..addAll(state.tags!)
      ..update(event.tag, (value) => !value);

    emit(state.copyWith(tags: newTag));

    _runEngine(emit);
  }

  Future<void> _recruitEngineResetTagHandler(
    RecruitEngineResetTag event,
    Emitter<RecruitEngineState> emit,
  ) async {
    emit(RecruitEngineState.init(operators));
  }

  bool _isFullChecked() {
    int checked = 0;

    // Star
    for (var tag in state.star!.entries) {
      if (tag.value) {
        checked++;
      }
    }
    // Range
    for (var tag in state.position!.entries) {
      if (tag.value) {
        checked++;
      }
    }
    // Profession
    for (var tag in state.profession!.entries) {
      if (tag.value) {
        checked++;
      }
    }
    // Tag
    for (var tag in state.tags!.entries) {
      if (tag.value) {
        checked++;
      }
    }

    if (checked >= 5) return true;
    return false;
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

    // 빈 리스트 제거
    recruitList.removeWhere((item) => item.operators.isEmpty);

    // 정렬
    recruitList.sort((a, b) {
      // 추천 우선 정렬
      int valA = a.maxTier.value + a.minTier.value;
      int valB = b.maxTier.value + b.minTier.value;
      valA = valA == 2 ? 9 : valA;
      valB = valB == 2 ? 9 : valB;
      int cmp = valB - valA;
      if (cmp != 0) return cmp;
      // 이후 확신 타겟 우선 정렬
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

    copyPrevList
      ..addAll(prevList)
      ..add(RecruitModel(
        tags: const [],
        operators: operators,
        minTier: ERarityTier.max,
        maxTier: ERarityTier.tier1,
      ));

    // Ganarate List with adding Star
    if (star != null) {
      for (var prev in copyPrevList) {
        List<OperatorListModel> operatorResult = [];
        ERarityTier minTier = ERarityTier.max;
        ERarityTier maxTier = ERarityTier.tier1;
        // filtering operator
        for (var prevOp in prev.operators) {
          if (rarityTierConverter(prevOp.rarity) == star.tier) {
            operatorResult.add(prevOp);
            if (minTier.value > rarityTierConverter(prevOp.rarity).value) {
              minTier = rarityTierConverter(prevOp.rarity);
            }
            if (maxTier.value < rarityTierConverter(prevOp.rarity).value) {
              maxTier = rarityTierConverter(prevOp.rarity);
            }
          }
        }

        if (operatorResult.isEmpty) continue;

        result.add(RecruitModel(
          tags: [...prev.tags, star.title],
          operators: operatorResult,
          minTier: minTier,
          maxTier: maxTier,
        ));
      }
      return result;
    }
    // Ganarate List with adding Position
    else if (position != null) {
      for (var prev in copyPrevList) {
        List<OperatorListModel> operatorResult = [];
        ERarityTier minTier = ERarityTier.max;
        ERarityTier maxTier = ERarityTier.tier1;
        // filtering operator
        for (var prevOp in prev.operators) {
          if (operatorPositionSelector(prevOp.position) == position) {
            operatorResult.add(prevOp);
            if (minTier.value > rarityTierConverter(prevOp.rarity).value) {
              minTier = rarityTierConverter(prevOp.rarity);
            }
            if (maxTier.value < rarityTierConverter(prevOp.rarity).value) {
              maxTier = rarityTierConverter(prevOp.rarity);
            }
          }
        }

        if (operatorResult.isEmpty) continue;

        result.add(RecruitModel(
          tags: [...prev.tags, position.value],
          operators: operatorResult,
          minTier: minTier,
          maxTier: maxTier,
        ));
      }
      return result;
    }
    // Ganarate List with adding Profession
    else if (profession != null) {
      for (var prev in copyPrevList) {
        List<OperatorListModel> operatorResult = [];
        ERarityTier minTier = ERarityTier.max;
        ERarityTier maxTier = ERarityTier.tier1;
        // filtering operator
        for (var prevOp in prev.operators) {
          if (operatorProfessionSelector(prevOp.profession) == profession) {
            operatorResult.add(prevOp);
            if (minTier.value > rarityTierConverter(prevOp.rarity).value) {
              minTier = rarityTierConverter(prevOp.rarity);
            }
            if (maxTier.value < rarityTierConverter(prevOp.rarity).value) {
              maxTier = rarityTierConverter(prevOp.rarity);
            }
          }
        }

        if (operatorResult.isEmpty) continue;

        result.add(RecruitModel(
          tags: [...prev.tags, profession.ko],
          operators: operatorResult,
          minTier: minTier,
          maxTier: maxTier,
        ));
      }
      return result;
    }
    // Ganarate List with adding Tag
    else if (tag != null) {
      for (var prev in copyPrevList) {
        List<OperatorListModel> operatorResult = [];
        ERarityTier minTier = ERarityTier.max;
        ERarityTier maxTier = ERarityTier.tier1;
        // filtering operator
        for (var prevOp in prev.operators) {
          if (prevOp.tagList.contains(tag)) {
            operatorResult.add(prevOp);
            if (minTier.value > rarityTierConverter(prevOp.rarity).value) {
              minTier = rarityTierConverter(prevOp.rarity);
            }
            if (maxTier.value < rarityTierConverter(prevOp.rarity).value) {
              maxTier = rarityTierConverter(prevOp.rarity);
            }
          }
        }

        if (operatorResult.isEmpty) continue;

        result.add(RecruitModel(
          tags: [...prev.tags, tag],
          operators: operatorResult,
          minTier: minTier,
          maxTier: maxTier,
        ));
      }
      return result;
    }

    return [];
  }
}
