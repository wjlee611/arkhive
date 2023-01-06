import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../global_vars.dart' as globals;

class OperatorScreen extends StatefulWidget {
  const OperatorScreen({super.key});

  @override
  State<OperatorScreen> createState() => _OperatorScreenState();
}

class _OperatorScreenState extends State<OperatorScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
      body: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return StickyHeader(
            header: Container(
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(
                      0,
                      1,
                    ),
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
                              ? "assets/images/class_sniper.png"
                              : index == 2
                                  ? "assets/images/class_guard.png"
                                  : index == 3
                                      ? "assets/images/class_caster.png"
                                      : index == 4
                                          ? "assets/images/class_defender.png"
                                          : index == 5
                                              ? "assets/images/class_medic.png"
                                              : index == 6
                                                  ? "assets/images/class_specialist.png"
                                                  : "assets/images/class_supporter.png",
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
                            index == 0
                                ? OperatorModel.vanguard
                                : index == 1
                                    ? OperatorModel.sniper
                                    : index == 2
                                        ? OperatorModel.guard
                                        : index == 3
                                            ? OperatorModel.caster
                                            : index == 4
                                                ? OperatorModel.defender
                                                : index == 5
                                                    ? OperatorModel.medic
                                                    : index == 6
                                                        ? OperatorModel
                                                            .specialist
                                                        : OperatorModel
                                                            .supporter,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: FontFamily.nanumGothic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "${globals.classedOperators[index].length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: FontFamily.nanumGothic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            content: ClassListView(classIdx: index),
          );
        },
        itemCount: 8,
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
    return SizedBox(
      height: globals.classedOperators[classIdx].length * 50,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
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
                  Text(
                    globals.classedOperators[classIdx][index].name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: globals.classedOperators[classIdx].length,
      ),
    );
  }
}
