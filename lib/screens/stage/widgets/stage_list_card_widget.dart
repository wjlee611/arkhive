import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/stage/stage_list_model.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class StageListCardWidget extends StatelessWidget {
  const StageListCardWidget({
    super.key,
    required this.stage,
  });

  final StageListModel stage;

  void _onTap({
    required String stageKey,
    required String stageCode,
    required String diffGroup,
    required String difficulty,
    required BuildContext context,
  }) {
    OpenDetailScreen.onStageTab(
      stageKey: stageKey,
      stageCode: stageCode,
      diffGroup: diffGroup,
      difficulty: difficulty,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(
        stageKey: stage.stageId,
        stageCode: stage.code,
        diffGroup: stage.diffGroup,
        difficulty: stage.difficulty,
        context: context,
      ),
      borderRadius: BorderRadius.circular(Sizes.size10),
      child: Container(
        height: Sizes.size52,
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
                    ? Colors.redAccent
                    : Colors.blueGrey.shade800,
                borderRadius: BorderRadius.circular(Sizes.size3),
              ),
              child: AppFont(
                stage.code,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.h5,
            Flexible(
              child: AppFont(
                stage.name,
                fontWeight: FontWeight.w700,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
