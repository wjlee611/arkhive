import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class OperatorSlidingPanelTitleWidget extends StatelessWidget {
  final String title;

  const OperatorSlidingPanelTitleWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size1,
        horizontal: Sizes.size5,
      ),
      decoration: BoxDecoration(
        color: Colors.yellow.shade800,
        borderRadius: BorderRadius.circular(Sizes.size3),
      ),
      child: Center(
        child: AppFont(
          title,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.7),
              blurRadius: Sizes.size3,
            ),
          ],
        ),
      ),
    );
  }
}
