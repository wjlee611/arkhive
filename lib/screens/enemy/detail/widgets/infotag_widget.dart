import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class InfoTag extends StatelessWidget {
  const InfoTag({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title, value;

  Color _colorPicker({
    required String title,
    required String value,
  }) {
    if (title == EnemyInfoTitle.atkType) {
      if (value == EnemyAtkType.noAttack) return Colors.blueGrey.shade600;
      if (value.contains('아츠')) return Colors.redAccent;
      if (value.contains('치료')) return Colors.green;
      return Colors.blueAccent;
    }
    if (title == EnemyInfoTitle.weightLevel) {
      return Colors.yellow.shade700;
    }
    if (title == EnemyInfoTitle.enemyType) {
      if (value == EnemyType.elite) return Colors.deepOrange;
      if (value == EnemyType.boss) return Colors.purple;
      return Colors.blueGrey.shade600;
    }
    return Colors.blueGrey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: Sizes.size2,
              spreadRadius: Sizes.size1 / 10,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Sizes.size24,
              width: Sizes.size72,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.blueGrey.shade800,
                    fontSize: Sizes.size10,
                    fontFamily: FontFamily.nanumGothic,
                  ),
                ),
              ),
            ),
            Container(
              height: Sizes.size24,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size5),
              color: _colorPicker(
                title: title,
                value: value,
              ),
              child: Center(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size14,
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
