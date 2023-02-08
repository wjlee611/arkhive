import 'dart:convert';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/item_model.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/models/screens_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() => _instance;

  GlobalData._internal() {
    globalDataInitializer();
  }
  // global variables
  late String screen;
  String? oldVer, newVer;
  late List<List<OperatorModel>> _classedOperators;
  late List<EnemyModel> _enemies;
  late List<ItemModel> _items;

  // getter
  List<List<OperatorModel>> get classedOperators => _classedOperators;
  List<EnemyModel> get enemies => _enemies;
  List<ItemModel> get items => _items;

  // initializer
  Future<void> globalDataInitializer() async {
    // final prefs = await SharedPreferences.getInstance();
    const storage = FlutterSecureStorage();

    screen = ScreenModel.main;
    // oldVer = prefs.getString('update_checker');
    oldVer = await storage.read(key: 'update_checker');
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
    List<ItemModel> items_ = [];
    // operators
    // String? stringData = prefs.getString('operator_data');
    String? stringData = await storage.read(key: 'operator_data');
    if (stringData != null) {
      var data = await json.decode(stringData)['data'];
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

    stringData = null;
    // enemies
    // stringData = prefs.getString('enemy_data');
    stringData = await storage.read(key: 'enemy_data');
    if (stringData != null) {
      var data = await json.decode(stringData)['data'];
      for (var jsonData in data) {
        enemies_.add(EnemyModel.fromJson(jsonData));
      }
    }
    _enemies = enemies_;

    stringData = null;
    // items
    // stringData = prefs.getString('item_data');
    stringData = await storage.read(key: 'item_data');
    if (stringData != null) {
      var data = await json.decode(stringData)['data'];
      for (var jsonData in data) {
        items_.add(ItemModel.fromJson(jsonData));
      }
    }
    _items = items_;
  }
}
