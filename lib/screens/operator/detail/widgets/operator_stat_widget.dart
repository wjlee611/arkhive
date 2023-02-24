import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';

class OperatorStatWidget extends StatefulWidget {
  const OperatorStatWidget({
    super.key,
    required this.phase,
    required this.pot,
    required this.level,
    required this.favor,
    required this.favorPhase,
    required this.potRanks,
  });

  final OperatorLevelPhaseModel phase;
  final int pot, level, favor;
  final List<OperatorLevelPhaseAttrKeyFrameModel> favorPhase;
  final List<OperatorPotentialRanksModel> potRanks;

  @override
  State<OperatorStatWidget> createState() => _OperatorStatWidgetState();
}

class _OperatorStatWidgetState extends State<OperatorStatWidget> {
  late OperatorStatsDataModel fData;
  late OperatorStatsDataModel lData;
  Map<String, double> _potStats = {};

  late double _favHp, _favAtk, _favDef, _favRes;

  @override
  void initState() {
    super.initState();
    fData = widget.phase.attributesKeyFrames.first.data;
    lData = widget.phase.attributesKeyFrames.last.data;
    _favHp = _favCalculator(
      first: widget.favorPhase.first.data.maxHp,
      last: widget.favorPhase.last.data.maxHp,
    );
    _favAtk = _favCalculator(
      first: widget.favorPhase.first.data.atk,
      last: widget.favorPhase.last.data.atk,
    );
    _favDef = _favCalculator(
      first: widget.favorPhase.first.data.def,
      last: widget.favorPhase.last.data.def,
    );
    _favRes = _favCalculator(
      first: widget.favorPhase.first.data.magicResistance,
      last: widget.favorPhase.last.data.magicResistance,
    );
  }

  @override
  void didUpdateWidget(covariant OperatorStatWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pot != widget.pot) {
      _potStatUpdate();
    }
    if (oldWidget.phase != widget.phase) {
      fData = widget.phase.attributesKeyFrames.first.data;
      lData = widget.phase.attributesKeyFrames.last.data;
    }
    if (oldWidget.favor != widget.favor) {
      _favHp = _favCalculator(
        first: widget.favorPhase.first.data.maxHp,
        last: widget.favorPhase.last.data.maxHp,
      );
      _favAtk = _favCalculator(
        first: widget.favorPhase.first.data.atk,
        last: widget.favorPhase.last.data.atk,
      );
      _favDef = _favCalculator(
        first: widget.favorPhase.first.data.def,
        last: widget.favorPhase.last.data.def,
      );
      _favRes = _favCalculator(
        first: widget.favorPhase.first.data.magicResistance,
        last: widget.favorPhase.last.data.magicResistance,
      );
    }
  }

  double _statCalculator({
    required double first,
    required double last,
  }) {
    final double diff = (last - first) / (widget.phase.maxLevel! - 1);
    return first + diff * (widget.level - 1);
  }

  double _favCalculator({
    required double first,
    required double last,
  }) {
    final double diff = (last - first) / widget.favorPhase.last.level;
    final favor = widget.favor > 100 ? 50 : widget.favor / 2;
    return first + diff * favor;
  }

  double _stkSpdCalculator() {
    var atkSpd = fData.attackSpeed;
    var baseAtkTime = fData.baseAttackTime;
    return 1 / ((atkSpd + (_potStats['7'] ?? 0)) / baseAtkTime / 100);
  }

  String _statFormatter(double stat) {
    return stat.round().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
  }

  void _potStatUpdate() {
    // attributeType
    // 0 - 최대 HP
    // 1 - 공격력
    // 2 - 방어력
    // 3 - 마법 저항력
    // 4 - 배치 코스트
    // 7 - 공격 속도
    // 21 - 재배치 시간
    _potStats = {};
    for (int i = 0; i < widget.pot; i++) {
      var pot = widget.potRanks[i];
      if (pot.attributeModifiers.isNotEmpty) {
        for (var mod in pot.attributeModifiers) {
          if (_potStats[mod.attributeType] == null) {
            _potStats[mod.attributeType] = mod.value;
          } else {
            _potStats[mod.attributeType] =
                _potStats[mod.attributeType]! + mod.value;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OperatorStatBoxWidget(
              title: '최대 체력',
              stat: _statFormatter(
                _statCalculator(
                      first: fData.maxHp,
                      last: lData.maxHp,
                    ) +
                    _favHp +
                    (_potStats['0'] ?? 0),
              ),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '재배치 시간',
              stat: (fData.respawnTime + (_potStats['21'] ?? 0))
                  .toString()
                  .replaceAll('.0', ''),
              unit: '초',
            ),
          ],
        ),
        Gaps.v5,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OperatorStatBoxWidget(
              title: '공격',
              stat: _statFormatter(
                _statCalculator(
                      first: fData.atk,
                      last: lData.atk,
                    ) +
                    _favAtk +
                    (_potStats['1'] ?? 0),
              ),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '배치 코스트',
              stat: (fData.cost + (_potStats['4'] ?? 0))
                  .toString()
                  .replaceAll('.0', ''),
            ),
          ],
        ),
        Gaps.v5,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OperatorStatBoxWidget(
              title: '방어',
              stat: _statFormatter(
                _statCalculator(
                      first: fData.def,
                      last: lData.def,
                    ) +
                    _favDef +
                    (_potStats['2'] ?? 0),
              ),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '저지 가능 수',
              stat: fData.blockCnt.toString().replaceAll('.0', ''),
            ),
          ],
        ),
        Gaps.v5,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OperatorStatBoxWidget(
              title: '마법 저항',
              stat: _statFormatter(
                _statCalculator(
                      first: fData.magicResistance,
                      last: lData.magicResistance,
                    ) +
                    _favRes +
                    (_potStats['3'] ?? 0),
              ),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '공격 속도',
              stat: _stkSpdCalculator().toStringAsFixed(2),
              unit: '초/회',
            ),
          ],
        ),
        Gaps.v10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '*정예화 단계, 레벨, 신뢰도, 잠재능력 증가량\n  상기 데이터가 반영된 스탯입니다.',
              style: TextStyle(
                fontFamily: FontFamily.nanumGothic,
                fontSize: Sizes.size10,
                color: Colors.grey,
              ),
            ),
            Gaps.v3,
            Text(
              '*공격 속도는 연산이 적용된 결과로 표시됩니다.',
              style: TextStyle(
                fontFamily: FontFamily.nanumGothic,
                fontSize: Sizes.size10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Gaps.v10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.favor != 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonSubTitleWidget(text: '신뢰도 증가량'),
                  Gaps.v3,
                  if (_favHp != 0)
                    Text(
                      '체력: ${_favHp.round()}',
                      style: const TextStyle(
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                        fontSize: Sizes.size12,
                      ),
                    ),
                  if (_favAtk != 0)
                    Text(
                      '공격: ${_favAtk.round()}',
                      style: const TextStyle(
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                        fontSize: Sizes.size12,
                      ),
                    ),
                  if (_favDef != 0)
                    Text(
                      '방어: ${_favDef.round()}',
                      style: const TextStyle(
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                        fontSize: Sizes.size12,
                      ),
                    ),
                  if (_favRes != 0)
                    Text(
                      '마법 저항: ${_favRes.round()}',
                      style: const TextStyle(
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                        fontSize: Sizes.size12,
                      ),
                    ),
                ],
              ),
            Gaps.h10,
            if (widget.pot != 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonSubTitleWidget(text: '잠재능력 증가량'),
                  Gaps.v3,
                  for (int i = 0; i < widget.pot; i++)
                    Text(
                      widget.potRanks[i].description!,
                      style: const TextStyle(
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                        fontSize: Sizes.size12,
                      ),
                    ),
                ],
              ),
          ],
        ),
        Gaps.v16,
      ],
    );
  }
}

class OperatorStatBoxWidget extends StatelessWidget {
  const OperatorStatBoxWidget({
    super.key,
    required this.title,
    required this.stat,
    this.unit = "",
  });

  final String title, stat, unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.size60 * 2,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size1,
            spreadRadius: Sizes.size1,
            color: Colors.black.withOpacity(0.3),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: Sizes.size3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size2,
                horizontal: Sizes.size5,
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade600,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                  fontSize: Sizes.size10,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stat,
                  style: const TextStyle(
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                    fontSize: Sizes.size12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Sizes.size1),
                  child: Text(
                    unit,
                    style: const TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                      fontSize: Sizes.size9,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
