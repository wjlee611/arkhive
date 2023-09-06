import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/enums/enemy_tag.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class EnemyLevelTagWidget extends StatelessWidget {
  final String tag;

  const EnemyLevelTagWidget({
    super.key,
    required this.tag,
  });

  Color _bgColorPicker(String enemyType) {
    if (enemyType == 'ELITE') return Colors.deepOrange;
    if (enemyType == 'BOSS') return Colors.purple;
    return Colors.white;
  }

  Color _textColorPicker(String enemyType) {
    if (enemyType == 'ELITE') return Colors.white;
    if (enemyType == 'BOSS') return Colors.white;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size7,
        horizontal: Sizes.size10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size20),
        color: _bgColorPicker(tag),
        border: Border.all(
          width: Sizes.size3 / Sizes.size2,
          color: Theme.of(context).shadowColor,
        ),
      ),
      child: AppFont(
        tag == 'ELITE'
            ? '정예'
            : tag == 'BOSS'
                ? '보스'
                : '일반',
        color: _textColorPicker(tag),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class EnemyTagWidget extends StatelessWidget {
  final String tag;

  const EnemyTagWidget({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size7,
        horizontal: Sizes.size10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size20),
        color: Theme.of(context).primaryColor,
        border: Border.all(
          width: Sizes.size3 / Sizes.size2,
          color: Theme.of(context).shadowColor,
        ),
      ),
      child: AppFont(enemyTagSelector(tag).ko),
    );
  }
}
