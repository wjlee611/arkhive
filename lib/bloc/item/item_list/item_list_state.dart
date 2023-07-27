import 'package:arkhive/models/item_list_model.dart';
import 'package:equatable/equatable.dart';

enum ItemListSortOptions {
  all,
  none,
  normal,
  consume,
  material,
}

abstract class ItemListState extends Equatable {
  final List<ItemListModel>? itemList;

  final ItemListSortOptions? selectedSortOption;
  final String? searchQuery;

  const ItemListState({
    this.itemList,
    this.selectedSortOption,
    this.searchQuery,
  });
}

class ItemListInitState extends ItemListState {
  ItemListInitState()
      : super(
          itemList: [],
          selectedSortOption: ItemListSortOptions.all,
          searchQuery: "",
        );

  @override
  List<Object?> get props => [
        itemList,
        selectedSortOption,
        searchQuery,
      ];
}

class ItemListLoadingState extends ItemListState {
  const ItemListLoadingState({
    super.itemList,
    super.selectedSortOption,
    super.searchQuery,
  });

  @override
  List<Object?> get props => [
        itemList,
        selectedSortOption,
        searchQuery,
      ];
}

class ItemListLoadedState extends ItemListState {
  final List<ItemListModel> filteredItemList;

  const ItemListLoadedState({
    super.itemList,
    required this.filteredItemList,
    super.selectedSortOption,
    super.searchQuery,
  });

  @override
  List<Object?> get props => [
        itemList,
        filteredItemList,
        selectedSortOption,
        searchQuery,
      ];
}

class ItemListErrorState extends ItemListState {
  final String message;

  const ItemListErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
