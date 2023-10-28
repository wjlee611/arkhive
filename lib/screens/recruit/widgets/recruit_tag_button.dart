import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class RecruitTagButton extends StatelessWidget {
  final String title;
  final bool onSelected;
  final Function() onTap;

  const RecruitTagButton({
    super.key,
    required this.title,
    required this.onSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(Sizes.size5),
        decoration: BoxDecoration(
          color: onSelected
              ? Colors.yellow.shade800
              : Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
            color: Colors.yellow.shade800,
          ),
          borderRadius: BorderRadius.circular(Sizes.size3),
        ),
        child: AppFont(
          title,
          fontWeight: FontWeight.w700,
          fontSize: Sizes.size16,
        ),
      ),
    );
  }
}
