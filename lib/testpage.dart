import 'dart:convert';

import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/models/skill_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestPageScreen extends StatefulWidget {
  const TestPageScreen({super.key});

  @override
  State<TestPageScreen> createState() => _TestPageScreenState();
}

class _TestPageScreenState extends State<TestPageScreen> {
  OperatorModel? skadi;
  List<SkillModel> skadiSkills = [];

  Future<void> loadJsonData() async {
    String data =
        await rootBundle.loadString('assets/json/operator/char_263_skadi.json');
    Map<String, dynamic> jsonData = json.decode(data);

    setState(() {
      skadi = OperatorModel.fromJson(jsonData['data']);
    });

    for (var skill in skadi!.skills) {
      data = await rootBundle
          .loadString('assets/json/skill/${skill.skillId}.json');
      jsonData = json.decode(data);

      setState(() {
        skadiSkills.add(SkillModel.fromJson(jsonData['data']));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: skadi != null
            ? Column(
                children: [
                  Text(skadi!.name),
                  for (var skill in skadiSkills) Text(skill.levels[0].name),
                ],
              )
            : const Text('no data'),
      ),
    );
  }
}
