import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_slider_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';

class OperatorStatWidget extends StatefulWidget {
  const OperatorStatWidget({
    super.key,
    required this.phase,
    required this.level,
    required this.favor,
  });

  final OperatorLevelPhaseModel phase;
  final int level;
  final List<OperatorLevelPhaseAttrKeyFrameModel> favor;

  @override
  State<OperatorStatWidget> createState() => _OperatorStatWidgetState();
}

class _OperatorStatWidgetState extends State<OperatorStatWidget> {
  int _favor = 0;

  void _onFavorChange(int favor) {
    setState(() {
      _favor = favor;
    });
  }

  double _statCalculator({
    required double first,
    required double last,
  }) {
    final double diff = (last - first) / (widget.phase.maxLevel! - 1);
    return first + diff * (widget.level - 1);
  }

  double _favCalclator({
    required double first,
    required double last,
  }) {
    final double diff = (last - first) / (widget.favor.last.level - 1);
    final favor = _favor > 100 ? 50 : _favor / 2;
    return first + diff * (favor - 1);
  }

  String _statFormatter(double stat) {
    return stat.round().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
  }

  @override
  Widget build(BuildContext context) {
    var fData = widget.phase.attributesKeyFrames.first.data;
    var lData = widget.phase.attributesKeyFrames.last.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonTitleWidget(text: '스탯'),
        Transform.translate(
          offset: const Offset(Sizes.size16, 0),
          child: SizedBox(
            width: Sizes.size52 * 4,
            child: OperatorSlider(
              minValue: 0,
              maxValue: 200,
              currValue: _favor,
              onChange: _onFavorChange,
              tag: '신뢰도',
            ),
          ),
        ),
        Row(
          children: [
            OperatorStatBoxWidget(
              title: '최대 체력',
              stat: _statFormatter(
                _statCalculator(
                      first: fData.maxHp,
                      last: lData.maxHp,
                    ) +
                    _favCalclator(
                      first: widget.favor.first.data.maxHp,
                      last: widget.favor.last.data.maxHp,
                    ),
              ),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '재배치 시간',
              stat: '${fData.respawnTime.toString().replaceAll('.0', '')}초',
            ),
          ],
        ),
        Gaps.v5,
        Row(
          children: [
            OperatorStatBoxWidget(
              title: '공격',
              stat: _statFormatter(
                _statCalculator(
                      first: fData.atk,
                      last: lData.atk,
                    ) +
                    _favCalclator(
                      first: widget.favor.first.data.atk,
                      last: widget.favor.last.data.atk,
                    ),
              ),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '배치 코스트',
              stat: fData.cost.toString().replaceAll('.0', ''),
            ),
          ],
        ),
        Gaps.v5,
        Row(
          children: [
            OperatorStatBoxWidget(
              title: '방어',
              stat: _statFormatter(
                _statCalculator(
                      first: fData.def,
                      last: lData.def,
                    ) +
                    _favCalclator(
                      first: widget.favor.first.data.def,
                      last: widget.favor.last.data.def,
                    ),
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
          children: [
            OperatorStatBoxWidget(
              title: '마법 저항',
              stat: _statFormatter(
                _statCalculator(
                      first: fData.magicResistance,
                      last: lData.magicResistance,
                    ) +
                    _favCalclator(
                      first: widget.favor.first.data.magicResistance,
                      last: widget.favor.last.data.magicResistance,
                    ),
              ),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '공격 속도',
              stat: '${fData.attackSpeed.toString().replaceAll('.0', '')}/초',
            ),
          ],
        ),
      ],
    );
  }
}

class OperatorStatBoxWidget extends StatelessWidget {
  const OperatorStatBoxWidget({
    super.key,
    required this.title,
    required this.stat,
  });

  final String title, stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.size52 * 2,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: Sizes.size1,
              spreadRadius: Sizes.size1,
              color: Colors.black.withOpacity(0.3))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size2,
              horizontal: Sizes.size5,
            ),
            decoration: BoxDecoration(
              color: Colors.yellow.shade800,
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
          Text(
            stat,
            style: const TextStyle(
              fontFamily: FontFamily.nanumGothic,
              fontWeight: FontWeight.w700,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
    );
  }
}
