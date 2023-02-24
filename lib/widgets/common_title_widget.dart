import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class CommonTitleWidget extends StatelessWidget {
  const CommonTitleWidget({
    super.key,
    required this.text,
    this.color = const Color(0xFF546E7A),
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            height: Sizes.size1,
            color: Colors.grey.shade300,
          ),
        ),
        Gaps.h10,
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadiusDirectional.circular(Sizes.size10),
            boxShadow: [
              BoxShadow(
                blurRadius: Sizes.size1,
                spreadRadius: Sizes.size1,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size3,
              horizontal: Sizes.size20,
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: FontFamily.nanumGothic,
                fontWeight: FontWeight.w700,
                fontSize: Sizes.size14,
                color: Colors.white,
                shadows: [
                  Shadow(blurRadius: Sizes.size1),
                ],
              ),
            ),
          ),
        ),
        Gaps.h10,
        Flexible(
          child: Container(
            height: Sizes.size1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
