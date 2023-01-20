import 'dart:convert';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/models/screens_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() => _instance;

  GlobalData._internal() {
    globalDataInitializer();
  }
  // global variables
  late String screen;
  late List<List<OperatorModel>> _classedOperators;
  late List<EnemyModel> _enemies;

  // getter
  List<List<OperatorModel>> get classedOperators => _classedOperators;
  List<EnemyModel> get enemies => _enemies;

  // initializer
  void globalDataInitializer() async {
    screen = ScreenModel.main;
    List<List<OperatorModel>> classedOperators_ = [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    ];
    List<EnemyModel> enemies_ = [];
    // operators
    final prefs = await SharedPreferences.getInstance();
    final String? operatorStringData = prefs.getString('operator_data');
    if (operatorStringData != null) {
      var data = await json.decode(operatorStringData)['data'];
      for (var jsonData in data) {
        OperatorModel operator_ = OperatorModel.fromJson(jsonData);
        if (operator_.class_ == OperatorPositions.vanguard) {
          classedOperators_[0].add(operator_);
        }
        if (operator_.class_ == OperatorPositions.guard) {
          classedOperators_[1].add(operator_);
        }
        if (operator_.class_ == OperatorPositions.defender) {
          classedOperators_[2].add(operator_);
        }
        if (operator_.class_ == OperatorPositions.sniper) {
          classedOperators_[3].add(operator_);
        }
        if (operator_.class_ == OperatorPositions.caster) {
          classedOperators_[4].add(operator_);
        }
        if (operator_.class_ == OperatorPositions.medic) {
          classedOperators_[5].add(operator_);
        }
        if (operator_.class_ == OperatorPositions.supporter) {
          classedOperators_[6].add(operator_);
        }
        if (operator_.class_ == OperatorPositions.specialist) {
          classedOperators_[7].add(operator_);
        }
      }
    }
    _classedOperators = classedOperators_;

    // enemies
    var res = await rootBundle.loadString('assets/json/data_enemy.json');
    var data = await json.decode(res)['data'];

    for (var jsonData in data) {
      enemies_.add(EnemyModel.fromJson(jsonData));
    }
    _enemies = enemies_;
  }
}
