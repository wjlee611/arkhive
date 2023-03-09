import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/detail/operator_detail_screen.dart';
import 'package:arkhive/tools/load_image_from_securestorage.dart';
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

  // static void onEnemyTab({
  //   required String code,
  //   required dynamic context,
  //   required Future<Uint8List?> enemyImage,
  //   int level = 0,
  // }) async {
  //   List<EnemyModel> list = GlobalData().enemies;
  //   Uint8List? enemyImage_;
  //   await enemyImage.then((value) => enemyImage_ = value);

  //   for (var enemy in list) {
  //     if (enemy.code == code) {
  //       Navigator.push(
  //         context,
  //         _createRoute(EnemyDetailScreen(
  //           enemy: enemy,
  //           initLevel: level,
  //           enemyImage: enemyImage_,
  //         )),
  //       );
  //       return;
  //     }
  //   }
  // }

  // static void onItemTab({
  //   required String code,
  //   required dynamic context,
  //   required Future<Uint8List?> itemImage,
  // }) async {
  //   List<ItemModel> list = GlobalData().items;
  //   Uint8List? itemImage_;
  //   await itemImage.then((value) => itemImage_ = value);

  //   for (var item in list) {
  //     if (item.code == code) {
  //       Navigator.push(
  //         context,
  //         _createRoute(ItemDetailScreen(
  //           item: item,
  //           itemImage: itemImage_,
  //         )),
  //       );
  //       return;
  //     }
  //   }
  // }
}
