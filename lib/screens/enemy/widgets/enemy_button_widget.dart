import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/tools/load_image_from_securestorage.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:flutter/material.dart';

class EnemyButton extends StatelessWidget {
  const EnemyButton({
    Key? key,
    required this.enemy,
  }) : super(key: key);

  final EnemyModel enemy;

  Color _colorPicker(String enemyType) {
    if (enemyType == 'ELITE') return Colors.deepOrange;
    if (enemyType == 'BOSS') return Colors.purple;
    return Colors.blueGrey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => OpenDetailScreen.onEnemyTab(
        enemy: enemy,
        context: context,
      ),
      child: FutureBuilder(
        future: getImageFromSP("enemy/${enemy.enemyId}"),
        builder: (context, snapshot) {
          return Card(
            clipBehavior: Clip.hardEdge,
            color: _colorPicker(enemy.enemyLevel!),
            elevation: Sizes.size5,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Hero(
                  tag: enemy.enemyId!,
                  child: snapshot.hasData
                      ? Image.memory(
                          snapshot.data!,
                          gaplessPlayback: true,
                        )
                      : Image.asset(
                          'assets/images/prts.png',
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
                    color: _colorPicker(enemy.enemyLevel!),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: Sizes.size5,
                        color: _colorPicker(enemy.enemyLevel!),
                      ),
                    ],
                  ),
                  child: Text(
                    enemy.enemyIndex!,
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
          );
        },
      ),
    );
  }
}
