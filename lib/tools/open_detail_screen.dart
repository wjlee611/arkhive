import 'package:arkhive/models/stage_model.dart';
import 'package:arkhive/screens/operator/detail/operator_detail_screen.dart';
import 'package:arkhive/screens/stage/detail/stage_detail_screen.dart';
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
    required dynamic context,
  }) async {
    await Navigator.push(
      context,
      _createRoute(OperatorDetailScreen(
        operatorKey: operatorKey,
      )),
    );
  }

  static void onEnemyTab({
    required String enemyKey,
    required dynamic context,
    int level = 0,
  }) async {
    // await Navigator.push(
    //   context,
    //   _createRoute(EnemyDetailScreen(
    //     enemyKey: enemyKey,
    //     initLevel: level,
    //   )),
    // );
  }

  static void onStageTab({
    required StageModel stage,
    required dynamic context,
  }) async {
    await Navigator.push(
      context,
      _createRoute(StageDetailScreen(
        stage: stage,
      )),
    );
  }

  // static void onItemTab({
  //   required ItemModel item,
  //   required dynamic context,
  // }) async {
  //   await Navigator.push(
  //     context,
  //     _createRoute(ItemDetailScreen(
  //       item: item,
  //       itemImage: await getImageFromSP('image/item/${item.code}'),
  //     )),
  //   );
  // }
}
