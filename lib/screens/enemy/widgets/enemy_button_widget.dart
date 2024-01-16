import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/enums/enemy_level.dart';
import 'package:arkhive/models/enemy/enemy_list_model.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:flutter/material.dart';

class EnemyButton extends StatelessWidget {
  const EnemyButton({
    super.key,
    required this.enemy,
  });

  final EnemyListModel enemy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => OpenDetailScreen.onEnemyTab(
        enemyKey: enemy.enemyKey,
        name: enemy.name,
        code: enemy.enemyIndex,
        context: context,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size5),
        ),
        color: enemyLevelSelector(enemy.level).bgColor,
        elevation: Sizes.size5,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Hero(
              tag: enemy.enemyKey,
              child: AssetImageWidget(
                path: 'assets/images/enemy/${enemy.enemyKey}.png',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: Sizes.size5,
                right: Sizes.size5,
                bottom: Sizes.size1,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.size3),
                color: enemyLevelSelector(enemy.level).bgColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: Sizes.size5,
                    color: enemyLevelSelector(enemy.level).bgColor,
                  ),
                ],
              ),
              child: AppFont(
                enemy.enemyIndex,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
