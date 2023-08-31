import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy/enemy_model.dart';
import 'package:arkhive/screens/enemy/detail/widgets/checkbox_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/infotag_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/stat_container_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyCombatInfo extends StatelessWidget {
  const EnemyCombatInfo({
    super.key,
    required this.enemy,
    required this.enemyDataValues,
  });

  final EnemyModel enemy;
  final List<EnemyValueDataModel> enemyDataValues;

  EnemyAttrDataModel _attrSelector(int level) {
    var result = EnemyAttrDataModel.copy(enemyDataValues[0].attributes!);

    for (int i = 1; i < level + 1; i++) {
      if (enemyDataValues[i].attributes?.maxHp?.isDefined ?? false) {
        result.copyWith(maxHp: enemyDataValues[i].attributes!.maxHp!);
      }
      if (enemyDataValues[i].attributes?.atk?.isDefined ?? false) {
        result.copyWith(atk: enemyDataValues[i].attributes!.atk!);
      }
      if (enemyDataValues[i].attributes?.def?.isDefined ?? false) {
        result.copyWith(def: enemyDataValues[i].attributes!.def!);
      }
      if (enemyDataValues[i].attributes?.massLevel?.isDefined ?? false) {
        result.copyWith(massLevel: enemyDataValues[i].attributes!.massLevel!);
      }
      if (enemyDataValues[i].attributes?.magicResistance?.isDefined ?? false) {
        result.copyWith(
            magicResistance: enemyDataValues[i].attributes!.magicResistance!);
      }
      if (enemyDataValues[i].attributes?.moveSpeed?.isDefined ?? false) {
        result.copyWith(moveSpeed: enemyDataValues[i].attributes!.moveSpeed!);
      }
      if (enemyDataValues[i].attributes?.attackSpeed?.isDefined ?? false) {
        result.copyWith(
            attackSpeed: enemyDataValues[i].attributes!.attackSpeed!);
      }
      if (enemyDataValues[i].attributes?.baseAttackTime?.isDefined ?? false) {
        result.copyWith(
            baseAttackTime: enemyDataValues[i].attributes!.baseAttackTime!);
      }
      if (enemyDataValues[i].attributes?.stunImmune?.isDefined ?? false) {
        result.copyWith(stunImmune: enemyDataValues[i].attributes!.stunImmune!);
      }
      if (enemyDataValues[i].attributes?.silenceImmune?.isDefined ?? false) {
        result.copyWith(
            silenceImmune: enemyDataValues[i].attributes!.silenceImmune!);
      }
      if (enemyDataValues[i].attributes?.sleepImmune?.isDefined ?? false) {
        result.copyWith(
            sleepImmune: enemyDataValues[i].attributes!.sleepImmune!);
      }
      if (enemyDataValues[i].attributes?.frozenImmune?.isDefined ?? false) {
        result.copyWith(
            frozenImmune: enemyDataValues[i].attributes!.frozenImmune!);
      }
      if (enemyDataValues[i].attributes?.levitateImmune?.isDefined ?? false) {
        result.copyWith(
            levitateImmune: enemyDataValues[i].attributes!.levitateImmune!);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnemyLevelBloc, EnemyLevelState>(
      buildWhen: (previous, current) => previous.level != current.level,
      builder: (context, state) {
        var attribute = _attrSelector(state.level);

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
                      statRank: enemy.endure!,
                    ),
                    Gaps.h5,
                    StatContainer(
                      title: '공격력',
                      stat: attribute.atk!.value.toString(),
                      statRank: enemy.attack!,
                    ),
                    Gaps.h5,
                    StatContainer(
                      title: '방어력',
                      stat: attribute.def!.value.toString(),
                      statRank: enemy.defence!,
                    ),
                    Gaps.h5,
                    StatContainer(
                      title: '마법 저항력',
                      stat: attribute.magicResistance!.value
                          .toString()
                          .replaceAll('.0', ''),
                      statRank: enemy.resistance!,
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
            Gaps.v20,
          ],
        );
      },
    );
  }
}
