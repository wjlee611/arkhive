import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/enums/enemy_level.dart';
import 'package:arkhive/enums/enemy_tag.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class EnemyLevelTagWidget extends StatelessWidget {
  final String tag;

  const EnemyLevelTagWidget({
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
        color: enemyLevelSelector(tag).bgColor,
        border: Border.all(
          width: Sizes.size3 / Sizes.size2,
          color: Theme.of(context).shadowColor,
        ),
      ),
      child: AppFont(
        enemyLevelSelector(tag).ko,
        color: Colors.white,
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
