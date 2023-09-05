import 'package:flutter/material.dart';

enum ESkillType {
  passive('패시브', Colors.grey),
  manual('수동 발동', Colors.grey),
  auto('자동 발동', Colors.grey);

  final String text;
  final Color color;

  const ESkillType(this.text, this.color);
}

ESkillType skillTypeConvertor(String skillType) {
  switch (skillType) {
    case 'PASSIVE':
    case '0':
      return ESkillType.passive;
    case 'MANUAL':
    case '1':
      return ESkillType.manual;
    case 'AUTO':
    case '2':
      return ESkillType.auto;
    default:
      return ESkillType.manual;
  }
}
