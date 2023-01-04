import 'package:Arkhive/models/font_family.dart';
import 'package:Arkhive/models/operator_model.dart';
import 'package:Arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../global_vars.dart' as globals;

class OperatorScreen extends StatefulWidget {
  const OperatorScreen({super.key});

  @override
  State<OperatorScreen> createState() => _OperatorScreenState();
}

late List<List<OperatorModel>> classedOperators;

class _OperatorScreenState extends State<OperatorScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    classedOperators = [
      [], // vanguards
      [], // snipers
      [], // guards
      [], // casters
      [], // defenders
      [], // medics
      [], // specialists
      [], // supporters
    ];
    for (var operator_ in globals.operators) {
      if (operator_.class_ == OperatorModel.vanguard) {
        classedOperators[0].add(operator_);
      }
      if (operator_.class_ == OperatorModel.sniper) {
        classedOperators[1].add(operator_);
      }
      if (operator_.class_ == OperatorModel.guard) {
        classedOperators[2].add(operator_);
      }
      if (operator_.class_ == OperatorModel.caster) {
        classedOperators[3].add(operator_);
      }
      if (operator_.class_ == OperatorModel.defender) {
        classedOperators[4].add(operator_);
      }
      if (operator_.class_ == OperatorModel.medic) {
        classedOperators[5].add(operator_);
      }
      if (operator_.class_ == OperatorModel.specialist) {
        classedOperators[6].add(operator_);
      }
      if (operator_.class_ == OperatorModel.supporter) {
        classedOperators[7].add(operator_);
      }
    }
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
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return StickyHeader(
            header: Container(
              height: 50.0,
              color: Colors.blueGrey[700],
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
                style: const TextStyle(color: Colors.white),
              ),
            ),
            content: ClassListView(
              classIdx: index,
            ),
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
        return Row(
          children: [
            Text(classedOperators[classIdx][index].name),
          ],
        );
      },
      itemCount: classedOperators[classIdx].length,
    );
  }
}
