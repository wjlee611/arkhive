import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';

class EnemyHiddenInfoWidget extends StatelessWidget {
  const EnemyHiddenInfoWidget({
    super.key,
    required this.blackboard,
  });

  final List<BlackboardModel> blackboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.v16,
        const CommonTitleWidget(text: '비공개 정보'),
        Gaps.v7,
        Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var attr in blackboard)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CommonSubTitleWidget(text: attr.key!),
                          Gaps.h10,
                          Text(
                            attr.value!.toString(),
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
      ],
    );
  }
}
