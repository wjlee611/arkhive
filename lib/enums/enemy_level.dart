import 'package:flutter/material.dart';

enum EEnemyLevel {
  normal('일반', Color.fromRGBO(69, 90, 100, 1)),
  elite('정예', Colors.deepOrange),
  boss('보스', Colors.purple);

  final String ko;
  final Color bgColor;

  const EEnemyLevel(
    this.ko,
    this.bgColor,
  );
}

EEnemyLevel enemyLevelSelector(String level) {
  switch (level) {
    case 'NORMAL':
      return EEnemyLevel.normal;
    case 'ELITE':
      return EEnemyLevel.elite;
    case 'BOSS':
      return EEnemyLevel.boss;
    default:
      return EEnemyLevel.normal;
  }
}
