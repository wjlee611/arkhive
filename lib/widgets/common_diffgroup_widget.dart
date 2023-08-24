import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class CommonDiffGroupWidget extends StatelessWidget {
  final String? diffGroup;

  const CommonDiffGroupWidget({
    super.key,
    this.diffGroup,
  });

  @override
  Widget build(BuildContext context) {
    if (diffGroup != 'TOUGH' && diffGroup != 'NORMAL' && diffGroup != 'EASY') {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.only(left: Sizes.size5),
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size2,
        horizontal: Sizes.size5,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.black.withOpacity(0.3),
          )
        ],
        borderRadius: BorderRadius.circular(Sizes.size3),
        color: diffGroup == 'TOUGH'
            ? Colors.redAccent
            : diffGroup == 'NORMAL'
                ? Colors.blueAccent
                : Colors.blueGrey.shade700,
      ),
      child: AppFont(
        diffGroup == 'TOUGH'
            ? '고난'
            : diffGroup == 'NORMAL'
                ? '일반'
                : '스토리',
        color: Colors.white,
        fontSize: Sizes.size10,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
