import 'dart:convert';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './global_vars.dart' as globals;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Loading data
  Future<void> readOperatorJson() async {
    final String res =
        await rootBundle.loadString('assets/json/data_operator.json');
    final data = await json.decode(res)['data'];

    for (var jsonData in data) {
      OperatorModel operator_ = OperatorModel.fromJson(jsonData);
      if (operator_.class_ == OperatorPositions.vanguard) {
        globals.classedOperators[0].add(operator_);
      }
      if (operator_.class_ == OperatorPositions.guard) {
        globals.classedOperators[1].add(operator_);
      }
      if (operator_.class_ == OperatorPositions.defender) {
        globals.classedOperators[2].add(operator_);
      }
      if (operator_.class_ == OperatorPositions.sniper) {
        globals.classedOperators[3].add(operator_);
      }
      if (operator_.class_ == OperatorPositions.caster) {
        globals.classedOperators[4].add(operator_);
      }
      if (operator_.class_ == OperatorPositions.medic) {
        globals.classedOperators[5].add(operator_);
      }
      if (operator_.class_ == OperatorPositions.supporter) {
        globals.classedOperators[6].add(operator_);
      }
      if (operator_.class_ == OperatorPositions.specialist) {
        globals.classedOperators[7].add(operator_);
      }
    }
  }

  Future<void> readEnemyJson() async {
    final String res =
        await rootBundle.loadString('assets/json/data_enemy.json');
    final data = await json.decode(res)['data'];

    for (var jsonData in data) {
      globals.enemies.add(EnemyModel.fromJson(jsonData));
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (globals.classedOperators[0].isEmpty) {
      readOperatorJson();
    }
    if (globals.enemies.isEmpty) {
      readEnemyJson();
    }

    return const MaterialApp(
      title: 'Arkhive',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
