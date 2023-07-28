import 'package:arkhive/bloc/item/item_list/item_list_state.dart';

abstract class ItemListEvent {
  const ItemListEvent();
}

class ItemListInitEvent extends ItemListEvent {
  const ItemListInitEvent();
}

class ItemListSortEvent extends ItemListEvent {
  final ItemListFilterOptions filter;

  const ItemListSortEvent({
    required this.filter,
  });
}

class ItemListSearchEvent extends ItemListEvent {
  final String searchQuery;

  const ItemListSearchEvent({
    required this.searchQuery,
  });
}
