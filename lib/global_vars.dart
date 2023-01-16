library global;

import 'dart:convert';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/models/screens_model.dart';
import 'package:flutter/services.dart';

// global variables
String screen = ScreenModel.main;
List<List<OperatorModel>> classedOperators = [
  [], // 0: vanguards
  [], // 1: snipers
  [], // 2: guards
  [], // 3: casters
  [], // 4: defenders
  [], // 5: medics
  [], // 6: specialists
  [], // 7: supporters
];
List<EnemyModel> enemies = [];

// initializer
Future<void> globalDataInitializer() async {
  // operators
  String res = await rootBundle.loadString('assets/json/data_operator.json');
  var data = await json.decode(res)['data'];

  for (var jsonData in data) {
    OperatorModel operator_ = OperatorModel.fromJson(jsonData);
    if (operator_.class_ == OperatorPositions.vanguard) {
      classedOperators[0].add(operator_);
    }
    if (operator_.class_ == OperatorPositions.guard) {
      classedOperators[1].add(operator_);
    }
    if (operator_.class_ == OperatorPositions.defender) {
      classedOperators[2].add(operator_);
    }
    if (operator_.class_ == OperatorPositions.sniper) {
      classedOperators[3].add(operator_);
    }
    if (operator_.class_ == OperatorPositions.caster) {
      classedOperators[4].add(operator_);
    }
    if (operator_.class_ == OperatorPositions.medic) {
      classedOperators[5].add(operator_);
    }
    if (operator_.class_ == OperatorPositions.supporter) {
      classedOperators[6].add(operator_);
    }
    if (operator_.class_ == OperatorPositions.specialist) {
      classedOperators[7].add(operator_);
    }
  }

  // enemies
  res = await rootBundle.loadString('assets/json/data_enemy.json');
  data = await json.decode(res)['data'];

  for (var jsonData in data) {
    enemies.add(EnemyModel.fromJson(jsonData));
  }
}
