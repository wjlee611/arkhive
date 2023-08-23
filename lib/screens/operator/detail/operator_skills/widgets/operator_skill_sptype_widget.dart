import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class SkillSpTypeWidget extends StatelessWidget {
  const SkillSpTypeWidget({
    super.key,
    required this.isSkillType,
    required this.type,
  });

  final bool isSkillType;
  final int type;

  @override
  Widget build(BuildContext context) {
    var text = '';
    var color = Colors.transparent;
    if (isSkillType) {
      switch (type) {
        case 0:
          // 패시브
          text = '패시브';
          color = Colors.grey;
          break;
        case 1:
          // 수동 발동
          text = '수동 발동';
          color = Colors.grey;
          break;
        case 2:
          // 자동 발동
          text = '자동 발동';
          color = Colors.grey;
          break;
      }
    } else {
      switch (type) {
        case 1:
          // 자연 회복
          text = '자연 회복';
          color = Colors.green.shade400;
          break;
        case 2:
          // 공격 회복
          text = '공격 회복';
          color = Colors.orangeAccent.shade700;
          break;
        case 4:
          // 피격 회복
          text = '피격 회복';
          color = Colors.yellowAccent.shade700;
          break;
        case 8:
          // 패시브 (표시 금지)
          break;
      }
    }
    return text != ''
        ? Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size1,
              horizontal: Sizes.size3,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size2),
              color: color,
            ),
            child: AppFont(
              text,
              color: Colors.white,
              fontSize: Sizes.size10,
              fontWeight: FontWeight.w700,
            ),
          )
        : Container();
  }
}
