import 'package:arkhive/constants/app_data.dart';

enum EOperatorProfession {
  medic('메딕'),
  warrior('가드'),
  special('스페셜리스트'),
  sniper('스나이퍼'),
  pioneer('뱅가드'),
  tank('디펜더'),
  caster('캐스터'),
  support('서포터'),
  noResult(AppData.nullStr);

  final String ko;

  const EOperatorProfession(this.ko);
}

EOperatorProfession operatorProfessionSelector(String prof) {
  switch (prof) {
    case 'MEDIC':
      return EOperatorProfession.medic;
    case 'WARRIOR':
      return EOperatorProfession.warrior;
    case 'SPECIAL':
      return EOperatorProfession.special;
    case 'SNIPER':
      return EOperatorProfession.sniper;
    case 'PIONEER':
      return EOperatorProfession.pioneer;
    case 'TANK':
      return EOperatorProfession.tank;
    case 'CASTER':
      return EOperatorProfession.caster;
    case 'SUPPORT':
      return EOperatorProfession.support;
    default:
      return EOperatorProfession.noResult;
  }
}
