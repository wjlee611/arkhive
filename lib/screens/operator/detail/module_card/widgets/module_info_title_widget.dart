import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class ModuleInfoTitle extends StatelessWidget {
  const ModuleInfoTitle({
    super.key,
    required this.code,
    required this.title,
  });

  final String code, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size5,
        vertical: Sizes.size2,
      ),
      decoration: BoxDecoration(
        color: code == "X" ? Colors.purple : Colors.blue.shade800,
        borderRadius: BorderRadius.circular(Sizes.size5),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: Sizes.size14,
          fontFamily: FontFamily.nanumGothic,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
