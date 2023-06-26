import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy_list_model.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:flutter/material.dart';

class EnemyButton extends StatelessWidget {
  const EnemyButton({
    super.key,
    required this.enemy,
  });

  final EnemyListModel enemy;

  Color _colorPicker(String enemyType) {
    if (enemyType == 'ELITE') return Colors.deepOrange;
    if (enemyType == 'BOSS') return Colors.purple;
    return Colors.blueGrey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => OpenDetailScreen.onEnemyTab(
        enemyKey: enemy.enemyKey,
        context: context,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: _colorPicker(enemy.level),
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
                color: _colorPicker(enemy.level),
                boxShadow: [
                  BoxShadow(
                    blurRadius: Sizes.size5,
                    color: _colorPicker(enemy.level),
                  ),
                ],
              ),
              child: Text(
                enemy.enemyIndex,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size14,
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
