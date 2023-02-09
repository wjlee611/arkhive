import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class SkillDuration extends StatelessWidget {
  const SkillDuration({
    super.key,
    required this.duration,
  });

  final String duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var dur in duration.split('/'))
          if (dur == '시간')
            Icon(
              Icons.timelapse_rounded,
              color: Colors.grey.shade700,
              size: Sizes.size16 + Sizes.size2,
            )
          else if (dur == '탄창')
            Icon(
              Icons.stacked_bar_chart_rounded,
              color: Colors.grey.shade700,
              size: Sizes.size16 + Sizes.size2,
            )
          else
            Padding(
              padding: const EdgeInsets.only(left: Sizes.size5),
              child: Text(
                dur == '0' ? "즉시 발동" : dur,
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.nanumGothic,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
      ],
    );
  }
}
