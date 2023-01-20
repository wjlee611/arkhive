import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/detail/enemy_detail_screen.dart';
import 'package:arkhive/screens/detail/operator_detail_screen.dart';
import 'package:flutter/foundation.dart';
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
    required List<OperatorModel> list,
    required String name,
    required dynamic context,
    required Future<Uint8List?> opImage,
  }) async {
    Uint8List? opImage_;
    await opImage.then((value) => opImage_ = value);

    for (var operator_ in list) {
      if (operator_.name == name) {
        Navigator.push(
            context,
            _createRoute(OperatorDetailScreen(
              operator_: operator_,
              opImage: opImage_,
            )));
        return;
      }
    }
  }

  static void onEnemyTab({
    required List<EnemyModel> list,
    required String code,
    required dynamic context,
    required Future<Uint8List?> enemyImage,
    int level = 0,
  }) async {
    Uint8List? enemyImage_;
    await enemyImage.then((value) => enemyImage_ = value);

    for (var enemy in list) {
      if (enemy.code == code) {
        Navigator.push(
            context,
            _createRoute(EnemyDetailScreen(
              enemy: enemy,
              initLevel: level,
              enemyImage: enemyImage_,
            )));
        return;
      }
    }
  }
}
