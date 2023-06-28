import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/stage_list_model.dart';
import 'package:flutter/material.dart';

class StageListCardWidget extends StatelessWidget {
  const StageListCardWidget({
    super.key,
    required this.stage,
  });

  final StageListModel stage;

  void _onTap({
    required StageListModel stage,
    required BuildContext context,
  }) {
    // OpenDetailScreen.onStageTab(stage: stage, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(
        stage: stage,
        context: context,
      ),
      borderRadius: BorderRadius.circular(Sizes.size10),
      child: Container(
        padding: const EdgeInsets.all(Sizes.size16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size2,
                horizontal: Sizes.size5,
              ),
              decoration: BoxDecoration(
                color: stage.difficulty == 'FOUR_STAR'
                    ? Colors.red
                    : Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(Sizes.size3),
              ),
              child: Text(
                stage.code,
                style: const TextStyle(
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                  fontSize: Sizes.size12,
                  color: Colors.white,
                ),
              ),
            ),
            Gaps.h5,
            Flexible(
              child: Text(
                stage.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                  fontSize: Sizes.size12,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
