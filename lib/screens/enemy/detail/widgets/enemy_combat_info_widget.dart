import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/screens/enemy/detail/widgets/checkbox_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/infotag_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/stat_container_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';

class EnemyCombatInfo extends StatelessWidget {
  const EnemyCombatInfo({
    super.key,
    required this.enemy,
    required this.attribute,
  });

  final EnemyModel enemy;
  final EnemyAttrValueDataModel attribute;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonTitleWidget(text: '전투 능력'),
        Gaps.v5,
        InfoTag(
          title: '공격 방식',
          value: enemy.attackType!,
        ),
        Gaps.v7,
        InfoTag(
          title: '무게 레벨',
          value: attribute.massLevel.toString(),
        ),
        Gaps.v5,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size2),
            child: Row(
              children: [
                Gaps.h3,
                StatContainer(
                  title: '체력',
                  stat: attribute.maxHp!.toString(),
                  statRank: enemy.endure!,
                ),
                Gaps.h5,
                StatContainer(
                  title: '공격력',
                  stat: attribute.atk!.toString(),
                  statRank: enemy.attack!,
                ),
                Gaps.h5,
                StatContainer(
                  title: '방어력',
                  stat: attribute.def!.toString(),
                  statRank: enemy.defence!,
                ),
                Gaps.h5,
                StatContainer(
                  title: '마법 저항력',
                  stat: attribute.magicResistance!
                      .toString()
                      .replaceAll('.0', ''),
                  statRank: enemy.resistance!,
                ),
              ],
            ),
          ),
        ),
        Gaps.v3,
        Row(
          children: [
            CheckboxWidget(
              title: '스턴 저항',
              isImm: attribute.stunImmune!,
            ),
            CheckboxWidget(
              title: '침묵 저항',
              isImm: attribute.silenceImmune!,
            ),
          ],
        ),
        Gaps.v5,
        Row(
          children: [
            CheckboxWidget(
              title: '수면 저항',
              isImm: attribute.sleepImmune!,
            ),
            CheckboxWidget(
              title: '빙결 저항',
              isImm: attribute.frozenImmune!,
            ),
          ],
        ),
        Gaps.v5,
        CheckboxWidget(
          title: '부양 저항',
          isImm: attribute.levitateImmune!,
        ),
      ],
    );
  }
}
