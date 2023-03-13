import 'package:arkhive/models/item_model.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/item/detail/item_detail_screen.dart';
import 'package:arkhive/screens/operator/detail/operator_detail_screen.dart';
import 'package:arkhive/tools/load_image_from_securestorage.dart';
import 'package:flutter/material.dart';
import '../models/enemy_model.dart';

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
    required OperatorModel operator_,
    required dynamic context,
  }) async {
    await Navigator.push(
      context,
      _createRoute(OperatorDetailScreen(
        operator_: operator_,
        opImage: await getImageFromSP(
            'image/operator/${operator_.phases.first.characterPrefabKey!}'),
      )),
    );
  }

  static void onEnemyTab({
    required EnemyModel enemy,
    required dynamic context,
    int level = 0,
  }) async {
    // await Navigator.push(
    //   context,
    //   _createRoute(EnemyDetailScreen(
    //     enemy: enemy,
    //     enemyImage: await getImageFromSP('image/enemy/${enemy.enemyId}'),
    //     initLevel: level,
    //   )),
    // );
  }

  static void onItemTab({
    required ItemModel item,
    required dynamic context,
  }) async {
    await Navigator.push(
      context,
      _createRoute(ItemDetailScreen(
        item: item,
        itemImage: await getImageFromSP('image/item/${item.code}'),
      )),
    );
  }
}
