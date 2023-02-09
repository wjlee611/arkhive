import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class SkillType extends StatelessWidget {
  const SkillType({
    super.key,
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size3,
        vertical: Sizes.size1,
      ),
      margin: const EdgeInsets.only(
        left: Sizes.size5,
        top: Sizes.size5,
      ),
      decoration: BoxDecoration(
        color: type == '자연 회복'
            ? Colors.green
            : type == '공격 회복'
                ? Colors.deepOrange
                : type == "피격 회복"
                    ? Colors.amber
                    : Colors.grey.shade600,
        borderRadius: BorderRadius.circular(Sizes.size5),
      ),
      child: Text(
        type,
        style: const TextStyle(
          fontSize: Sizes.size14,
          fontWeight: FontWeight.w700,
          fontFamily: FontFamily.nanumGothic,
          color: Colors.white,
        ),
      ),
    );
  }
}
