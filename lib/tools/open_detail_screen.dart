import 'package:arkhive/models/operator/module_model.dart';
import 'package:arkhive/models/operator/operator_model.dart';
import 'package:arkhive/screens/enemy/detail/enemy_detail_screen.dart';
import 'package:arkhive/screens/history/history_screen.dart';
import 'package:arkhive/screens/item/detail/item_detail_screen.dart';
import 'package:arkhive/screens/operator/detail/operator_detail_screen.dart';
import 'package:arkhive/screens/operator/upgrade/operator_upgrade_screen.dart';
import 'package:arkhive/screens/stage/detail/stage_detail_screen.dart';
import 'package:arkhive/screens/tutorial/tutorial_screen.dart';
import 'package:flutter/material.dart';

class OpenDetailScreen {
  static Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static void onOperatorTab({
    required String operatorKey,
    required String name,
    required dynamic context,
  }) {
    Navigator.push(
      context,
      _createRoute(OperatorDetailScreen(
        operatorKey: operatorKey,
        name: name,
      )),
    );
  }

  static void onOperatorUpgradeTab({
    required OperatorModel operator_,
    required List<ModuleModel> modules,
    required dynamic context,
  }) {
    Navigator.push(
      context,
      _createRoute(OperatorUpgradeScreen(
        operator_: operator_,
        modules: modules,
      )),
    );
  }

  static void onEnemyTab({
    required String enemyKey,
    int level = 0,
    required String name,
    String? code,
    required dynamic context,
  }) {
    Navigator.push(
      context,
      _createRoute(EnemyDetailScreen(
        enemyKey: enemyKey,
        initLevel: level,
        name: name,
        code: code,
      )),
    );
  }

  static void onStageTab({
    required String stageKey,
    required String stageCode,
    required String diffGroup,
    required String difficulty,
    required dynamic context,
  }) {
    Navigator.push(
      context,
      _createRoute(StageDetailScreen(
        stageKey: stageKey,
        stageCode: stageCode,
        diffGroup: diffGroup,
        difficulty: difficulty,
      )),
    );
  }

  static void onItemTab({
    required String itemKey,
    required String iconId,
    required String name,
    required dynamic context,
  }) async {
    await Navigator.push(
      context,
      _createRoute(ItemDetailScreen(
        itemKey: itemKey,
        iconId: iconId,
        name: name,
      )),
    );
  }

  static void onTutorialTab({
    required dynamic context,
  }) async {
    await Navigator.push(
      context,
      _createRoute(TutorialScreen()),
    );
  }

  static void onHistoryTab({
    required dynamic context,
  }) async {
    await Navigator.push(
      context,
      _createRoute(const HistoryScreen()),
    );
  }
}
