import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class CommonTitleWidget extends StatelessWidget {
  const CommonTitleWidget({
    super.key,
    required this.text,
    this.color = const Color(0xFFF9A825),
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size1,
            spreadRadius: Sizes.size1,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: color,
            width: Sizes.size5,
            height: Sizes.size20,
          ),
          Gaps.h5,
          Text(
            text,
            style: const TextStyle(
              fontFamily: FontFamily.nanumGothic,
              fontWeight: FontWeight.w700,
              fontSize: Sizes.size14,
            ),
          ),
          Gaps.h5,
        ],
      ),
    );
  }
}
