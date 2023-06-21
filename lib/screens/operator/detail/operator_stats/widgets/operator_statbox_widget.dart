import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class OperatorStatBoxWidget extends StatelessWidget {
  const OperatorStatBoxWidget({
    super.key,
    required this.title,
    required this.stat,
    this.unit = "",
  });

  final String title, stat, unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.size60 * 2,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size1,
            spreadRadius: Sizes.size1,
            color: Colors.black.withOpacity(0.3),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: Sizes.size3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size2,
                horizontal: Sizes.size5,
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade600,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                  fontSize: Sizes.size10,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stat,
                  style: const TextStyle(
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                    fontSize: Sizes.size12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Sizes.size1),
                  child: Text(
                    unit,
                    style: const TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                      fontSize: Sizes.size9,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
