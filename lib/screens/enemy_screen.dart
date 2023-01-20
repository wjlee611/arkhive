import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/tools/load_image_from_sharedpreference.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/tools/willpop_function.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import '../global_data.dart';

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
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () => OpenDetailScreen.onEnemyTab(
                        list: globalData.enemies,
                        code: globalData.enemies[index].code,
                        enemyImage: getImageFromSP(
                            "enemy/${globalData.enemies[index].code}"),
                        context: context,
                      ),
                      child: FutureBuilder(
                          future: getImageFromSP(
                              "enemy/${globalData.enemies[index].code}"),
                          builder: (context, snapshot) {
                            return Card(
                              clipBehavior: Clip.hardEdge,
                              color: globalData.enemies[index].enemyType ==
                                      EnemyType.elite
                                  ? Colors.deepOrange
                                  : globalData.enemies[index].enemyType ==
                                          EnemyType.boss
                                      ? Colors.purple
                                      : Colors.blueGrey.shade600,
                              elevation: 5,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Hero(
                                    tag: globalData.enemies[index].code,
                                    child: snapshot.hasData
                                        ? Image.memory(snapshot.data!)
                                        : Image.asset('assets/images/prts.png'),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 5, 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color:
                                          globalData.enemies[index].enemyType ==
                                                  EnemyType.elite
                                              ? Colors.deepOrange
                                              : globalData.enemies[index]
                                                          .enemyType ==
                                                      EnemyType.boss
                                                  ? Colors.purple
                                                  : Colors.blueGrey.shade600,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: globalData.enemies[index]
                                                      .enemyType ==
                                                  EnemyType.elite
                                              ? Colors.deepOrange
                                              : globalData.enemies[index]
                                                          .enemyType ==
                                                      EnemyType.boss
                                                  ? Colors.purple
                                                  : Colors.blueGrey.shade600,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      globalData.enemies[index].code
                                          .replaceAll('_', '*'),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: FontFamily.nanumGothic,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  },
                  childCount: globalData.enemies.length,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade700,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '///    ${globalData.enemies.length} results    ///',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
      drawer: const NavDrawer(),
    );
  }
}
