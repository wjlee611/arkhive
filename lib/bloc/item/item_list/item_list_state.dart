import 'package:arkhive/models/item/item_list_model.dart';
import 'package:equatable/equatable.dart';

enum ItemListFilterOptions {
  all,
  normal, // normal & none
  consume,
  material,
}

abstract class ItemListState extends Equatable {
  final List<ItemListModel>? itemList;

  final ItemListFilterOptions? selectedFilterOption;
  final String? searchQuery;

  const ItemListState({
    this.itemList,
    this.selectedFilterOption,
    this.searchQuery,
  });
}

class ItemListInitState extends ItemListState {
  ItemListInitState()
      : super(
          itemList: [],
          selectedFilterOption: ItemListFilterOptions.all,
          searchQuery: "",
        );

  @override
  List<Object?> get props => [
        itemList,
        selectedFilterOption,
        searchQuery,
      ];
}

class ItemListLoadingState extends ItemListState {
  const ItemListLoadingState({
    super.itemList,
    super.selectedFilterOption,
    super.searchQuery,
  });

  @override
  List<Object?> get props => [
        itemList,
        selectedFilterOption,
        searchQuery,
      ];
}

class ItemListLoadedState extends ItemListState {
  final List<ItemListModel> filteredItemList;

  const ItemListLoadedState({
    super.itemList,
    required this.filteredItemList,
    super.selectedFilterOption,
    super.searchQuery,
  });

  @override
  List<Object?> get props => [
        itemList,
        filteredItemList,
        selectedFilterOption,
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
