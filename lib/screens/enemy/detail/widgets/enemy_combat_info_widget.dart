import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/screens/enemy/detail/widgets/checkbox_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/infotag_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/stat_container_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';

class EnemyCombatInfo extends StatefulWidget {
  const EnemyCombatInfo({
    super.key,
    required this.enemy,
    required this.enemyDatas,
    required this.level,
  });

  final EnemyModel enemy;
  final List<EnemyValueDataModel> enemyDatas;
  final int level;

  @override
  State<EnemyCombatInfo> createState() => _EnemyCombatInfoState();
}

class _EnemyCombatInfoState extends State<EnemyCombatInfo> {
  late EnemyAttrDataModel attribute;

  @override
  void initState() {
    super.initState();
    _attrSelector();
  }

  @override
  void didUpdateWidget(covariant EnemyCombatInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.level != widget.level) _attrSelector();
  }

  void _attrSelector() {
    EnemyAttrDataModel result = widget.enemyDatas[0].attributes!;

    for (int i = 1; i < widget.level + 1; i++) {
      if (widget.enemyDatas[i].attributes?.maxHp?.isDefined ?? false) {
        result.copyWith(maxHp: widget.enemyDatas[i].attributes!.maxHp!);
      }
      if (widget.enemyDatas[i].attributes?.atk?.isDefined ?? false) {
        result.copyWith(atk: widget.enemyDatas[i].attributes!.atk!);
      }
      if (widget.enemyDatas[i].attributes?.def?.isDefined ?? false) {
        result.copyWith(def: widget.enemyDatas[i].attributes!.def!);
      }
      if (widget.enemyDatas[i].attributes?.massLevel?.isDefined ?? false) {
        result.copyWith(massLevel: widget.enemyDatas[i].attributes!.massLevel!);
      }
      if (widget.enemyDatas[i].attributes?.magicResistance?.isDefined ??
          false) {
        result.copyWith(
            magicResistance: widget.enemyDatas[i].attributes!.magicResistance!);
      }
      if (widget.enemyDatas[i].attributes?.moveSpeed?.isDefined ?? false) {
        result.copyWith(moveSpeed: widget.enemyDatas[i].attributes!.moveSpeed!);
      }
      if (widget.enemyDatas[i].attributes?.attackSpeed?.isDefined ?? false) {
        result.copyWith(
            attackSpeed: widget.enemyDatas[i].attributes!.attackSpeed!);
      }
      if (widget.enemyDatas[i].attributes?.baseAttackTime?.isDefined ?? false) {
        result.copyWith(
            baseAttackTime: widget.enemyDatas[i].attributes!.baseAttackTime!);
      }
      if (widget.enemyDatas[i].attributes?.stunImmune?.isDefined ?? false) {
        result.copyWith(
            stunImmune: widget.enemyDatas[i].attributes!.stunImmune!);
      }
      if (widget.enemyDatas[i].attributes?.silenceImmune?.isDefined ?? false) {
        result.copyWith(
            silenceImmune: widget.enemyDatas[i].attributes!.silenceImmune!);
      }
      if (widget.enemyDatas[i].attributes?.sleepImmune?.isDefined ?? false) {
        result.copyWith(
            sleepImmune: widget.enemyDatas[i].attributes!.sleepImmune!);
      }
      if (widget.enemyDatas[i].attributes?.frozenImmune?.isDefined ?? false) {
        result.copyWith(
            frozenImmune: widget.enemyDatas[i].attributes!.frozenImmune!);
      }
      if (widget.enemyDatas[i].attributes?.levitateImmune?.isDefined ?? false) {
        result.copyWith(
            levitateImmune: widget.enemyDatas[i].attributes!.levitateImmune!);
      }
    }

    attribute = result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonTitleWidget(text: '전투 능력'),
        Gaps.v5,
        InfoTag(
          title: '공격 방식',
          value: widget.enemy.attackType!,
        ),
        Gaps.v7,
        InfoTag(
          title: '무게 레벨',
          value: attribute.massLevel!.value.toString(),
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
                  stat: attribute.maxHp!.value.toString(),
                  statRank: widget.enemy.endure!,
                ),
                Gaps.h5,
                StatContainer(
                  title: '공격력',
                  stat: attribute.atk!.value.toString(),
                  statRank: widget.enemy.attack!,
                ),
                Gaps.h5,
                StatContainer(
                  title: '방어력',
                  stat: attribute.def!.value.toString(),
                  statRank: widget.enemy.defence!,
                ),
                Gaps.h5,
                StatContainer(
                  title: '마법 저항력',
                  stat: attribute.magicResistance!.value
                      .toString()
                      .replaceAll('.0', ''),
                  statRank: widget.enemy.resistance!,
                ),
              ],
            ),
          ),
        ),
        Gaps.v5,
        Row(
          children: [
            CheckboxWidget(
              title: '스턴 저항',
              isImm: attribute.stunImmune!.value!,
            ),
            CheckboxWidget(
              title: '침묵 저항',
              isImm: attribute.silenceImmune!.value!,
            ),
          ],
        ),
        Gaps.v7,
        Row(
          children: [
            CheckboxWidget(
              title: '수면 저항',
              isImm: attribute.sleepImmune!.value!,
            ),
            CheckboxWidget(
              title: '빙결 저항',
              isImm: attribute.frozenImmune!.value!,
            ),
          ],
        ),
        Gaps.v7,
        CheckboxWidget(
          title: '부양 저항',
          isImm: attribute.levitateImmune!.value!,
        ),
      ],
    );
  }
}
