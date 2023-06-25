import 'package:arkhive/bloc/operator/operator_status/operator_status_bloc.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/operator/detail/operator_stats/widgets/operator_statbox_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorStatsContainer extends StatelessWidget {
  const OperatorStatsContainer({super.key});

  String _statFormatter(double stat) {
    return stat.round().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CommonTitleWidget(text: '스탯'),
        Gaps.v6,
        BlocBuilder<OperatorStatusBloc, OperatorStatusState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) => _bulidBody(context, state),
        ),
      ],
    );
  }

  Widget _bulidBody(BuildContext context, OperatorStatusState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OperatorStatBoxWidget(
              title: '최대 체력',
              stat: _statFormatter(state.maxHp),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '재배치 시간',
              stat: _statFormatter(state.respawnTime)
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
              stat: _statFormatter(state.atk),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '배치 코스트',
              stat: _statFormatter(state.cost).toString().replaceAll('.0', ''),
            ),
          ],
        ),
        Gaps.v5,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OperatorStatBoxWidget(
              title: '방어',
              stat: _statFormatter(state.def),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '저지 가능 수',
              stat: _statFormatter(state.blockCnt)
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
              title: '마법 저항',
              stat: _statFormatter(state.magicResistance),
            ),
            Gaps.h5,
            OperatorStatBoxWidget(
              title: '공격 속도',
              stat: state.atkSpeed.toStringAsFixed(2),
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
        // Gaps.v10,
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     if (widget.favor != 0)
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const CommonSubTitleWidget(text: '신뢰도 증가량'),
        //           Gaps.v3,
        //           if (_favHp != 0)
        //             Text(
        //               '체력: ${_favHp.round()}',
        //               style: const TextStyle(
        //                 fontFamily: FontFamily.nanumGothic,
        //                 fontSize: Sizes.size12,
        //                 color: Colors.black87,
        //               ),
        //             ),
        //           if (_favAtk != 0)
        //             Text(
        //               '공격: ${_favAtk.round()}',
        //               style: const TextStyle(
        //                 fontFamily: FontFamily.nanumGothic,
        //                 fontSize: Sizes.size12,
        //                 color: Colors.black87,
        //               ),
        //             ),
        //           if (_favDef != 0)
        //             Text(
        //               '방어: ${_favDef.round()}',
        //               style: const TextStyle(
        //                 fontFamily: FontFamily.nanumGothic,
        //                 fontSize: Sizes.size12,
        //                 color: Colors.black87,
        //               ),
        //             ),
        //           if (_favRes != 0)
        //             Text(
        //               '마법 저항: ${_favRes.round()}',
        //               style: const TextStyle(
        //                 fontFamily: FontFamily.nanumGothic,
        //                 fontSize: Sizes.size12,
        //                 color: Colors.black87,
        //               ),
        //             ),
        //         ],
        //       ),
        //     Gaps.h10,
        //     if (widget.pot != 0)
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const CommonSubTitleWidget(text: '잠재능력 증가량'),
        //           Gaps.v3,
        //           for (int i = 0; i < widget.pot; i++)
        //             Text(
        //               widget.potRanks[i].description!,
        //               style: const TextStyle(
        //                 fontFamily: FontFamily.nanumGothic,
        //                 fontSize: Sizes.size12,
        //                 color: Colors.black87,
        //               ),
        //             ),
        //         ],
        //       ),
        //   ],
        // ),
        Gaps.v32,
      ],
    );
  }
}
