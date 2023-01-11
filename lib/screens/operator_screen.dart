import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/tools/willpop_function.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import '../global_vars.dart' as globals;

class OperatorScreen extends StatefulWidget {
  const OperatorScreen({super.key});

  @override
  State<OperatorScreen> createState() => _OperatorScreenState();
}

List<bool> _isOpen = [
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
];

class _OperatorScreenState extends State<OperatorScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    if (globals.classedOperators[0].isEmpty) {
      globals.GlobVarInitializer.readOperatorJson();
    }
    if (globals.enemies.isEmpty) {
      globals.GlobVarInitializer.readEnemyJson();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '오퍼레이터',
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
          controller: _controller,
          slivers: [
            for (int index = 0;
                index < globals.classedOperators.length;
                index++)
              SliverStickyHeader.builder(
                builder: (context, state) {
                  return Container(
                    height: 50.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.centerLeft,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            index == 0
                                ? "assets/images/class_vanguard.png"
                                : index == 1
                                    ? "assets/images/class_guard.png"
                                    : index == 2
                                        ? "assets/images/class_defender.png"
                                        : index == 3
                                            ? "assets/images/class_sniper.png"
                                            : index == 4
                                                ? "assets/images/class_caster.png"
                                                : index == 5
                                                    ? "assets/images/class_medic.png"
                                                    : index == 6
                                                        ? "assets/images/class_supporter.png"
                                                        : "assets/images/class_specialist.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${index == 0 ? OperatorPositions.vanguard : index == 1 ? OperatorPositions.guard : index == 2 ? OperatorPositions.defender : index == 3 ? OperatorPositions.sniper : index == 4 ? OperatorPositions.caster : index == 5 ? OperatorPositions.medic : index == 6 ? OperatorPositions.supporter : OperatorPositions.specialist}  /  ${globals.classedOperators[index].length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: FontFamily.nanumGothic,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isOpen[index] = !_isOpen[index];

                                      double offset = 0;
                                      const height = 50;

                                      for (int i = 0; i < 8; i++) {
                                        if (_isOpen[i]) {
                                          offset = offset +
                                              globals.classedOperators[i]
                                                      .length *
                                                  height;
                                        }
                                        offset = offset + height;
                                        if (i == index) {
                                          break;
                                        }
                                      }

                                      if (!_isOpen[index] && state.isPinned) {
                                        _controller.jumpTo(offset - 50);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    _isOpen[index]
                                        ? Icons.keyboard_arrow_down_rounded
                                        : Icons.keyboard_arrow_up_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                sliver: ClassListView(classIdx: index),
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
                          '///    ${globals.classedOperators[0].length + globals.classedOperators[1].length + globals.classedOperators[2].length + globals.classedOperators[3].length + globals.classedOperators[4].length + globals.classedOperators[5].length + globals.classedOperators[6].length + globals.classedOperators[7].length} results    ///',
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

class ClassListView extends StatelessWidget {
  final int classIdx;

  const ClassListView({
    Key? key,
    required this.classIdx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
            onTap: () => OpenDetailScreen.onOperatorTab(
              list: globals.classedOperators[classIdx],
              name: globals.classedOperators[classIdx][index].name,
              context: context,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.white : Colors.grey.shade100,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 5,
                    decoration: BoxDecoration(
                      color: globals.classedOperators[classIdx][index].rare ==
                              "6"
                          ? Colors.white
                          : globals.classedOperators[classIdx][index].rare ==
                                  "5"
                              ? Colors.yellow.shade700
                              : Colors.grey.shade800,
                    ),
                  ),
                  Hero(
                    tag: globals.classedOperators[classIdx][index].imageName,
                    child: Container(
                      width: 50,
                      height: 50,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(),
                      child: Image.asset(
                        'assets/images/operators/${globals.classedOperators[classIdx][index].imageName}.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            globals.classedOperators[classIdx][index].name
                                .replaceAll(" (한정)", "")
                                .replaceAll(" [한정]", ""),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        globals.classedOperators[classIdx][index].name
                                    .contains("(한정)") ||
                                globals.classedOperators[classIdx][index].name
                                    .contains("[한정]")
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 20, 0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 3,
                                  ),
                                  decoration: globals
                                          .classedOperators[classIdx][index]
                                          .name
                                          .contains("(한정)")
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            stops: const [
                                              0.1,
                                              0.3,
                                              0.5,
                                              0.7,
                                              0.9,
                                            ],
                                            colors: [
                                              Colors.blueAccent
                                                  .withOpacity(0.5),
                                              Colors.yellow.withOpacity(0.5),
                                              Colors.white.withOpacity(0),
                                              Colors.teal.withOpacity(0.5),
                                              Colors.blueAccent
                                                  .withOpacity(0.5),
                                            ],
                                          ),
                                        )
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            stops: const [
                                              0.1,
                                              0.3,
                                              0.5,
                                              0.7,
                                              0.9,
                                            ],
                                            colors: [
                                              Colors.yellow.withOpacity(0.5),
                                              Colors.redAccent.withOpacity(0.5),
                                              Colors.white.withOpacity(0),
                                              Colors.orange.withOpacity(0.5),
                                              Colors.redAccent.withOpacity(0.5),
                                            ],
                                          ),
                                        ),
                                  child: Text(
                                    globals.classedOperators[classIdx][index]
                                            .name
                                            .contains("(한정)")
                                        ? "한정"
                                        : "콜라보 한정",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: FontFamily.nanumGothic,
                                      fontWeight: FontWeight.w700,
                                      shadows: [
                                        const Shadow(
                                          blurRadius: 10,
                                        ),
                                        Shadow(
                                          blurRadius: 7,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount:
            _isOpen[classIdx] ? globals.classedOperators[classIdx].length : 0,
      ),
    );
  }
}
