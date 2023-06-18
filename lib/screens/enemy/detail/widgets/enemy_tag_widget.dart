import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
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
          color: Colors.grey.shade300,
        ),
      ),
      child: Text(
        tag == 'ELITE'
            ? '정예'
            : tag == 'BOSS'
                ? '보스'
                : '일반',
        style: TextStyle(
          color: _textColorPicker(tag),
          fontWeight: FontWeight.w700,
          fontSize: Sizes.size12,
          fontFamily: FontFamily.nanumGothic,
        ),
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
        color: Colors.white,
        border: Border.all(
          width: Sizes.size3 / Sizes.size2,
          color: Colors.grey.shade300,
        ),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.black,
          fontSize: Sizes.size12,
          fontFamily: FontFamily.nanumGothic,
        ),
      ),
    );
  }
}
