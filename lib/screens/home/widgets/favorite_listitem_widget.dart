import 'package:arkhive/constants/app_data.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/favorite_model.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:arkhive/widgets/common_diffgroup_widget.dart';
import 'package:flutter/material.dart';

class FavoriteListItemWidget extends StatelessWidget {
  final FavoriteModel fav;
  final int index;
  final bool isLast;
  final bool isEditMode;

  const FavoriteListItemWidget({
    super.key,
    required this.fav,
    required this.index,
    this.isLast = false,
    required this.isEditMode,
  });

  String? _imagePath(String? iconId) {
    if (iconId == null) return null;

    switch (fav.category) {
      case FavorCategory.enemy:
        {
          return 'assets/images/enemy/$iconId.png';
        }
      case FavorCategory.item:
        {
          return 'assets/images/item/$iconId.png';
        }
      case FavorCategory.oper:
        {
          return 'assets/images/operator/$iconId.png';
        }
      default:
        {
          return null;
        }
    }
  }

  void _onTap(BuildContext context) {
    if (fav.category == null) return;

    switch (fav.category!) {
      case FavorCategory.enemy:
        {
          OpenDetailScreen.onEnemyTab(
            enemyKey: fav.key!,
            name: fav.name!,
            context: context,
          );
          break;
        }
      case FavorCategory.item:
        {
          OpenDetailScreen.onItemTab(
            itemKey: fav.key!,
            iconId: fav.iconId!,
            name: fav.name!,
            context: context,
          );
          break;
        }
      case FavorCategory.oper:
        {
          OpenDetailScreen.onOperatorTab(
            operatorKey: fav.key!,
            name: fav.name!,
            context: context,
          );
          break;
        }
      case FavorCategory.stage:
        {
          OpenDetailScreen.onStageTab(
            stageKey: fav.key!,
            stageCode: fav.name!,
            diff: fav.diff!,
            context: context,
          );
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
        height: Sizes.size52,
        decoration: BoxDecoration(
          color: index % 2 == 0
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Theme.of(context).shadowColor,
            )
          ],
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(isLast ? Sizes.size10 : 0),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  if (_imagePath(fav.iconId) != null)
                    AssetImageWidget(
                      path: _imagePath(fav.iconId)!,
                      width: Sizes.size52,
                    ),
                  Gaps.h10,
                  fav.category == FavorCategory.stage
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size1,
                            horizontal: Sizes.size5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade800,
                            borderRadius: BorderRadius.circular(Sizes.size2),
                          ),
                          child: AppFont(
                            fav.name ?? fav.key!,
                            fontSize: Sizes.size14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Flexible(
                          child: AppFont(
                            fav.name ?? fav.key!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  CommonDiffGroupWidget(diffGroup: fav.diff),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: Sizes.size10),
              child: AppFont(fav.category?.message ?? AppData.nullStr),
            ),
          ],
        ),
      ),
    );
  }
}
