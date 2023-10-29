import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/recruit/recruit_model.dart';
import 'package:arkhive/screens/recruit/widgets/recruit_operator_button.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'dart:math' as math;

class RecruitGroupContainer extends StatelessWidget {
  final RecruitModel group;

  const RecruitGroupContainer({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade700,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size10,
          ),
          child: Wrap(
            runSpacing: Sizes.size5,
            spacing: Sizes.size5,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: Sizes.size28,
                    child: Transform.rotate(
                      angle: 17 * math.pi / 180,
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow.shade700,
                        size: Sizes.size24 + Sizes.size2,
                        shadows: const [
                          Shadow(blurRadius: Sizes.size3),
                        ],
                      ),
                    ),
                  ),
                  AppFont(
                    ((group.maxTier.value + group.minTier.value == 2
                                ? 9
                                : group.maxTier.value + group.minTier.value) /
                            12 *
                            5)
                        .toStringAsFixed(1),
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w700,
                    color: Colors.yellow.shade700,
                  ),
                  Gaps.h5,
                ],
              ),
              for (var tag in group.tags)
                AppFont(
                  tag,
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => RecruitOperatorButton(
            operator_: group.operators[index],
            index: index,
          ),
          childCount: group.operators.length,
        ),
      ),
    );
  }
}
