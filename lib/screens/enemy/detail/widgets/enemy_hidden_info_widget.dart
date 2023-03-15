import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';

class EnemyHiddenInfoWidget extends StatefulWidget {
  const EnemyHiddenInfoWidget({
    super.key,
    required this.enemyDatas,
    required this.level,
  });

  final List<EnemyValueDataModel> enemyDatas;
  final int level;

  @override
  State<EnemyHiddenInfoWidget> createState() => _EnemyHiddenInfoWidgetState();
}

class _EnemyHiddenInfoWidgetState extends State<EnemyHiddenInfoWidget> {
  late Map<String, double> _blackboard;

  @override
  void initState() {
    super.initState();
    _blackboardSelector();
  }

  @override
  void didUpdateWidget(covariant EnemyHiddenInfoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.level != widget.level) _blackboardSelector();
  }

  void _blackboardSelector() {
    Map<String, double> result = boardListAndDurationToMap(
        blackboards: widget.enemyDatas[0].talentBlackboard);

    for (int i = 1; i < widget.level + 1; i++) {
      var tmp = boardListAndDurationToMap(
          blackboards: widget.enemyDatas[i].talentBlackboard);
      for (var key in tmp.keys) {
        result[key] = tmp[key]!;
      }
    }

    _blackboard = result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.v16,
        const CommonTitleWidget(text: '비공개 정보'),
        Gaps.v5,
        Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.size2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var key in _blackboard.keys)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CommonSubTitleWidget(text: key),
                            Gaps.h10,
                            Text(
                              _blackboard[key].toString(),
                              style: const TextStyle(
                                fontFamily: FontFamily.nanumGothic,
                                fontWeight: FontWeight.w700,
                                fontSize: Sizes.size12,
                                color: Colors.blue,
                              ),
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
        ),
      ],
    );
  }
}
