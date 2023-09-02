import 'package:arkhive/models/operator/skill_model.dart';

int rarityConverter(String rarity) {
  switch (rarity) {
    case 'TIRE_1':
    case '0':
      return 0;
    case 'TIRE_2':
    case '1':
      return 1;
    case 'TIRE_3':
    case '2':
      return 2;
    case 'TIRE_4':
    case '3':
      return 3;
    case 'TIRE_5':
    case '4':
      return 4;
    case 'TIRE_6':
    case '5':
      return 5;
    default:
      return 0;
  }
}

int phaseConverter(String phase) {
  return int.parse(phase.split('_').last);
}

SkillType skillTypeConvertor(String skillType) {
  switch (skillType) {
    case 'PASSIVE':
    case '0':
      return SkillType.passive;
    case 'MANUAL':
    case '1':
      return SkillType.manual;
    case 'AUTO':
    case '2':
      return SkillType.auto;
    default:
      return SkillType.manual;
  }
}

SkillSPType? skillSPTypeConverter(String spType) {
  switch (spType) {
    case 'INCREASE_WITH_TIME':
    case '1':
      return SkillSPType.time;
    case 'INCREASE_WHEN_ATTACK':
    case '2':
      return SkillSPType.attack;
    case 'INCREASE_WHEN_TAKEN_DAMAGE':
    case '4':
      return SkillSPType.damage;
    // 8 - 패시브 표시 금지
    default:
      return null;
  }
}
