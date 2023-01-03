import 'package:Arkhive/screens/enemy_screen.dart';
import 'package:Arkhive/screens/gimmick_screen.dart';
import 'package:Arkhive/screens/info_screen.dart';
import 'package:Arkhive/screens/item_screen.dart';
import 'package:Arkhive/screens/main_screen.dart';
import 'package:Arkhive/screens/operator_screen.dart';
import 'package:Arkhive/screens/settings_screen.dart';
import 'package:Arkhive/screens/stage_screen.dart';
import 'package:flutter/material.dart';
import "../global_vars.dart" as globals;

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
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "메뉴",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
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
                  leading: const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '메인 화면',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != 'main') {
                      Navigator.pushReplacement(
                          context, _createRoute(const MainScreen()));
                      globals.screen = 'main';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.hive_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '창고 아이템',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != 'item') {
                      Navigator.pushReplacement(
                          context, _createRoute(const ItemScreen()));
                      globals.screen = 'item';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.api_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '스테이지 기믹',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != 'gimmick') {
                      Navigator.pushReplacement(
                          context, _createRoute(const GimmickScreen()));
                      globals.screen = 'gimmick';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.account_tree_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '스테이지 정보',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != 'stage') {
                      Navigator.pushReplacement(
                          context, _createRoute(const StageScreen()));
                      globals.screen = 'stage';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.perm_contact_cal_sharp,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '오퍼레이터',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != 'operator') {
                      Navigator.pushReplacement(
                          context, _createRoute(const OperatorScreen()));
                      globals.screen = 'operator';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.whatshot_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '적',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    if (globals.screen != 'enemy') {
                      Navigator.pushReplacement(
                          context, _createRoute(const EnemyScreen()));
                      globals.screen = 'enemy';
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
