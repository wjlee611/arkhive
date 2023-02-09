import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';
import 'package:square_percent_indicater/square_percent_indicater.dart';
import 'dart:math' as math;

class UpdateIndicator extends StatelessWidget {
  const UpdateIndicator({
    super.key,
    required this.current,
    required this.remain,
  });

  final int current;
  final int remain;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: 45 * math.pi / 180,
          child: SquarePercentIndicator(
            width: Sizes.size96,
            height: Sizes.size96,
            borderRadius: 0,
            startAngle: StartAngle.topLeft,
            shadowWidth: Sizes.size2,
            progressWidth: Sizes.size5,
            progressColor: Colors.yellow.shade700,
            shadowColor: Colors.grey,
            progress: remain == 0 ? 0 : current / remain,
          ),
        ),
        if (remain != 0)
          Column(
            children: [
              Text(
                "${((current / remain) * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                  color: Colors.yellow.shade700,
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                  fontSize: Sizes.size16,
                ),
              ),
              Text(
                "$current/$remain",
                style: TextStyle(
                  color: Colors.yellow.shade700,
                  fontFamily: FontFamily.nanumGothic,
                  fontSize: Sizes.size12,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
