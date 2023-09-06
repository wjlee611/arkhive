enum ESkillDurationType {
  none,
  ammo;

  const ESkillDurationType();
}

ESkillDurationType skillDurationSelector(String type) {
  switch (type) {
    case 'NONE':
    case '0':
      return ESkillDurationType.none;
    case 'AMMO':
    case '1':
    case '2':
      return ESkillDurationType.ammo;
    default:
      return ESkillDurationType.none;
  }
}
