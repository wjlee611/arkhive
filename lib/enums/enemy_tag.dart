import 'package:arkhive/constants/app_data.dart';

enum EEnemyTag {
  animated('요괴'),
  drone('드론'),
  infection('감염생물'),
  machine('기계'),
  mutant('숙주'),
  originiumartscraft('아츠 피조물'),
  seamonster('바다 괴물'),
  sarkaz('살카즈'),
  noResult(AppData.nullStr);

  final String ko;

  const EEnemyTag(this.ko);
}

EEnemyTag enemyTagSelector(String tag) {
  switch (tag) {
    case 'animated':
    case '요괴':
      return EEnemyTag.animated;
    case 'drone':
    case '드론':
      return EEnemyTag.drone;
    case 'infection':
    case '감염생물':
      return EEnemyTag.infection;
    case 'machine':
    case '기계':
      return EEnemyTag.machine;
    case 'mutant':
    case '숙주':
      return EEnemyTag.mutant;
    case 'originiumartscraft':
    case '아츠 피조물':
      return EEnemyTag.originiumartscraft;
    case 'seamonster':
    case '바다 괴물':
      return EEnemyTag.seamonster;
    case 'sarkaz':
    case '살카즈':
      return EEnemyTag.sarkaz;
    default:
      return EEnemyTag.noResult;
  }
}
