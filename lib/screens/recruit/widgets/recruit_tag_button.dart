import 'package:arkhive/bloc/recruit/engine/recruit_engine_bloc.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitTagButton extends StatelessWidget {
  final String title;
  final bool onSelected;
  final Function() onTap;
  final bool isReset;

  const RecruitTagButton({
    super.key,
    required this.title,
    required this.onSelected,
    required this.onTap,
    this.isReset = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isConflict =
        context.read<RecruitEngineBloc>().state.conflict?.contains(title) ??
            false;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: isReset ? double.infinity : null,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(Sizes.size5),
        decoration: BoxDecoration(
          color: isReset
              ? Colors.redAccent
              : onSelected
                  ? Colors.yellow.shade800
                  : Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
            color: isReset
                ? Colors.redAccent
                : isConflict
                    ? Colors.redAccent
                    : Colors.yellow.shade800,
          ),
          borderRadius: BorderRadius.circular(Sizes.size3),
        ),
        child: AppFont(
          title,
          fontWeight: FontWeight.w700,
          fontSize: Sizes.size16,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
