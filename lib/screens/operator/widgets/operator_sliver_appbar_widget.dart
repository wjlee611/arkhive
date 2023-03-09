import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/operator/operator_screen.dart';
import 'package:arkhive/screens/operator/widgets/operator_sort_button.dart';
import 'package:flutter/material.dart';

class OperatorSliverAppBar extends StatefulWidget {
  const OperatorSliverAppBar({
    super.key,
    required this.isLoading,
    required this.sortOption,
    required this.onSortSelected,
    required this.onSearchChange,
    required this.onDeleteTap,
    required this.searchController,
  });

  final bool isLoading;
  final SortOptions sortOption;
  final Function(SortOptions) onSortSelected;
  final Function(String?) onSearchChange;
  final Function() onDeleteTap;
  final TextEditingController searchController;

  @override
  State<OperatorSliverAppBar> createState() => _OperatorSliverAppBarState();
}

class _OperatorSliverAppBarState extends State<OperatorSliverAppBar> {
  bool _onSearch = false;
  String searchString = '';

  void _onSearchTap() {
    setState(() {
      _onSearch = !_onSearch;
    });
  }

  void _onTapOutside(PointerDownEvent _) {
    FocusScope.of(context).unfocus();
  }

  void _onSearchChange(String? string) {
    searchString = string ?? '';
    widget.onSearchChange(string);
  }

  void _onDeleteTap() {
    searchString = '';
    widget.onDeleteTap();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          SortButton(
            initialValue: widget.sortOption,
            onSelected: widget.onSortSelected,
          ),
          if (widget.isLoading)
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
                color: _onSearch ? Colors.yellow.shade800 : Colors.white,
              ),
            ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _onSearch
                  ? TextField(
                      controller: widget.searchController,
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
                          if (searchString.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size2,
                                horizontal: Sizes.size5,
                              ),
                              margin: const EdgeInsets.only(right: Sizes.size5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(Sizes.size5),
                              ),
                              child: Text(
                                searchString,
                                style: TextStyle(
                                  fontFamily: FontFamily.nanumGothic,
                                  fontSize: Sizes.size14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blueGrey.shade700,
                                ),
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.size2,
                              horizontal: Sizes.size5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(Sizes.size5),
                            ),
                            child: Text(
                              widget.sortOption == SortOptions.starUp
                                  ? '레어도 오름차순'
                                  : widget.sortOption == SortOptions.starDown
                                      ? '레어도 내림차순'
                                      : widget.sortOption == SortOptions.nameUp
                                          ? '이름 오름차순'
                                          : '이름 내림차순',
                              style: TextStyle(
                                fontFamily: FontFamily.nanumGothic,
                                fontSize: Sizes.size14,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
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
    );
  }
}
