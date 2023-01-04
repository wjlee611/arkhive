import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
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
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return StickyHeader(
            header: Container(
              height: 50.0,
              color: Colors.blueGrey.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
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
                                            ? OperatorModel.specialist
                                            : OperatorModel.supporter,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
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
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
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
                  color: globals.classedOperators[classIdx][index].rare == "6"
                      ? Colors.white
                      : globals.classedOperators[classIdx][index].rare == "5"
                          ? Colors.yellow.shade700
                          : Colors.grey.shade800,
                ),
              ),
              Image.asset(
                'assets/images/operators/${globals.classedOperators[classIdx][index].imageName}.png',
                width: 50,
                height: 50,
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
        );
      },
      itemCount: globals.classedOperators[classIdx].length,
    );
  }
}
