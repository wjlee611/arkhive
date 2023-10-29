import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/enums/rarity_tier.dart';
import 'package:arkhive/models/operator/operator_list_model.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:flutter/material.dart';

class RecruitOperatorButton extends StatelessWidget {
  final OperatorListModel operator_;
  final int index;

  const RecruitOperatorButton({
    super.key,
    required this.operator_,
    required this.index,
  });

  Color _rarityColorSelector(String rarity) {
    var intRarity = rarityTierConverter(rarity);

    if (intRarity == ERarityTier.tier6) return Colors.white;
    if (intRarity == ERarityTier.tier5) return Colors.yellow.shade700;
    return Colors.grey.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => OpenDetailScreen.onOperatorTab(
        context: context,
        operatorKey: operator_.operatorKey,
        name: operator_.name,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: index % 2 == 0
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Sizes.size52,
              width: Sizes.size5,
              decoration: BoxDecoration(
                color: _rarityColorSelector(operator_.rarity),
              ),
            ),
            Container(
              width: Sizes.size52,
              height: Sizes.size52,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: AssetImageWidget(
                path: 'assets/images/operator/${operator_.operatorKey}.png',
              ),
            ),
            Gaps.h20,
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: AppFont(
                      operator_.name,
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
