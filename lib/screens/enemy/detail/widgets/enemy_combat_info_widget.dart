import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_state.dart';
import 'package:arkhive/constants/app_data.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/setting_cubit.dart';
import 'package:arkhive/models/common/attribute_model.dart';
import 'package:arkhive/models/enemy/enemy_data_model.dart';
import 'package:arkhive/models/enemy/enemy_model.dart';
import 'package:arkhive/screens/enemy/detail/widgets/checkbox_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/infotag_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/stat_container_widget.dart';
import 'package:arkhive/tools/gamedata_root.dart';
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

  AttributeModel _attrSelector(int level) {
    var result = enemyDataValues[0].enemyData!.attributes!;

    for (int i = 1; i < level + 1; i++) {
      var attr = enemyDataValues[i].enemyData?.attributes;

      if (attr?.maxHp!.mDefined ?? false) {
        result = result.copyWith(maxHp: attr?.maxHp);
      }
      if (attr?.atk!.mDefined ?? false) {
        result = result.copyWith(atk: attr?.atk);
      }
      if (attr?.def!.mDefined ?? false) {
        result = result.copyWith(def: attr?.def);
      }
      if (attr?.magicResistance!.mDefined ?? false) {
        result = result.copyWith(magicResistance: attr?.magicResistance);
      }
      if (attr?.moveSpeed!.mDefined ?? false) {
        result = result.copyWith(moveSpeed: attr?.moveSpeed);
      }
      if (attr?.attackSpeed!.mDefined ?? false) {
        result = result.copyWith(attackSpeed: attr?.attackSpeed);
      }
      if (attr?.baseAttackTime!.mDefined ?? false) {
        result = result.copyWith(baseAttackTime: attr?.baseAttackTime);
      }
      if (attr?.massLevel!.mDefined ?? false) {
        result = result.copyWith(massLevel: attr?.massLevel);
      }
      if (attr?.stunImmune!.mDefined ?? false) {
        result = result.copyWith(stunImmune: attr?.stunImmune);
      }
      if (attr?.silenceImmune!.mDefined ?? false) {
        result = result.copyWith(silenceImmune: attr?.silenceImmune);
      }
      if (attr?.sleepImmune!.mDefined ?? false) {
        result = result.copyWith(sleepImmune: attr?.sleepImmune);
      }
      if (attr?.frozenImmune!.mDefined ?? false) {
        result = result.copyWith(frozenImmune: attr?.frozenImmune);
      }
      if (attr?.levitateImmune!.mDefined ?? false) {
        result = result.copyWith(levitateImmune: attr?.levitateImmune);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnemyLevelBloc, EnemyLevelState>(
      buildWhen: (previous, current) => previous.level != current.level,
      builder: (context, state) {
        var attr = _attrSelector(state.level);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonTitleWidget(text: '전투 능력'),
            Gaps.v5,
            if (enemy.attackType != null)
              InfoTag(
                title: '공격 방식',
                value: enemy.attackType!,
              ),
            if (context.read<SettingCubit>().state.settings.dbRegion ==
                Region.cn)
              InfoTag(
                title: '공격 방식',
                value: AppData.nullStr,
                values: enemy.damageType,
                applyWay: enemyDataValues.first.enemyData?.applyWay?.mValue,
              ),
            Gaps.v7,
            InfoTag(
              title: '무게 레벨',
              value: attr.massLevel!.mValue.toString(),
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
                      stat: attr.maxHp!.mValue!.toDouble(),
                      statRank: enemy.endure ?? 'asd',
                    ),
                    Gaps.h5,
                    StatContainer(
                      title: '공격력',
                      stat: attr.atk!.mValue!.toDouble(),
                      statRank: enemy.attack ?? 'asd',
                    ),
                    Gaps.h5,
                    StatContainer(
                      title: '방어력',
                      stat: attr.def!.mValue!.toDouble(),
                      statRank: enemy.defence ?? 'asd',
                    ),
                    Gaps.h5,
                    StatContainer(
                      title: '마법 저항력',
                      stat: attr.magicResistance!.mValue!,
                      statRank: enemy.resistance ?? 'asd',
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
                  isImm: attr.stunImmune!.mValue ?? false,
                ),
                CheckboxWidget(
                  title: '침묵 저항',
                  isImm: attr.silenceImmune!.mValue ?? false,
                ),
              ],
            ),
            Gaps.v7,
            Row(
              children: [
                CheckboxWidget(
                  title: '수면 저항',
                  isImm: attr.sleepImmune!.mValue ?? false,
                ),
                CheckboxWidget(
                  title: '빙결 저항',
                  isImm: attr.frozenImmune!.mValue ?? false,
                ),
              ],
            ),
            Gaps.v7,
            CheckboxWidget(
              title: '부양 저항',
              isImm: attr.levitateImmune!.mValue ?? false,
            ),
            Gaps.v20,
          ],
        );
      },
    );
  }
}
