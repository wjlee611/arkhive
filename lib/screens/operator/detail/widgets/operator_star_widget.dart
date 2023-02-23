import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OperatorStarWidget extends StatelessWidget {
  const OperatorStarWidget({
    super.key,
    required this.rarity,
  });

  final int rarity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < rarity + 1; i++)
          SizedBox(
            width: Sizes.size16 + Sizes.size2,
            child: Transform.rotate(
              angle: 17 * math.pi / 180,
              child: Icon(
                Icons.star,
                color: Colors.yellow.shade700,
                size: Sizes.size24 + Sizes.size2,
                shadows: const [
                  Shadow(blurRadius: Sizes.size5),
                ],
              ),
            ),
          ),
        Gaps.h5,
      ],
    );
  }
}
