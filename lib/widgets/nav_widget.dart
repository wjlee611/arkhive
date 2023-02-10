import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/screens_model.dart';
import 'package:arkhive/screens/enemy/enemy_screen.dart';
import 'package:arkhive/screens/gimmick/gimmick_screen.dart';
import 'package:arkhive/screens/information/info_screen.dart';
import 'package:arkhive/screens/item/item_screen.dart';
import 'package:arkhive/screens/home/home_screen.dart';
import 'package:arkhive/screens/operator/operator_screen.dart';
import 'package:arkhive/screens/settings/settings_screen.dart';
import 'package:arkhive/screens/stage/stage_screen.dart';
import 'package:arkhive/widgets/nav_new_screen_listtile_widget.dart';
import 'package:arkhive/widgets/nav_stack_screen_listtile_widget.dart';
import 'package:flutter/material.dart';
import '../global_data.dart';
import 'dart:math' as math;

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final GlobalData _globalData = GlobalData();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey.shade700.withOpacity(0.8),
      child: SafeArea(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.translate(
                  offset: const Offset(0, Sizes.size44),
                  child: Transform.rotate(
                    angle: 45 * math.pi / 180,
                    child: Container(
                      width: Sizes.size64,
                      height: Sizes.size64,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.shade700,
                            blurRadius: Sizes.size5,
                          )
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: Sizes.size60,
                          height: Sizes.size60,
                          color: Colors.blueGrey.shade700.withOpacity(0.8),
                          child: Center(
                            child: Container(
                              width: Sizes.size48,
                              height: Sizes.size48,
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow.shade900,
                                    blurRadius: Sizes.size5,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Container(
                                  width: Sizes.size40,
                                  height: Sizes.size40,
                                  color:
                                      Colors.blueGrey.shade700.withOpacity(0.8),
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
                  padding: EdgeInsets.only(bottom: Sizes.size64),
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                      fontSize: Sizes.size20,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: Sizes.size28,
                        ),
                        Shadow(
                          color: Colors.black,
                          blurRadius: Sizes.size28,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.zero,
                children: [
                  NewScreenListTile(
                    id: ScreenModel.main,
                    isSelected: _globalData.screen == ScreenModel.main,
                    icon: Icons.home_outlined,
                    title: '메인 화면',
                    newScreen: const HomeScreen(),
                  ),
                  NewScreenListTile(
                    id: ScreenModel.item,
                    isSelected: _globalData.screen == ScreenModel.item,
                    icon: Icons.hive_outlined,
                    title: '창고 아이템',
                    newScreen: const ItemScreen(),
                  ),
                  NewScreenListTile(
                    id: ScreenModel.gimmick,
                    isSelected: _globalData.screen == ScreenModel.gimmick,
                    icon: Icons.api_outlined,
                    title: '스테이지 기믹',
                    newScreen: const GimmickScreen(),
                  ),
                  NewScreenListTile(
                    id: ScreenModel.stage,
                    isSelected: _globalData.screen == ScreenModel.stage,
                    icon: Icons.account_tree_outlined,
                    title: '스테이지 정보',
                    newScreen: const StageScreen(),
                  ),
                  NewScreenListTile(
                    id: ScreenModel.operators,
                    isSelected: _globalData.screen == ScreenModel.operators,
                    icon: Icons.badge_outlined,
                    title: '오퍼레이터',
                    newScreen: const OperatorScreen(),
                  ),
                  NewScreenListTile(
                    id: ScreenModel.enemy,
                    isSelected: _globalData.screen == ScreenModel.enemy,
                    icon: Icons.whatshot_outlined,
                    title: '적',
                    newScreen: const EnemyScreen(),
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
                  const StackScreenListTile(
                    icon: Icons.settings,
                    title: '설정',
                    newScreen: SettingsScreen(),
                  ),
                  const StackScreenListTile(
                    icon: Icons.info_outline_rounded,
                    title: '정보 / 후원',
                    newScreen: InfoScreen(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Sizes.size20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Arkhive ${GlobalData.appVersion}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
