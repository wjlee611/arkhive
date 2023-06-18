import 'dart:convert';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/screens/enemy/widgets/enemy_button_widget.dart';
import 'package:arkhive/screens/enemy/widgets/enemy_sliver_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum FilterOptions {
  normal,
  elite,
  boss,
}

class EnemyScreen extends StatefulWidget {
  const EnemyScreen({super.key});

  @override
  State<EnemyScreen> createState() => _EnemyScreenState();
}

class _EnemyScreenState extends State<EnemyScreen> {
  final _searchController = TextEditingController();
  late Future<List<EnemyModel>> _futureEnemies;
  bool _isLoading = false;
  List<bool> _filter = [
    true, // normal
    true, // elite
    true, // boss
  ];
  String _searchKeyword = "";

  @override
  void initState() {
    super.initState();
    _futureEnemies = futureEnemies();
  }

  Future<List<EnemyModel>> futureEnemies() async {
    setState(() {
      _isLoading = true;
    });

    const storage = FlutterSecureStorage();
    List<EnemyModel> result = [];

    String? enemyListString = await storage.read(key: 'list_enemy');
    if (enemyListString != null && enemyListString != 'null') {
      var enemyListData = await json.decode(enemyListString)['data'];
      for (var enemy in enemyListData) {
        String? enemyString = await storage.read(key: 'enemy/$enemy');
        if (enemyString != null && enemyString != 'null') {
          var enemyJsonData = await json.decode(enemyString);
          var enemyData = EnemyModel.fromJson(enemyJsonData);
          if (enemyData.hideInHandbook == true) continue;
          result.add(enemyData);
        }
      }
    }

    setState(() {
      _isLoading = false;
    });

    return result;
  }

  List<EnemyModel> _runFilter(List<EnemyModel> list) {
    List<EnemyModel> result = [];

    if (_searchKeyword.isEmpty) {
      for (var enemy in list) {
        // filter
        if (_filter[0] && enemy.enemyLevel == 'NORMAL') {
          result.add(enemy);
          continue;
        }
        if (_filter[1] && enemy.enemyLevel == 'ELITE') {
          result.add(enemy);
          continue;
        }
        if (_filter[2] && enemy.enemyLevel == 'BOSS') {
          result.add(enemy);
          continue;
        }
      }
    } else {
      // search
      result = list
          .where((op) =>
              op.name!.toLowerCase().contains(_searchKeyword.toLowerCase()))
          .toList();
    }

    return result;
  }

  void _onFilterChange(List<bool> list) {
    setState(() {
      _filter = list;
    });
  }

  void _onSearchChange(String? value) {
    setState(() {
      _searchKeyword = value ?? '';
    });
  }

  void _onDeleteTap() {
    setState(() {
      _searchController.text = '';
      _searchKeyword = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          EnemySliverAppBar(
            isLoading: _isLoading,
            onFilterChange: _onFilterChange,
            onSearchChange: _onSearchChange,
            onDeleteTap: _onDeleteTap,
            searchController: _searchController,
          ),
          SliverFillRemaining(
            child: FutureBuilder(
              future: _futureEnemies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var filteredList = _runFilter(snapshot.data!);
                  return CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(Sizes.size20),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: Sizes.size96,
                            mainAxisSpacing: Sizes.size5,
                            crossAxisSpacing: Sizes.size5,
                            childAspectRatio: 1,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return EnemyButton(enemy: filteredList[index]);
                            },
                            childCount: filteredList.length,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Image.asset(
                      'assets/images/prts.png',
                      color: Colors.grey.shade400,
                      width: Sizes.size60,
                      height: Sizes.size60,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
