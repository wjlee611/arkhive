import 'package:arkhive/bloc/item/item_list/item_list_state.dart';

abstract class ItemListEvent {
  const ItemListEvent();
}

class ItemListInitEvent extends ItemListEvent {
  const ItemListInitEvent();
}

class ItemListSortEvent extends ItemListEvent {
  final ItemListSortOptions sortOption;

  const ItemListSortEvent({
    required this.sortOption,
  });
}

class ItemListSearchEvent extends ItemListEvent {
  final String searchQuery;

  const ItemListSearchEvent({
    required this.searchQuery,
  });
}
