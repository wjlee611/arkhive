import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class SanityInfoTag extends StatelessWidget {
  const SanityInfoTag({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size2,
            spreadRadius: Sizes.size1 / 10,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Sizes.size24,
            width: Sizes.size72,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.blueGrey.shade800,
                  fontSize: Sizes.size10,
                  fontFamily: FontFamily.nanumGothic,
                ),
              ),
            ),
          ),
          Container(
            height: Sizes.size24,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size5),
            color: Colors.yellow.shade800,
            child: Center(
              child: Text(
                value == -1 ? 'N/A' : value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size14,
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
