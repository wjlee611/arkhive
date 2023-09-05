import 'package:flutter/material.dart';

enum EEnemyDamageType {
  magic('마법', Colors.redAccent),
  physic('물리', Colors.blueAccent),
  heal('회복', Colors.green),
  noDamage('공격하지 않음', Color.fromRGBO(84, 110, 122, 1)),
  noResult('?', Color.fromRGBO(84, 110, 122, 1));

  final String ko;
  final Color color;

  const EEnemyDamageType(
    this.ko,
    this.color,
  );
}

EEnemyDamageType enemyDamageTypeSelector(String type) {
  switch (type) {
    case 'PHYSIC':
      return EEnemyDamageType.physic;
    case 'MAGIC':
      return EEnemyDamageType.magic;
    case 'NO_DAMAGE':
      return EEnemyDamageType.noDamage;
    case 'HEAL':
      return EEnemyDamageType.heal;
  }
  return EEnemyDamageType.noResult;
}
