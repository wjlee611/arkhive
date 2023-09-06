enum EEnemyApplyWay {
  all('근·원거리'),
  melee('근거리'),
  ranged('원거리'),
  none('공격하지 않음'),
  noResult('?');

  final String ko;

  const EEnemyApplyWay(this.ko);
}

EEnemyApplyWay enemyApplyWaySelector(String type) {
  switch (type) {
    case 'MELEE':
      return EEnemyApplyWay.melee;
    case 'RANGED':
      return EEnemyApplyWay.ranged;
    case 'NONE':
      return EEnemyApplyWay.none;
    case 'ALL':
      return EEnemyApplyWay.all;
  }
  return EEnemyApplyWay.noResult;
}
