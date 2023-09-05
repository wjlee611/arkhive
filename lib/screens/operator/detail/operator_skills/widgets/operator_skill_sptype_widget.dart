import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/enums/skill_sp_type.dart';
import 'package:arkhive/enums/skill_type.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class SkillSpTypeWidget extends StatelessWidget {
  const SkillSpTypeWidget({
    super.key,
    required this.isSkillType,
    required this.type,
  });

  final bool isSkillType;
  final String type;

  @override
  Widget build(BuildContext context) {
    var text = '';
    var color = Colors.transparent;
    if (isSkillType) {
      var skillType = skillTypeConvertor(type);
      text = skillType.text;
      color = skillType.color;
    } else {
      var skillType = skillSPTypeConverter(type);
      text = skillType?.text ?? '';
      color = skillType?.color ?? Colors.black;
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
