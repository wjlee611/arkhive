import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/enemy/widgets/enemy_button_widget.dart';
import 'package:arkhive/tools/willpop_function.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import '../../global_data.dart';

class EnemyScreen extends StatefulWidget {
  const EnemyScreen({super.key});

  @override
  State<EnemyScreen> createState() => _EnemyScreenState();
}

class _EnemyScreenState extends State<EnemyScreen> {
  GlobalData globalData = GlobalData();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '적',
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        leading: IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => WillPopFunction.onWillPop(context: context),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(Sizes.size20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: Sizes.size96,
                  mainAxisSpacing: Sizes.size5,
                  crossAxisSpacing: Sizes.size5,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return EnemyButton(
                      enemy: globalData.enemies[index],
                    );
                  },
                  childCount: globalData.enemies.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade700,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: Sizes.size2,
                      spreadRadius: Sizes.size2,
                    ),
                  ],
                ),
                height: Sizes.size48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '///    ${globalData.enemies.length} results    ///',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size12,
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const NavDrawer(),
    );
  }
}
