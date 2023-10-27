import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_event.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/constants/font_family.dart';
import 'package:arkhive/screens/enemy/widgets/enemy_filters_button.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemySliverAppBar extends StatefulWidget {
  const EnemySliverAppBar({super.key});

  @override
  State<EnemySliverAppBar> createState() => _EnemySliverAppBarState();
}

class _EnemySliverAppBarState extends State<EnemySliverAppBar> {
  late TextEditingController _searchController;
  final FocusNode _searchFocus = FocusNode();
  bool _onSearch = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTap() {
    setState(() {
      _onSearch = !_onSearch;
    });
    if (_onSearch) {
      _searchFocus.requestFocus();
    }
  }

  void _onTapOutside(PointerDownEvent _) {
    FocusScope.of(context).unfocus();
    setState(() {
      _onSearch = false;
    });
  }

  void _onSearchChange(String? string) {
    context
        .read<EnemyListBloc>()
        .add(EnemyListSearchEvent(searchQuery: string ?? ''));
  }

  void _onDeleteTap() {
    _searchController.clear();
    context
        .read<EnemyListBloc>()
        .add(const EnemyListSearchEvent(searchQuery: ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnemyListBloc, EnemyListState>(
      builder: (context, state) => SliverAppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const EnemyFiltersButton(),
            IconButton(
              onPressed: !_onSearch ? _onSearchTap : null,
              icon: Icon(
                Icons.search_rounded,
                color: _onSearch ? Colors.yellow.shade800 : Colors.white,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: _onSearch
                    ? TextField(
                        controller: _searchController,
                        onChanged: _onSearchChange,
                        onTapOutside: _onTapOutside,
                        focusNode: _searchFocus,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.yellow.shade800,
                        decoration: InputDecoration(
                          labelText: '검색',
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
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (state.searchQuery?.isNotEmpty == true)
                              Row(
                                children: [
                                  _tag(
                                    "검색: ${state.searchQuery!}",
                                    isSearch: true,
                                  ),
                                  Gaps.h5,
                                ],
                              ),
                            if (state.enemyList == null ||
                                state.enemyList!.isEmpty)
                              SizedBox(
                                width: Sizes.size20,
                                height: Sizes.size20,
                                child: CircularProgressIndicator(
                                  color: Colors.yellow.shade800,
                                ),
                              )
                            else
                              _tag(
                                state.searchQuery?.isNotEmpty == true
                                    ? "필터 해제"
                                    : state.selectedFilterOption
                                                ?.any((element) => element) ==
                                            true
                                        ? "필터 적용"
                                        : "필터 없음",
                              ),
                            if (state is EnemyListLoadedState)
                              Row(
                                children: [
                                  Gaps.h5,
                                  _tag(
                                      "${state.filteredEnemyList.length}명 검색됨"),
                                ],
                              ),
                          ],
                        ),
                      ),
              ),
            ),
            Gaps.h10,
          ],
        ),
        elevation: Sizes.size3,
        forceElevated: true,
        backgroundColor: Colors.blueGrey.shade700,
        centerTitle: false,
        pinned: true,
      ),
    );
  }

  Widget _tag(String text, {bool isSearch = false}) {
    if (isSearch) {
      return GestureDetector(
        onTap: _onDeleteTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size2,
            horizontal: Sizes.size5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Sizes.size5),
          ),
          child: Row(
            children: [
              AppFont(
                text,
                color: Colors.blueGrey.shade700,
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w700,
              ),
              Gaps.h5,
              Icon(
                Icons.cancel,
                size: Sizes.size16,
                color: Colors.blueGrey.shade700,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size2,
        horizontal: Sizes.size5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size5),
      ),
      child: AppFont(
        text,
        color: Colors.blueGrey.shade700,
        fontSize: Sizes.size14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
