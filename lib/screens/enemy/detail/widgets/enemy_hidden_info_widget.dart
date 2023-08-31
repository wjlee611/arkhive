import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_level/enemy_level_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy/enemy_model.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyHiddenInfoWidget extends StatelessWidget {
  const EnemyHiddenInfoWidget({
    super.key,
    required this.enemyDataValues,
  });

  final List<EnemyValueDataModel> enemyDataValues;

  Map<String, double> _blackboardSelector(int level) {
    var result = boardListAndDurationToMap(
        blackboards: enemyDataValues[0].talentBlackboard ?? []);

    for (int i = 1; i < level + 1; i++) {
      var tmp = boardListAndDurationToMap(
          blackboards: enemyDataValues[i].talentBlackboard ?? []);
      for (var key in tmp.keys) {
        result[key] = tmp[key]!;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.v16,
        const CommonTitleWidget(text: '비공개 상세 정보'),
        Gaps.v5,
        BlocBuilder<EnemyLevelBloc, EnemyLevelState>(
          buildWhen: (previous, current) => previous.level != current.level,
          builder: (context, state) {
            var blackboard = _blackboardSelector(state.level);

            return Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.size2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var key in blackboard.keys)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CommonSubTitleWidget(
                                  text: key,
                                  color: Colors.blueGrey.shade700,
                                  isShadow: false,
                                ),
                                AppFont(
                                  ':',
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                  fontWeight: FontWeight.w700,
                                ),
                                Gaps.h5,
                                AppFont(
                                  blackboard[key].toString(),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Gaps.v3,
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
