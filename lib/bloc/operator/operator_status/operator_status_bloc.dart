import 'package:arkhive/bloc/operator/operator_status/operator_status_event.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_state.dart';
import 'package:arkhive/enums/attribute_type.dart';
import 'package:arkhive/models/common/attribute_modifiers_model.dart';
import 'package:arkhive/models/common/keyframe_data_model.dart';
import 'package:arkhive/models/operator/operator_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorStatusBloc
    extends Bloc<OperatorStatusEvent, OperatorStatusState> {
  late OperatorModel _operator;
  Map<String, double> _potentialDiff = {};
  Map<String, double> _favorDiff = {};

  OperatorStatusBloc() : super(const OperatorStatusState.init()) {
    on<OperatorStatusInitEvent>(_operatorStatusInitEventHandler);
    on<OperatorStatusPotentialChangeEvent>(
        _operatorStatusPotentialChangeEventHander);
    on<OperatorStatusEliteChangeEvent>(_operatorStatusEliteChangeEventHandler);
    on<OperatorStatusLevelChangeEvent>(_operatorStatusLevelChangeEventHandler);
    on<OperatorStatusFavorChangeEvent>(_operatorStatusFavorChangeEventHandler);
  }

  // initialize event
  Future<void> _operatorStatusInitEventHandler(
    OperatorStatusInitEvent event,
    Emitter<OperatorStatusState> emit,
  ) async {
    _operator = event.operator_;
    _updatePotentialDiff(potential: 0);
    _updateFavorDiff(favor: 0);

    KeyFrameDataModel initStats =
        _operator.phases.first.attributesKeyFrames!.first.data;

    emit(OperatorStatusState(
      potential: 0,
      elite: 0,
      level: 1,
      maxLevel: _operator.phases.first.maxLevel ?? 1,
      favor: 0,
      rangeId: _operator.phases.first.rangeId,
      maxHp: initStats.maxHp!.toDouble() +
          (_potentialDiff[EAttributeType.maxHp.value] ?? 0) +
          (_favorDiff[EAttributeType.maxHp.value] ?? 0),
      atk: initStats.atk!.toDouble() +
          (_potentialDiff[EAttributeType.atk.value] ?? 0) +
          (_favorDiff[EAttributeType.atk.value] ?? 0),
      def: initStats.def!.toDouble() +
          (_potentialDiff[EAttributeType.def.value] ?? 0) +
          (_favorDiff[EAttributeType.def.value] ?? 0),
      magicResistance: initStats.magicResistance! +
          (_potentialDiff[EAttributeType.magicRes.value] ?? 0) +
          (_favorDiff[EAttributeType.magicRes.value] ?? 0),
      respawnTime: initStats.respawnTime!.toDouble() +
          (_potentialDiff[EAttributeType.respawnTime.value] ?? 0),
      cost: initStats.cost!.toDouble() +
          (_potentialDiff[EAttributeType.cost.value] ?? 0),
      blockCnt: initStats.blockCnt!.toDouble(),
      atkSpeed: _atkSpeedCalculator(
        attackspeed: initStats.attackSpeed!,
        baseAttackTime: initStats.baseAttackTime!,
      ),
    ));
  }

  // Potential change event
  Future<void> _operatorStatusPotentialChangeEventHander(
    OperatorStatusPotentialChangeEvent event,
    Emitter<OperatorStatusState> emit,
  ) async {
    _updatePotentialDiff(potential: event.potential);

    KeyFrameDataModel firstStats =
        _operator.phases[state.elite].attributesKeyFrames!.first.data;
    KeyFrameDataModel lastStats =
        _operator.phases[state.elite].attributesKeyFrames!.last.data;
    int maxLevel = _operator.phases[state.elite].maxLevel ?? 1;

    emit(state.copyWith(
      potential: event.potential,
      maxHp: _statCalculator(
            first: firstStats.maxHp!.toDouble(),
            last: lastStats.maxHp!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.maxHp.value] ?? 0) +
          (_favorDiff[EAttributeType.maxHp.value] ?? 0),
      atk: _statCalculator(
            first: firstStats.atk!.toDouble(),
            last: lastStats.atk!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.atk.value] ?? 0) +
          (_favorDiff[EAttributeType.atk.value] ?? 0),
      def: _statCalculator(
            first: firstStats.def!.toDouble(),
            last: lastStats.def!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.def.value] ?? 0) +
          (_favorDiff[EAttributeType.def.value] ?? 0),
      magicResistance: _statCalculator(
            first: firstStats.magicResistance!,
            last: lastStats.magicResistance!,
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.magicRes.value] ?? 0) +
          (_favorDiff[EAttributeType.magicRes.value] ?? 0),
      respawnTime: _statCalculator(
            first: firstStats.respawnTime!.toDouble(),
            last: lastStats.respawnTime!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.respawnTime.value] ?? 0),
      cost: _statCalculator(
            first: firstStats.cost!.toDouble(),
            last: lastStats.cost!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.cost.value] ?? 0),
      blockCnt: _statCalculator(
        first: firstStats.blockCnt!.toDouble(),
        last: lastStats.blockCnt!.toDouble(),
        level: state.level,
        maxLevel: maxLevel,
      ),
      atkSpeed: _atkSpeedCalculator(
        attackspeed: _statCalculator(
          first: firstStats.attackSpeed!,
          last: lastStats.attackSpeed!,
          level: state.level,
          maxLevel: maxLevel,
        ),
        baseAttackTime: _statCalculator(
          first: firstStats.baseAttackTime!,
          last: lastStats.baseAttackTime!,
          level: state.level,
          maxLevel: maxLevel,
        ),
      ),
    ));
  }

  // Elite change event
  Future<void> _operatorStatusEliteChangeEventHandler(
    OperatorStatusEliteChangeEvent event,
    Emitter<OperatorStatusState> emit,
  ) async {
    KeyFrameDataModel stats =
        _operator.phases[event.elite].attributesKeyFrames!.first.data;

    emit(state.copyWith(
      elite: event.elite,
      rangeId: _operator.phases[event.elite].rangeId,
      level: 1,
      maxLevel: _operator.phases[event.elite].maxLevel ?? 1,
      maxHp: stats.maxHp!.toDouble() +
          (_potentialDiff[EAttributeType.maxHp.value] ?? 0) +
          (_favorDiff[EAttributeType.maxHp.value] ?? 0),
      atk: stats.atk!.toDouble() +
          (_potentialDiff[EAttributeType.atk.value] ?? 0) +
          (_favorDiff[EAttributeType.atk.value] ?? 0),
      def: stats.def!.toDouble() +
          (_potentialDiff[EAttributeType.def.value] ?? 0) +
          (_favorDiff[EAttributeType.def.value] ?? 0),
      magicResistance: stats.magicResistance! +
          (_potentialDiff[EAttributeType.magicRes.value] ?? 0) +
          (_favorDiff[EAttributeType.magicRes.value] ?? 0),
      respawnTime: stats.respawnTime!.toDouble() +
          (_potentialDiff[EAttributeType.respawnTime.value] ?? 0),
      cost: stats.cost!.toDouble() +
          (_potentialDiff[EAttributeType.cost.value] ?? 0),
      blockCnt: stats.blockCnt!.toDouble(),
      atkSpeed: _atkSpeedCalculator(
        attackspeed: stats.attackSpeed!,
        baseAttackTime: stats.baseAttackTime!,
      ),
    ));
  }

  // Level change event
  Future<void> _operatorStatusLevelChangeEventHandler(
    OperatorStatusLevelChangeEvent event,
    Emitter<OperatorStatusState> emit,
  ) async {
    KeyFrameDataModel firstStats =
        _operator.phases[state.elite].attributesKeyFrames!.first.data;
    KeyFrameDataModel lastStats =
        _operator.phases[state.elite].attributesKeyFrames!.last.data;
    int maxLevel = state.maxLevel;

    emit(state.copyWith(
      level: event.level,
      maxHp: _statCalculator(
            first: firstStats.maxHp!.toDouble(),
            last: lastStats.maxHp!.toDouble(),
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.maxHp.value] ?? 0) +
          (_favorDiff[EAttributeType.maxHp.value] ?? 0),
      atk: _statCalculator(
            first: firstStats.atk!.toDouble(),
            last: lastStats.atk!.toDouble(),
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.atk.value] ?? 0) +
          (_favorDiff[EAttributeType.atk.value] ?? 0),
      def: _statCalculator(
            first: firstStats.def!.toDouble(),
            last: lastStats.def!.toDouble(),
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.def.value] ?? 0) +
          (_favorDiff[EAttributeType.def.value] ?? 0),
      magicResistance: _statCalculator(
            first: firstStats.magicResistance!,
            last: lastStats.magicResistance!,
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.magicRes.value] ?? 0) +
          (_favorDiff[EAttributeType.magicRes.value] ?? 0),
      respawnTime: _statCalculator(
            first: firstStats.respawnTime!.toDouble(),
            last: lastStats.respawnTime!.toDouble(),
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.respawnTime.value] ?? 0),
      cost: _statCalculator(
            first: firstStats.cost!.toDouble(),
            last: lastStats.cost!.toDouble(),
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.cost.value] ?? 0),
      blockCnt: _statCalculator(
        first: firstStats.blockCnt!.toDouble(),
        last: lastStats.blockCnt!.toDouble(),
        level: event.level,
        maxLevel: maxLevel,
      ),
      atkSpeed: _atkSpeedCalculator(
        attackspeed: _statCalculator(
          first: firstStats.attackSpeed!,
          last: lastStats.attackSpeed!,
          level: event.level,
          maxLevel: maxLevel,
        ),
        baseAttackTime: _statCalculator(
          first: firstStats.baseAttackTime!,
          last: lastStats.baseAttackTime!,
          level: event.level,
          maxLevel: maxLevel,
        ),
      ),
    ));
  }

  // Favor change event
  Future<void> _operatorStatusFavorChangeEventHandler(
    OperatorStatusFavorChangeEvent event,
    Emitter<OperatorStatusState> emit,
  ) async {
    _updateFavorDiff(favor: event.favor);

    KeyFrameDataModel firstStats =
        _operator.phases[state.elite].attributesKeyFrames!.first.data;
    KeyFrameDataModel lastStats =
        _operator.phases[state.elite].attributesKeyFrames!.last.data;
    int maxLevel = state.maxLevel;

    emit(state.copyWith(
      favor: event.favor,
      maxHp: _statCalculator(
            first: firstStats.maxHp!.toDouble(),
            last: lastStats.maxHp!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.maxHp.value] ?? 0) +
          (_favorDiff[EAttributeType.maxHp.value] ?? 0),
      atk: _statCalculator(
            first: firstStats.atk!.toDouble(),
            last: lastStats.atk!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.atk.value] ?? 0) +
          (_favorDiff[EAttributeType.atk.value] ?? 0),
      def: _statCalculator(
            first: firstStats.def!.toDouble(),
            last: lastStats.def!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.def.value] ?? 0) +
          (_favorDiff[EAttributeType.def.value] ?? 0),
      magicResistance: _statCalculator(
            first: firstStats.magicResistance!,
            last: lastStats.magicResistance!,
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff[EAttributeType.magicRes.value] ?? 0) +
          (_favorDiff[EAttributeType.magicRes.value] ?? 0),
    ));
  }

  void _updatePotentialDiff({required int potential}) {
    _potentialDiff = {};
    for (int i = 0; i < potential; i++) {
      var pot = _operator.potentialRanks[i].buff?.attributes;
      if (pot?.attributeModifiers?.isNotEmpty == false) continue;

      for (AttributeModifiersModel modifier in pot?.attributeModifiers ?? []) {
        var key = attributeTypeConverter(modifier.attributeType);
        if (_potentialDiff.containsKey(key.value)) {
          _potentialDiff[key.value] =
              _potentialDiff[key.value]! + modifier.value;
        } else {
          _potentialDiff[key.value] = modifier.value;
        }
      }
    }
  }

  void _updateFavorDiff({required int favor}) {
    _favorDiff = {};
    OperatorFavorKeyFramesModel first = _operator.favorKeyFrames.first;
    OperatorFavorKeyFramesModel last = _operator.favorKeyFrames.last;
    final double fav = favor > 100 ? 50 : favor / 2;

    double diff = (last.data.maxHp! - first.data.maxHp!) / last.level;
    _favorDiff[EAttributeType.maxHp.value] = first.data.maxHp! + diff * fav;
    diff = (last.data.atk! - first.data.atk!) / last.level;
    _favorDiff[EAttributeType.atk.value] = first.data.atk! + diff * fav;
    diff = (last.data.def! - first.data.def!) / last.level;
    _favorDiff[EAttributeType.def.value] = first.data.def! + diff * fav;
    diff =
        (last.data.magicResistance! - first.data.magicResistance!) / last.level;
    _favorDiff[EAttributeType.magicRes.value] =
        first.data.magicResistance! + diff * fav;
  }

  double _atkSpeedCalculator({
    required double attackspeed,
    required double baseAttackTime,
  }) {
    return 1 /
        ((attackspeed + (_potentialDiff[EAttributeType.atkSpeed.value] ?? 0)) /
            baseAttackTime /
            100);
  }

  double _statCalculator({
    required double first,
    required double last,
    required int level,
    required int maxLevel,
  }) {
    double diff = (last - first) / (maxLevel - 1);
    return first + diff * (level - 1);
  }
}
