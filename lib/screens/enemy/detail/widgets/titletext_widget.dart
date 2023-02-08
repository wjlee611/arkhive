import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size1,
        horizontal: Sizes.size3,
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade600,
      ),
      child: Text(
        '// $title',
        style: const TextStyle(
          color: Colors.white,
          fontSize: Sizes.size12,
          fontFamily: FontFamily.nanumGothic,
        ),
      ),
    );
  }
}
