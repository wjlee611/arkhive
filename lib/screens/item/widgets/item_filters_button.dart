import 'package:arkhive/bloc/item/item_list/item_list_bloc.dart';
import 'package:arkhive/bloc/item/item_list/item_list_event.dart';
import 'package:arkhive/bloc/item/item_list/item_list_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemFiltersButton extends StatelessWidget {
  const ItemFiltersButton({super.key});

  void _onSelected(BuildContext context, ItemListFilterOptions option) {
    context.read<ItemListBloc>().add(ItemListSortEvent(filter: option));
  }

  Color _iconColorSelector(BuildContext context) {
    var query = context.read<ItemListBloc>().state.searchQuery;
    if (query?.isNotEmpty == true) return Colors.white;

    return Colors.yellow.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemListBloc, ItemListState>(
      builder: (context, state) => PopupMenuButton(
        initialValue: state.selectedFilterOption,
        onSelected: (option) => _onSelected(context, option),
        offset: const Offset(0, 0),
        icon: Icon(
          Icons.filter_alt_rounded,
          color: _iconColorSelector(context),
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
            value: ItemListFilterOptions.all,
            child: Text(
              '전체',
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const PopupMenuItem(
            value: ItemListFilterOptions.normal,
            child: Text(
              '일반',
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const PopupMenuItem(
            value: ItemListFilterOptions.consume,
            child: Text(
              '사용',
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const PopupMenuItem(
            value: ItemListFilterOptions.material,
            child: Text(
              '육성 재료',
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
