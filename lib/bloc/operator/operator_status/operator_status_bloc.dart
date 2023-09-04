import 'package:arkhive/bloc/operator/operator_status/operator_status_event.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_state.dart';
import 'package:arkhive/models/common/attribute_model.dart';
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

    AttributeModel initStats =
        _operator.phases.first.attributesKeyFrames!.first.data;

    emit(OperatorStatusState(
      potential: 0,
      elite: 0,
      level: 1,
      maxLevel: _operator.phases.first.maxLevel ?? 1,
      favor: 0,
      rangeId: _operator.phases.first.rangeId,
      maxHp: initStats.maxHp.mValue!.toDouble() +
          (_potentialDiff['0'] ?? 0) +
          (_favorDiff['maxHp'] ?? 0),
      atk: initStats.atk.mValue!.toDouble() +
          (_potentialDiff['1'] ?? 0) +
          (_favorDiff['atk'] ?? 0),
      def: initStats.def.mValue!.toDouble() +
          (_potentialDiff['2'] ?? 0) +
          (_favorDiff['def'] ?? 0),
      magicResistance: initStats.magicResistance.mValue! +
          (_potentialDiff['3'] ?? 0) +
          (_favorDiff['magicResistance'] ?? 0),
      respawnTime: initStats.respawnTime.mValue!.toDouble() +
          (_potentialDiff['21'] ?? 0),
      cost: initStats.cost.mValue!.toDouble() + (_potentialDiff['4'] ?? 0),
      blockCnt: initStats.blockCnt.mValue!.toDouble(),
      atkSpeed: _atkSpeedCalculator(
        attackspeed: initStats.attackSpeed.mValue!,
        baseAttackTime: initStats.baseAttackTime.mValue!,
      ),
    ));
  }

  // Potential change event
  Future<void> _operatorStatusPotentialChangeEventHander(
    OperatorStatusPotentialChangeEvent event,
    Emitter<OperatorStatusState> emit,
  ) async {
    _updatePotentialDiff(potential: event.potential);

    AttributeModel firstStats =
        _operator.phases[state.elite].attributesKeyFrames!.first.data;
    AttributeModel lastStats =
        _operator.phases[state.elite].attributesKeyFrames!.last.data;
    int maxLevel = _operator.phases[state.elite].maxLevel ?? 1;

    emit(state.copyWith(
      potential: event.potential,
      maxHp: _statCalculator(
            first: firstStats.maxHp.mValue!.toDouble(),
            last: lastStats.maxHp.mValue!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['0'] ?? 0) +
          (_favorDiff['maxHp'] ?? 0),
      atk: _statCalculator(
            first: firstStats.atk.mValue!.toDouble(),
            last: lastStats.atk.mValue!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['1'] ?? 0) +
          (_favorDiff['atk'] ?? 0),
      def: _statCalculator(
            first: firstStats.def.mValue!.toDouble(),
            last: lastStats.def.mValue!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['2'] ?? 0) +
          (_favorDiff['def'] ?? 0),
      magicResistance: _statCalculator(
            first: firstStats.magicResistance.mValue!,
            last: lastStats.magicResistance.mValue!,
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['3'] ?? 0) +
          (_favorDiff['magicResistance'] ?? 0),
      respawnTime: _statCalculator(
            first: firstStats.respawnTime.mValue!.toDouble(),
            last: lastStats.respawnTime.mValue!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['21'] ?? 0),
      cost: _statCalculator(
            first: firstStats.cost.mValue!.toDouble(),
            last: lastStats.cost.mValue!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['4'] ?? 0),
      blockCnt: _statCalculator(
        first: firstStats.blockCnt.mValue!.toDouble(),
        last: lastStats.blockCnt.mValue!.toDouble(),
        level: state.level,
        maxLevel: maxLevel,
      ),
      atkSpeed: _atkSpeedCalculator(
        attackspeed: _statCalculator(
          first: firstStats.attackSpeed.mValue!,
          last: lastStats.attackSpeed.mValue!,
          level: state.level,
          maxLevel: maxLevel,
        ),
        baseAttackTime: _statCalculator(
          first: firstStats.baseAttackTime.mValue!,
          last: lastStats.baseAttackTime.mValue!,
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
    AttributeModel stats =
        _operator.phases[event.elite].attributesKeyFrames!.first.data;

    emit(state.copyWith(
      elite: event.elite,
      rangeId: _operator.phases[event.elite].rangeId,
      level: 1,
      maxLevel: _operator.phases[event.elite].maxLevel ?? 1,
      maxHp: stats.maxHp.mValue!.toDouble() +
          (_potentialDiff['0'] ?? 0) +
          (_favorDiff['maxHp'] ?? 0),
      atk: stats.atk.mValue!.toDouble() +
          (_potentialDiff['1'] ?? 0) +
          (_favorDiff['atk'] ?? 0),
      def: stats.def.mValue!.toDouble() +
          (_potentialDiff['2'] ?? 0) +
          (_favorDiff['def'] ?? 0),
      magicResistance: stats.magicResistance.mValue! +
          (_potentialDiff['3'] ?? 0) +
          (_favorDiff['magicResistance'] ?? 0),
      respawnTime:
          stats.respawnTime.mValue!.toDouble() + (_potentialDiff['21'] ?? 0),
      cost: stats.cost.mValue!.toDouble() + (_potentialDiff['4'] ?? 0),
      blockCnt: stats.blockCnt.mValue!.toDouble(),
      atkSpeed: _atkSpeedCalculator(
        attackspeed: stats.attackSpeed.mValue!,
        baseAttackTime: stats.baseAttackTime.mValue!,
      ),
    ));
  }

  // Level change event
  Future<void> _operatorStatusLevelChangeEventHandler(
    OperatorStatusLevelChangeEvent event,
    Emitter<OperatorStatusState> emit,
  ) async {
    AttributeModel firstStats =
        _operator.phases[state.elite].attributesKeyFrames!.first.data;
    AttributeModel lastStats =
        _operator.phases[state.elite].attributesKeyFrames!.last.data;
    int maxLevel = state.maxLevel;

    emit(state.copyWith(
      level: event.level,
      maxHp: _statCalculator(
            first: firstStats.maxHp.mValue!.toDouble(),
            last: lastStats.maxHp.mValue!.toDouble(),
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['0'] ?? 0) +
          (_favorDiff['maxHp'] ?? 0),
      atk: _statCalculator(
            first: firstStats.atk.mValue!.toDouble(),
            last: lastStats.atk.mValue!.toDouble(),
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['1'] ?? 0) +
          (_favorDiff['atk'] ?? 0),
      def: _statCalculator(
            first: firstStats.def.mValue!.toDouble(),
            last: lastStats.def.mValue!.toDouble(),
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['2'] ?? 0) +
          (_favorDiff['def'] ?? 0),
      magicResistance: _statCalculator(
            first: firstStats.magicResistance.mValue!,
            last: lastStats.magicResistance.mValue!,
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['3'] ?? 0) +
          (_favorDiff['magicResistance'] ?? 0),
      respawnTime: _statCalculator(
            first: firstStats.respawnTime.mValue!.toDouble(),
            last: lastStats.respawnTime.mValue!.toDouble(),
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['21'] ?? 0),
      cost: _statCalculator(
            first: firstStats.cost.mValue!.toDouble(),
            last: lastStats.cost.mValue!.toDouble(),
            level: event.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['4'] ?? 0),
      blockCnt: _statCalculator(
        first: firstStats.blockCnt.mValue!.toDouble(),
        last: lastStats.blockCnt.mValue!.toDouble(),
        level: event.level,
        maxLevel: maxLevel,
      ),
      atkSpeed: _atkSpeedCalculator(
        attackspeed: _statCalculator(
          first: firstStats.attackSpeed.mValue!,
          last: lastStats.attackSpeed.mValue!,
          level: event.level,
          maxLevel: maxLevel,
        ),
        baseAttackTime: _statCalculator(
          first: firstStats.baseAttackTime.mValue!,
          last: lastStats.baseAttackTime.mValue!,
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

    AttributeModel firstStats =
        _operator.phases[state.elite].attributesKeyFrames!.first.data;
    AttributeModel lastStats =
        _operator.phases[state.elite].attributesKeyFrames!.last.data;
    int maxLevel = state.maxLevel;

    emit(state.copyWith(
      favor: event.favor,
      maxHp: _statCalculator(
            first: firstStats.maxHp.mValue!.toDouble(),
            last: lastStats.maxHp.mValue!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['0'] ?? 0) +
          (_favorDiff['maxHp'] ?? 0),
      atk: _statCalculator(
            first: firstStats.atk.mValue!.toDouble(),
            last: lastStats.atk.mValue!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['1'] ?? 0) +
          (_favorDiff['atk'] ?? 0),
      def: _statCalculator(
            first: firstStats.def.mValue!.toDouble(),
            last: lastStats.def.mValue!.toDouble(),
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['2'] ?? 0) +
          (_favorDiff['def'] ?? 0),
      magicResistance: _statCalculator(
            first: firstStats.magicResistance.mValue!,
            last: lastStats.magicResistance.mValue!,
            level: state.level,
            maxLevel: maxLevel,
          ) +
          (_potentialDiff['3'] ?? 0) +
          (_favorDiff['magicResistance'] ?? 0),
    ));
  }

  // attributeType
  // 0 - 최대 HP
  // 1 - 공격력
  // 2 - 방어력
  // 3 - 마법 저항력
  // 4 - 배치 코스트
  // 7 - 공격 속도
  // 21 - 재배치 시간
  // 저지 가능 수는 없음
  void _updatePotentialDiff({required int potential}) {
    _potentialDiff = {};
    for (int i = 0; i < potential; i++) {
      var pot = _operator.potentialRanks[i].buff?.attributes;
      if (pot?.attributeModifiers?.isNotEmpty == false) continue;

      for (var modifier in pot!.attributeModifiers!) {
        if (_potentialDiff.containsKey(modifier.attributeType)) {
          _potentialDiff[modifier.attributeType] =
              _potentialDiff[modifier.attributeType]! + modifier.value;
        } else {
          _potentialDiff[modifier.attributeType] = modifier.value;
        }
      }
    }
  }

  void _updateFavorDiff({required int favor}) {
    _favorDiff = {};
    OperatorFavorKeyFramesModel first = _operator.favorKeyFrames.first;
    OperatorFavorKeyFramesModel last = _operator.favorKeyFrames.last;
    final double fav = favor > 100 ? 50 : favor / 2;

    double diff =
        (last.data.maxHp.mValue! - first.data.maxHp.mValue!) / last.level;
    _favorDiff['maxHp'] = first.data.maxHp.mValue! + diff * fav;
    diff = (last.data.atk.mValue! - first.data.atk.mValue!) / last.level;
    _favorDiff['atk'] = first.data.atk.mValue! + diff * fav;
    diff = (last.data.def.mValue! - first.data.def.mValue!) / last.level;
    _favorDiff['def'] = first.data.def.mValue! + diff * fav;
    diff = (last.data.magicResistance.mValue! -
            first.data.magicResistance.mValue!) /
        last.level;
    _favorDiff['magicResistance'] =
        first.data.magicResistance.mValue! + diff * fav;
  }

  double _atkSpeedCalculator({
    required double attackspeed,
    required double baseAttackTime,
  }) {
    return 1 /
        ((attackspeed + (_potentialDiff['7'] ?? 0)) / baseAttackTime / 100);
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
