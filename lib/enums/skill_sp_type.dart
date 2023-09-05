import 'package:flutter/material.dart';

enum ESkillSPType {
  time('자연 회복', Color.fromRGBO(102, 187, 106, 1)),
  attack('공격 회복', Color.fromRGBO(255, 109, 0, 1)),
  damage('피격 회복', Color.fromRGBO(255, 214, 0, 1));
  // 8 8 - 패시브 표시 금지

  final String text;
  final Color color;

  const ESkillSPType(this.text, this.color);
}

ESkillSPType? skillSPTypeConverter(String spType) {
  switch (spType) {
    case 'INCREASE_WITH_TIME':
    case '1':
      return ESkillSPType.time;
    case 'INCREASE_WHEN_ATTACK':
    case '2':
      return ESkillSPType.attack;
    case 'INCREASE_WHEN_TAKEN_DAMAGE':
    case '4':
      return ESkillSPType.damage;
    // 8 - 패시브 표시 금지
    default:
      return null;
  }
}
