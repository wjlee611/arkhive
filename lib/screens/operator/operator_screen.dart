import 'dart:convert';

import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/update/update_screen.dart';
import 'package:arkhive/tools/willpop_function.dart';
// import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SortOptions { starUp, starDown, nameUp, nameDown }

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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();
  late Future<List<OperatorModel>> _futureOperators;
  SortOptions _sortOption = SortOptions.starUp;
  Professions _selectedProfession = Professions.all;
  bool _isSorting = false;
  bool _onSearch = false;
  String _searchKeyword = "";

  @override
  void initState() {
    super.initState();
    _futureOperators = futureOperators();
  }

  Future<List<OperatorModel>> futureOperators() async {
    setState(() {
      _isSorting = true;
    });

    const storage = FlutterSecureStorage();
    List<OperatorModel> result = [];

    String? operatorListString = await storage.read(key: 'list_operator');
    if (operatorListString != null) {
      var operatorListData = await json.decode(operatorListString)['data'];
      for (var operator_ in operatorListData) {
        String? operatorString = await storage.read(key: 'operator/$operator_');
        if (operatorString != null) {
          var operatorData = await json.decode(operatorString)['data'];
          result.add(OperatorModel.fromJson(operatorData));
        }
      }
    }

    setState(() {
      _isSorting = false;
    });

    return result;
  }

  void _openUpdater() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UpdateScreen(),
      ),
    ).then((_) => setState(() {}));
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
              op.name.toLowerCase().contains(_searchKeyword.toLowerCase()))
          .toList();
    }

    // sort
    if (_sortOption == SortOptions.starUp) {
      result.sort(
        (a, b) => a.rarity.compareTo(b.rarity),
      );
    } else if (_sortOption == SortOptions.starDown) {
      result.sort(
        (a, b) => b.rarity.compareTo(a.rarity),
      );
    } else if (_sortOption == SortOptions.nameUp) {
      result.sort(
        (a, b) => a.name.compareTo(b.name),
      );
    } else if (_sortOption == SortOptions.nameDown) {
      result.sort(
        (a, b) => b.name.compareTo(a.name),
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

  void _onSearchTap() {
    setState(() {
      _onSearch = !_onSearch;
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

  void _onTapOutside(PointerDownEvent _) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: _searchKeyword.isEmpty ? true : false,
        title: _onSearch
            ? TextField(
                controller: _searchController,
                onChanged: _onSearchChange,
                onTapOutside: _onTapOutside,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamily.nanumGothic,
                  ),
                  suffixIconColor: Colors.white,
                  suffixIcon: GestureDetector(
                    onTap: _onDeleteTap,
                    child: const Icon(Icons.cancel_rounded),
                  ),
                ),
              )
            : Text(
                _searchKeyword.isEmpty ? '오퍼레이터' : '검색결과: $_searchKeyword',
                style: const TextStyle(
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                ),
              ),
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: _openUpdater,
            icon: const Icon(Icons.update),
          ),
        ],
        // leading: IconButton(
        //   icon: const Icon(Icons.sort),
        //   onPressed: () => scaffoldKey.currentState!.openDrawer(),
        // ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey.shade700,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
            child: Row(
              children: [
                ProfessionButton(
                  onTap: () => _onProfessionTap(Professions.all),
                  profession: Professions.all,
                  isSelected: _selectedProfession == Professions.all,
                ),
                ProfessionButton(
                  onTap: () => _onProfessionTap(Professions.vanguard),
                  profession: Professions.vanguard,
                  isSelected: _selectedProfession == Professions.vanguard,
                ),
                ProfessionButton(
                  onTap: () => _onProfessionTap(Professions.guard),
                  profession: Professions.guard,
                  isSelected: _selectedProfession == Professions.guard,
                ),
                ProfessionButton(
                  onTap: () => _onProfessionTap(Professions.defender),
                  profession: Professions.defender,
                  isSelected: _selectedProfession == Professions.defender,
                ),
                ProfessionButton(
                  onTap: () => _onProfessionTap(Professions.sniper),
                  profession: Professions.sniper,
                  isSelected: _selectedProfession == Professions.sniper,
                ),
                ProfessionButton(
                  onTap: () => _onProfessionTap(Professions.caster),
                  profession: Professions.caster,
                  isSelected: _selectedProfession == Professions.caster,
                ),
                ProfessionButton(
                  onTap: () => _onProfessionTap(Professions.medic),
                  profession: Professions.medic,
                  isSelected: _selectedProfession == Professions.medic,
                ),
                ProfessionButton(
                  onTap: () => _onProfessionTap(Professions.supporter),
                  profession: Professions.supporter,
                  isSelected: _selectedProfession == Professions.supporter,
                ),
                ProfessionButton(
                  onTap: () => _onProfessionTap(Professions.specialist),
                  profession: Professions.specialist,
                  isSelected: _selectedProfession == Professions.specialist,
                ),
                ProfessionButton(
                  onTap: () => _onProfessionTap(Professions.perparation),
                  profession: Professions.perparation,
                  isSelected: _selectedProfession == Professions.perparation,
                ),
              ],
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => WillPopFunction.onWillPop(context: context),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                children: [
                  SortButton(
                    initialValue: _sortOption,
                    onSelected: _onSortSelected,
                  ),
                  if (_isSorting)
                    SizedBox(
                      width: Sizes.size48,
                      height: Sizes.size20,
                      child: Center(
                        child: SizedBox(
                          width: Sizes.size20,
                          height: Sizes.size20,
                          child: CircularProgressIndicator(
                            color: Colors.yellow.shade800,
                          ),
                        ),
                      ),
                    )
                  else
                    IconButton(
                      onPressed: _onSearchTap,
                      icon: Icon(
                        Icons.search_rounded,
                        color:
                            _onSearch ? Colors.yellow.shade800 : Colors.white,
                      ),
                    ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _sortOption == SortOptions.starUp
                            ? '//  레어도 오름차순'
                            : _sortOption == SortOptions.starDown
                                ? '//  레어도 내림차순'
                                : _sortOption == SortOptions.nameUp
                                    ? '//  이름 오름차순'
                                    : "//  이름 내림차순",
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                          fontFamily: FontFamily.nanumGothic,
                        ),
                      ),
                    ),
                  ),
                  Gaps.h10,
                ],
              ),
              backgroundColor: Colors.blueGrey.shade700,
              centerTitle: false,
              pinned: true,
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
                            (context, index) => Text(
                                '${index + 1}. ${filteredList[index].rarity + 1}star ${filteredList[index].name}'),
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
      ),
      // drawer: const NavDrawer(),
    );
  }
}

class ProfessionButton extends StatelessWidget {
  const ProfessionButton({
    super.key,
    required this.onTap,
    required this.profession,
    required this.isSelected,
  });

  final Function() onTap;
  final Professions profession;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: profession == Professions.all
          ? SizedBox(
              width: Sizes.size48,
              height: Sizes.size48,
              child: Center(
                child: Text(
                  "전체",
                  style: TextStyle(
                    color: isSelected ? Colors.yellow.shade800 : Colors.white,
                    fontFamily: FontFamily.nanumGothic,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          : profession == Professions.perparation
              ? SizedBox(
                  width: Sizes.size48,
                  height: Sizes.size48,
                  child: Center(
                    child: Text(
                      "예비",
                      style: TextStyle(
                        color:
                            isSelected ? Colors.yellow.shade800 : Colors.white,
                        fontFamily: FontFamily.nanumGothic,
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  width: Sizes.size48,
                  height: Sizes.size48,
                  child: Center(
                    child: Image.asset(
                      profession == Professions.vanguard
                          ? 'assets/images/class_vanguard.png'
                          : profession == Professions.guard
                              ? 'assets/images/class_guard.png'
                              : profession == Professions.defender
                                  ? 'assets/images/class_defender.png'
                                  : profession == Professions.sniper
                                      ? 'assets/images/class_sniper.png'
                                      : profession == Professions.caster
                                          ? 'assets/images/class_caster.png'
                                          : profession == Professions.medic
                                              ? 'assets/images/class_medic.png'
                                              : profession ==
                                                      Professions.supporter
                                                  ? 'assets/images/class_supporter.png'
                                                  : 'assets/images/class_specialist.png',
                      width: Sizes.size32,
                      height: Sizes.size32,
                      color: isSelected ? Colors.yellow.shade800 : Colors.white,
                    ),
                  ),
                ),
    );
  }
}

class SortButton extends StatelessWidget {
  const SortButton({
    super.key,
    required this.initialValue,
    required this.onSelected,
  });

  final SortOptions initialValue;
  final Function(SortOptions) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: initialValue,
      onSelected: onSelected,
      offset: const Offset(0, 0),
      icon: Icon(
        Icons.filter_alt_rounded,
        color: Colors.yellow.shade800,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: Sizes.size5,
          color: Colors.blueGrey.shade700,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.size10)),
      ),
      elevation: 0,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: SortOptions.starUp,
          child: Text(
            '레어도 오름차순',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const PopupMenuItem(
          value: SortOptions.starDown,
          child: Text(
            '레어도 내림차순',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const PopupMenuItem(
          value: SortOptions.nameUp,
          child: Text(
            '이름 오름차순',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const PopupMenuItem(
          value: SortOptions.nameDown,
          child: Text(
            '이름 내림차순',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
