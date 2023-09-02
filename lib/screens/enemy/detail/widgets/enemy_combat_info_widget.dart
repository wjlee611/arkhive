import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_state.dart';
import 'package:arkhive/constants/app_data.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy/enemy_data_model.dart';
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
  final List<EnemyDataValueModel> enemyDataValues;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnemyLevelBloc, EnemyLevelState>(
      buildWhen: (previous, current) => previous.level != current.level,
      builder: (context, state) {
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
              value: enemyDataValues[state.level]
                      .enemyData
                      ?.attributes
                      ?.massLevel
                      ?.mValue
                      .toString() ??
                  AppData.nullStr,
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
                      stat: enemyDataValues[state.level]
                              .enemyData
                              ?.attributes
                              ?.maxHp
                              ?.mValue
                              .toString() ??
                          AppData.nullStr,
                      statRank: enemy.endure!,
                    ),
                    Gaps.h5,
                    StatContainer(
                      title: '공격력',
                      stat: enemyDataValues[state.level]
                              .enemyData
                              ?.attributes
                              ?.atk
                              ?.mValue
                              .toString() ??
                          AppData.nullStr,
                      statRank: enemy.attack!,
                    ),
                    Gaps.h5,
                    StatContainer(
                      title: '방어력',
                      stat: enemyDataValues[state.level]
                              .enemyData
                              ?.attributes
                              ?.def
                              ?.mValue
                              .toString() ??
                          AppData.nullStr,
                      statRank: enemy.defence!,
                    ),
                    Gaps.h5,
                    StatContainer(
                      title: '마법 저항력',
                      stat: enemyDataValues[state.level]
                              .enemyData
                              ?.attributes
                              ?.magicResistance
                              ?.mValue
                              .toString()
                              .replaceAll('.0', '') ??
                          AppData.nullStr,
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
                  isImm: enemyDataValues[state.level]
                          .enemyData
                          ?.attributes
                          ?.stunImmune
                          ?.mValue ??
                      false,
                ),
                CheckboxWidget(
                  title: '침묵 저항',
                  isImm: enemyDataValues[state.level]
                          .enemyData
                          ?.attributes
                          ?.silenceImmune
                          ?.mValue ??
                      false,
                ),
              ],
            ),
            Gaps.v7,
            Row(
              children: [
                CheckboxWidget(
                  title: '수면 저항',
                  isImm: enemyDataValues[state.level]
                          .enemyData
                          ?.attributes
                          ?.sleepImmune
                          ?.mValue ??
                      false,
                ),
                CheckboxWidget(
                  title: '빙결 저항',
                  isImm: enemyDataValues[state.level]
                          .enemyData
                          ?.attributes
                          ?.frozenImmune
                          ?.mValue ??
                      false,
                ),
              ],
            ),
            Gaps.v7,
            CheckboxWidget(
              title: '부양 저항',
              isImm: enemyDataValues[state.level]
                      .enemyData
                      ?.attributes
                      ?.levitateImmune
                      ?.mValue ??
                  false,
            ),
            Gaps.v20,
          ],
        );
      },
    );
  }
}
