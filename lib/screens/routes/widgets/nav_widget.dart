import 'package:arkhive/bloc/screen_bloc.dart';
import 'package:arkhive/constants/app_data.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/screens_model.dart';
import 'package:arkhive/screens/enemy/enemy_screen.dart';
import 'package:arkhive/screens/information/info_screen.dart';
import 'package:arkhive/screens/home/home_screen.dart';
import 'package:arkhive/screens/item/item_screen.dart';
import 'package:arkhive/screens/operator/operator_screen.dart';
import 'package:arkhive/screens/routes/widgets/nav_new_screen_listtile_widget.dart';
import 'package:arkhive/screens/routes/widgets/nav_stack_screen_listtile_widget.dart';
import 'package:arkhive/screens/settings/settings_screen.dart';
import 'package:arkhive/screens/stage/stage_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_darkmode_switch.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
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
                  child: AppFont(
                    "Menu",
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w700,
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
                  const NewScreenListTile(
                    id: ScreenModel.main,
                    screen: Screens.home,
                    newScreen: HomeScreen(),
                  ),
                  const NewScreenListTile(
                    id: ScreenModel.item,
                    screen: Screens.items,
                    newScreen: ItemScreen(),
                  ),
                  const NewScreenListTile(
                    id: ScreenModel.stage,
                    screen: Screens.stages,
                    newScreen: StageScreen(),
                  ),
                  const NewScreenListTile(
                    id: ScreenModel.operators,
                    screen: Screens.operators,
                    newScreen: OperatorScreen(),
                  ),
                  const NewScreenListTile(
                    id: ScreenModel.enemy,
                    screen: Screens.enemies,
                    newScreen: EnemyScreen(),
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppFont(
                      "다크 모드 활성화",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    Gaps.h20,
                    CommonDarkmodeSwitch(),
                  ],
                ),
                AppFont(
                  'version. ${AppData.version}',
                  color: Colors.white,
                  fontSize: Sizes.size10,
                ),
                Gaps.v10,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
