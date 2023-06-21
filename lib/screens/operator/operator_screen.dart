import 'dart:convert';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/widgets/operator_bottom_appbar_widget.dart';
import 'package:arkhive/screens/operator/widgets/operator_listitem_widget.dart';
import 'package:arkhive/screens/operator/widgets/operator_sliver_appbar_widget.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum SortOptions {
  starUp,
  starDown,
  nameUp,
  nameDown,
}

enum Professions {
  all,
  vanguard,
  guard,
  defender,
  sniper,
  caster,
  medic,
  supporter,
  specialist,
  perparation
}

class OperatorScreen extends StatefulWidget {
  const OperatorScreen({super.key});

  @override
  State<OperatorScreen> createState() => _OperatorScreenState();
}

class _OperatorScreenState extends State<OperatorScreen> {
  final _searchController = TextEditingController();
  late Future<List<OperatorModel>> _futureOperators;
  SortOptions _sortOption = SortOptions.starUp;
  Professions _selectedProfession = Professions.all;
  bool _isLoading = false;
  String _searchKeyword = "";

  @override
  void initState() {
    super.initState();
    _futureOperators = futureOperators();
  }

  Future<List<OperatorModel>> futureOperators() async {
    setState(() {
      _isLoading = true;
    });

    List<OperatorModel> result = [];
    String jsonString = await rootBundle
        .loadString('${getGameDataRoot()}excel/character_table.json');
    Map<String, dynamic> jsonData = await json.decode(jsonString);

    for (var operatorData in jsonData.entries) {
      // 오직 캐릭터만
      if (!operatorData.key.startsWith('char_')) continue;
      // 샬렘 중복 제외
      if (operatorData.key == 'char_512_aprot') continue;

      result.add(OperatorModel.fromJson(operatorData.value));
    }

    setState(() {
      _isLoading = false;
    });

    return result;
  }

  List<OperatorModel> _runFilter(List<OperatorModel> list) {
    List<OperatorModel> result = [];

    if (_searchKeyword.isEmpty) {
      // filter
      for (var op in list) {
        if (_selectedProfession == Professions.all) {
          result.add(op);
          continue;
        }
        if (_selectedProfession == Professions.vanguard &&
            op.profession == "PIONEER") {
          result.add(op);
          continue;
        }
        if (_selectedProfession == Professions.guard &&
            op.profession == "WARRIOR") {
          result.add(op);
          continue;
        }
        if (_selectedProfession == Professions.defender &&
            op.profession == "TANK") {
          result.add(op);
          continue;
        }
        if (_selectedProfession == Professions.sniper &&
            op.profession == "SNIPER") {
          result.add(op);
          continue;
        }
        if (_selectedProfession == Professions.caster &&
            op.profession == "CASTER") {
          result.add(op);
          continue;
        }
        if (_selectedProfession == Professions.medic &&
            op.profession == "MEDIC") {
          result.add(op);
          continue;
        }
        if (_selectedProfession == Professions.supporter &&
            op.profession == "SUPPORT") {
          result.add(op);
          continue;
        }
        if (_selectedProfession == Professions.specialist &&
            op.profession == "SPECIAL") {
          result.add(op);
          continue;
        }
        if (_selectedProfession == Professions.perparation &&
            op.isNotObtainable == true) {
          result.add(op);
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

    // sort
    if (_sortOption == SortOptions.starUp) {
      result.sort(
        (a, b) => a.rarity!.compareTo(b.rarity!),
      );
    } else if (_sortOption == SortOptions.starDown) {
      result.sort(
        (a, b) => b.rarity!.compareTo(a.rarity!),
      );
    } else if (_sortOption == SortOptions.nameUp) {
      result.sort(
        (a, b) => a.name!.compareTo(b.name!),
      );
    } else if (_sortOption == SortOptions.nameDown) {
      result.sort(
        (a, b) => b.name!.compareTo(a.name!),
      );
    }

    return result;
  }

  void _onSortSelected(SortOptions selected) {
    if (_sortOption == selected) return;

    setState(() {
      _sortOption = selected;
    });
  }

  void _onProfessionTap(Professions profession) {
    if (_selectedProfession == profession) return;

    setState(() {
      _selectedProfession = profession;
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: Sizes.size3,
            ),
          ],
        ),
        child: OperatorBottomAppBar(
          onProfessionTap: _onProfessionTap,
          selectedProfession: _selectedProfession,
          searchKeyword: _searchKeyword,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          OperatorSliverAppBar(
            isLoading: _isLoading,
            sortOption: _sortOption,
            onSortSelected: _onSortSelected,
            onSearchChange: _onSearchChange,
            onDeleteTap: _onDeleteTap,
            searchController: _searchController,
          ),
          SliverFillRemaining(
            child: FutureBuilder(
              future: _futureOperators,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var filteredList = _runFilter(snapshot.data!);
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => GestureDetector(
                            onTap: () => OpenDetailScreen.onOperatorTab(
                              context: context,
                              operatorKey: filteredList[index]
                                  .phases
                                  .first
                                  .characterPrefabKey!,
                            ),
                            child: OperatorListItem(
                              operator_: filteredList[index],
                              index: index,
                            ),
                          ),
                          childCount: filteredList.length,
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
