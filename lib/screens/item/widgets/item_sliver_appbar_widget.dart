import 'package:arkhive/bloc/item/item_list/item_list_bloc.dart';
import 'package:arkhive/bloc/item/item_list/item_list_event.dart';
import 'package:arkhive/bloc/item/item_list/item_list_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/constants/font_family.dart';
import 'package:arkhive/screens/item/widgets/item_filters_button.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemSliverAppBar extends StatefulWidget {
  const ItemSliverAppBar({super.key});

  @override
  State<ItemSliverAppBar> createState() => _ItemSliverAppBarState();
}

class _ItemSliverAppBarState extends State<ItemSliverAppBar> {
  late TextEditingController _searchController;
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
  }

  void _onTapOutside(PointerDownEvent _) {
    FocusScope.of(context).unfocus();
    setState(() {
      _onSearch = false;
    });
  }

  void _onSearchChange(String? string) {
    context
        .read<ItemListBloc>()
        .add(ItemListSearchEvent(searchQuery: string ?? ''));
  }

  void _onDeleteTap() {
    _searchController.clear();
    context
        .read<ItemListBloc>()
        .add(const ItemListSearchEvent(searchQuery: ''));
  }

  String _filterOptionToString(ItemListFilterOptions? option) {
    if (option == null) {
      return '';
    }
    switch (option) {
      case ItemListFilterOptions.all:
        return '전체';
      case ItemListFilterOptions.normal:
        return '일반';
      case ItemListFilterOptions.consume:
        return '사용';
      case ItemListFilterOptions.material:
        return '육성 재료';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemListBloc, ItemListState>(
      builder: (context, state) => SliverAppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const ItemFiltersButton(),
            IconButton(
              onPressed: _onSearchTap,
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
                            if (state.itemList == null ||
                                state.itemList!.isEmpty)
                              SizedBox(
                                width: Sizes.size20,
                                height: Sizes.size20,
                                child: CircularProgressIndicator(
                                  color: Colors.yellow.shade800,
                                ),
                              )
                            else
                              _tag(
                                _filterOptionToString(
                                    state.selectedFilterOption),
                              ),
                            if (state is ItemListLoadedState)
                              Row(
                                children: [
                                  Gaps.h5,
                                  _tag(
                                      "${state.filteredItemList.length}항목 검색됨"),
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
