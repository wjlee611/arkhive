import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import '../global_vars.dart' as globals;

class EnemyScreen extends StatefulWidget {
  const EnemyScreen({super.key});

  @override
  State<EnemyScreen> createState() => _EnemyScreenState();
}

class _EnemyScreenState extends State<EnemyScreen> {
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
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Card(
            color: globals.enemies[index].enemyType == EnemyType.elite
                ? Colors.deepOrange
                : globals.enemies[index].enemyType == EnemyType.boss
                    ? Colors.purple
                    : Colors.white,
            margin: const EdgeInsets.all(5),
            elevation: 5,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image.asset(
                    'assets/images/enemies/${globals.enemies[index].code}.png'),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: globals.enemies[index].enemyType == EnemyType.elite
                        ? Colors.deepOrange.withOpacity(0.8)
                        : globals.enemies[index].enemyType == EnemyType.boss
                            ? Colors.purple.withOpacity(0.8)
                            : Colors.black.withOpacity(0.5),
                  ),
                  child: Text(
                    globals.enemies[index].code.replaceAll('_', '*'),
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
        },
        itemCount: globals.enemies.length,
      ),
      drawer: const NavDrawer(),
    );
  }
}
