import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/screens_model.dart';
import 'package:arkhive/screens/enemy_screen.dart';
import 'package:arkhive/screens/gimmick_screen.dart';
import 'package:arkhive/screens/info_screen.dart';
import 'package:arkhive/screens/item_screen.dart';
import 'package:arkhive/screens/main_screen.dart';
import 'package:arkhive/screens/operator_screen.dart';
import 'package:arkhive/screens/settings_screen.dart';
import 'package:arkhive/screens/stage_screen.dart';
import 'package:flutter/material.dart';
import "../global_vars.dart" as globals;
import 'dart:math' as math;

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey.shade700,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.translate(
                  offset: const Offset(
                    0,
                    44,
                  ),
                  child: Transform.rotate(
                    angle: 45 * math.pi / 180,
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.shade700,
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.blueGrey.shade700,
                          child: Center(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow.shade900,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.blueGrey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 70),
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 30,
                        ),
                        Shadow(
                          color: Colors.black,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home_outlined,
                    color: globals.screen == ScreenModel.main
                        ? Colors.yellow.shade700
                        : Colors.white,
                  ),
                  title: Text(
                    '메인 화면',
                    style: TextStyle(
                      color: globals.screen == ScreenModel.main
                          ? Colors.yellow.shade700
                          : Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: globals.screen == ScreenModel.main
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != ScreenModel.main) {
                      Navigator.pushReplacement(
                          context, _createRoute(const MainScreen()));
                      globals.screen = ScreenModel.main;
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.hive_outlined,
                    color: globals.screen == ScreenModel.item
                        ? Colors.yellow.shade700
                        : Colors.white,
                  ),
                  title: Text(
                    '창고 아이템',
                    style: TextStyle(
                      color: globals.screen == ScreenModel.item
                          ? Colors.yellow.shade700
                          : Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: globals.screen == ScreenModel.item
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != ScreenModel.item) {
                      Navigator.pushReplacement(
                          context, _createRoute(const ItemScreen()));
                      globals.screen = ScreenModel.item;
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.api_outlined,
                    color: globals.screen == ScreenModel.gimmick
                        ? Colors.yellow.shade700
                        : Colors.white,
                  ),
                  title: Text(
                    '스테이지 기믹',
                    style: TextStyle(
                      color: globals.screen == ScreenModel.gimmick
                          ? Colors.yellow.shade700
                          : Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: globals.screen == ScreenModel.gimmick
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != ScreenModel.gimmick) {
                      Navigator.pushReplacement(
                          context, _createRoute(const GimmickScreen()));
                      globals.screen = ScreenModel.gimmick;
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_tree_outlined,
                    color: globals.screen == ScreenModel.stage
                        ? Colors.yellow.shade700
                        : Colors.white,
                  ),
                  title: Text(
                    '스테이지 정보',
                    style: TextStyle(
                      color: globals.screen == ScreenModel.stage
                          ? Colors.yellow.shade700
                          : Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: globals.screen == ScreenModel.stage
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != ScreenModel.stage) {
                      Navigator.pushReplacement(
                          context, _createRoute(const StageScreen()));
                      globals.screen = ScreenModel.stage;
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.perm_contact_cal_sharp,
                    color: globals.screen == ScreenModel.operators
                        ? Colors.yellow.shade700
                        : Colors.white,
                  ),
                  title: Text(
                    '오퍼레이터',
                    style: TextStyle(
                      color: globals.screen == ScreenModel.operators
                          ? Colors.yellow.shade700
                          : Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: globals.screen == ScreenModel.operators
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != ScreenModel.operators) {
                      Navigator.pushReplacement(
                          context, _createRoute(const OperatorScreen()));
                      globals.screen = ScreenModel.operators;
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.whatshot_outlined,
                    color: globals.screen == ScreenModel.enemy
                        ? Colors.yellow.shade700
                        : Colors.white,
                  ),
                  title: Text(
                    '적',
                    style: TextStyle(
                      color: globals.screen == ScreenModel.enemy
                          ? Colors.yellow.shade700
                          : Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: globals.screen == ScreenModel.enemy
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != ScreenModel.enemy) {
                      Navigator.pushReplacement(
                          context, _createRoute(const EnemyScreen()));
                      globals.screen = ScreenModel.enemy;
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Container(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '설정',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    Navigator.push(
                        context, _createRoute(const SettingsScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '정보 / 후원',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    Navigator.push(context, _createRoute(const InfoScreen()));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "Arkhive 1.0.0",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
