import 'package:flutter/material.dart';

enum EScreen {
  home(
    'home',
    Icons.home_outlined,
    '메인 화면',
  ),
  items(
    'items',
    Icons.hive_outlined,
    '창고 아이템',
  ),
  stages(
    'stages',
    Icons.account_tree_outlined,
    '스테이지 정보',
  ),
  operators(
    'operators',
    Icons.badge_outlined,
    '오퍼레이터',
  ),
  enemies(
    'enemies',
    Icons.whatshot_outlined,
    '적',
  ),
  recurit(
    'recurit',
    Icons.calculate_rounded,
    '공개모집 계산기',
  ),
  setting(
    'setting',
    Icons.settings,
    '설정',
  ),
  info(
    'info',
    Icons.info_outline_rounded,
    '정보 / 후원',
  ),
  noResult(
    'noResult',
    Icons.question_mark,
    '404',
  );

  final String value;
  final IconData icon;
  final String ko;

  const EScreen(
    this.value,
    this.icon,
    this.ko,
  );
}
