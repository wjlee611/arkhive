import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class EnemySliverAppBar extends StatefulWidget {
  const EnemySliverAppBar({
    super.key,
    required this.isLoading,
    required this.onFilterChange,
    required this.onSearchChange,
    required this.onDeleteTap,
    required this.searchController,
  });

  final bool isLoading;
  final Function(List<bool>) onFilterChange;
  final Function(String?) onSearchChange;
  final Function() onDeleteTap;
  final TextEditingController searchController;

  @override
  State<EnemySliverAppBar> createState() => _OperatorSliverAppBarState();
}

class _OperatorSliverAppBarState extends State<EnemySliverAppBar> {
  bool _onSearch = false;
  final List<bool> _isChecked = [
    true, // normal
    true, // elite
    true, // boss
  ];
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

  void _onFilterChange({
    required int index,
    required bool? value,
    required Function(void Function()) setState,
  }) {
    setState(() {
      _isChecked[index] = value ?? false;
    });
    widget.onFilterChange(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          PopupMenuButton(
            offset: const Offset(0, 0),
            icon: Icon(
              Icons.filter_alt_rounded,
              color: _isChecked.any((element) => element)
                  ? Colors.yellow.shade800
                  : Colors.white,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: Sizes.size5,
                color: Colors.blueGrey.shade700,
              ),
              borderRadius:
                  const BorderRadius.all(Radius.circular(Sizes.size10)),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: StatefulBuilder(
                  builder: (context, setState) => Column(
                    children: [
                      for (int i = 0; i < 3; i++)
                        CheckboxListTile(
                          value: _isChecked[i],
                          title: Text(
                            i == 0
                                ? '일반'
                                : i == 1
                                    ? '정예'
                                    : '보스',
                            style: const TextStyle(
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                          onChanged: (value) => _onFilterChange(
                            index: i,
                            value: value,
                            setState: setState,
                          ),
                          activeColor: Colors.yellow.shade800,
                        ),
                    ],
                  ),
                ),
              ),
            ],
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
                          // Container(
                          //   padding: const EdgeInsets.symmetric(
                          //     vertical: Sizes.size2,
                          //     horizontal: Sizes.size5,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(Sizes.size5),
                          //   ),
                          //   child: Text(
                          //     widget.sortOption == SortOptions.starUp
                          //         ? '레어도 오름차순'
                          //         : widget.sortOption == SortOptions.starDown
                          //             ? '레어도 내림차순'
                          //             : widget.sortOption == SortOptions.nameUp
                          //                 ? '이름 오름차순'
                          //                 : '이름 내림차순',
                          //     style: TextStyle(
                          //       fontFamily: FontFamily.nanumGothic,
                          //       fontSize: Sizes.size14,
                          //       fontWeight: FontWeight.w700,
                          //       color: Colors.blueGrey.shade700,
                          //     ),
                          //   ),
                          // ),
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
