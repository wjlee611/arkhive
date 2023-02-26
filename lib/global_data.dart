import 'dart:convert';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/item_model.dart';
import 'package:arkhive/models/screens_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() => _instance;

  GlobalData._internal() {
    globalDataInitializer();
  }
  // global variables
  static const String appVersion = "1.0.0";
  late String screen;
  late String oldVer;
  String? newVer = "0";
  late List<EnemyModel> _enemies;
  late List<ItemModel> _items;

  // getter
  List<EnemyModel> get enemies => _enemies;
  List<ItemModel> get items => _items;

  // initializer
  Future<void> globalDataInitializer() async {
    const storage = FlutterSecureStorage();

    screen = ScreenModel.main;
    oldVer = await storage.read(key: 'update_checker') ?? "업데이트 필요!";
    List<EnemyModel> enemies_ = [];
    List<ItemModel> items_ = [];
    // enemies
    String? stringData = await storage.read(key: 'enemy_data');
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
