import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/enums/enemy_apply_way.dart';
import 'package:arkhive/enums/enemy_damage_type.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class InfoTag extends StatelessWidget {
  const InfoTag({
    Key? key,
    required this.title,
    required this.value,
    this.values,
    this.applyWay,
  }) : super(key: key);

  final String title, value;
  // CN
  final List<String>? values;
  final String? applyWay;

  Color _colorPicker({
    required String title,
    required String value,
  }) {
    if (title == '공격 방식') {
      if (value == '공격하지 않음') return Colors.blueGrey.shade600;
      if (value.contains('아츠')) return Colors.redAccent;
      if (value.contains('치료')) return Colors.green;
      return Colors.blueAccent;
    }
    if (title == '무게 레벨') {
      return Colors.yellow.shade700;
    }
    return Colors.blueGrey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              blurRadius: Sizes.size2,
              spreadRadius: Sizes.size1 / 10,
              color: Theme.of(context).shadowColor,
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
                child: AppFont(
                  title,
                  fontSize: Sizes.size10,
                ),
              ),
            ),
            if (values == null)
              Container(
                height: Sizes.size24,
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size5),
                color: _colorPicker(
                  title: title,
                  value: value,
                ),
                child: Center(
                  child: AppFont(
                    value,
                    color: Colors.white,
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            // CN
            if (values != null)
              for (var value in values!)
                Container(
                  height: Sizes.size24,
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.size5),
                  color: enemyDamageTypeSelector(value).color,
                  child: Center(
                    child: Row(
                      children: [
                        AppFont(
                          enemyDamageTypeSelector(value).ko,
                          color: Colors.white,
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
            if (values != null &&
                applyWay != null &&
                (value == 'HEAL' || applyWay != 'NONE'))
              Container(
                height: Sizes.size24,
                padding: const EdgeInsets.only(right: Sizes.size5),
                color: enemyDamageTypeSelector(values!.last).color,
                child: Center(
                  child: Row(
                    children: [
                      const AppFont(
                        '/',
                        color: Colors.white,
                        fontSize: Sizes.size10,
                      ),
                      Gaps.h5,
                      AppFont(
                        enemyApplyWaySelector(applyWay!).ko,
                        color: Colors.white,
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
