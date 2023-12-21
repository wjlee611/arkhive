import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/enemy_class_level_cubit.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatContainer extends StatelessWidget {
  const StatContainer({
    super.key,
    required this.title,
    required this.stat,
    required this.statRank,
  });

  final String title, statRank;
  final double stat;

  String rankCalc(BuildContext context, double stat) {
    var classLevels =
        context.read<EnemyClassLevelCubit>().state.enemyClassLevels ?? [];

    switch (title) {
      case '체력':
        {
          var result = '?';
          for (var classLevel in classLevels.reversed) {
            if (classLevel.maxHP.min <= stat) {
              result = classLevel.classLevel;
            }
          }
          return result;
        }
      case '공격력':
        {
          var result = '?';
          for (var classLevel in classLevels.reversed) {
            if (classLevel.attack.min <= stat) {
              result = classLevel.classLevel;
            }
          }
          return result;
        }
      case '방어력':
        {
          var result = '?';
          for (var classLevel in classLevels.reversed) {
            if (classLevel.def.min <= stat) {
              result = classLevel.classLevel;
            }
          }
          return result;
        }
      case '마법 저항력':
        {
          var result = '?';
          for (var classLevel in classLevels.reversed) {
            if (classLevel.magicRes.min <= stat) {
              result = classLevel.classLevel;
            }
          }
          return result;
        }
    }

    return '?';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.size72,
      height: Sizes.size72,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size2,
            spreadRadius: Sizes.size1 / 10,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: Sizes.size20,
                  alignment: Alignment.center,
                  child: AppFont(
                    title,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: Sizes.size10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: Sizes.size4,
                right: Sizes.size4,
                bottom: Sizes.size4,
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Sizes.size3),
              ),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AppFont(
                      rankCalc(context, stat),
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.2),
                      fontSize: Sizes.size32,
                      fontWeight: FontWeight.w700,
                    ),
                    AppFont(
                      stat
                          .toString()
                          .replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => "${m[1]},",
                          )
                          .replaceAll('.0', ''),
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
