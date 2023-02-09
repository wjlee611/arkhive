import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: Sizes.size14,
        right: Sizes.size10,
        top: Sizes.size5,
        bottom: Sizes.size5,
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade600,
        borderRadius: const BorderRadiusDirectional.horizontal(
          end: Radius.circular(Sizes.size10),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: Sizes.size16,
          fontFamily: FontFamily.nanumGothic,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
