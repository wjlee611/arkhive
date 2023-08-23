import 'package:arkhive/bloc/item/item_list/item_list_bloc.dart';
import 'package:arkhive/bloc/item/item_list/item_list_event.dart';
import 'package:arkhive/bloc/item/item_list/item_list_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemFiltersButton extends StatelessWidget {
  const ItemFiltersButton({super.key});

  void _onSelected(BuildContext context, ItemListFilterOptions option) {
    context.read<ItemListBloc>().add(ItemListSortEvent(filter: option));
  }

  Color _iconColorSelector(BuildContext context) {
    var query = context.read<ItemListBloc>().state.searchQuery;
    if (query?.isNotEmpty == true) return Colors.grey;

    return Colors.yellow.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemListBloc, ItemListState>(
      builder: (context, state) => PopupMenuButton(
        enabled:
            context.read<ItemListBloc>().state.searchQuery?.isNotEmpty == true
                ? false
                : true,
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
        color: Theme.of(context).primaryColor,
        elevation: 0,
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: ItemListFilterOptions.all,
            child: AppFont(
              '전체',
              fontSize: Sizes.size14,
            ),
          ),
          const PopupMenuItem(
            value: ItemListFilterOptions.normal,
            child: AppFont(
              '일반',
              fontSize: Sizes.size14,
            ),
          ),
          const PopupMenuItem(
            value: ItemListFilterOptions.consume,
            child: AppFont(
              '사용',
              fontSize: Sizes.size14,
            ),
          ),
          const PopupMenuItem(
            value: ItemListFilterOptions.material,
            child: AppFont(
              '육성 재료',
              fontSize: Sizes.size14,
            ),
          ),
        ],
      ),
    );
  }
}
