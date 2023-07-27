import 'dart:convert';
import 'dart:isolate';

import 'package:arkhive/bloc/item/item_list/item_list_event.dart';
import 'package:arkhive/bloc/item/item_list/item_list_state.dart';
import 'package:arkhive/models/item_list_model.dart';
import 'package:arkhive/models/item_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
  ItemListBloc() : super(ItemListInitState()) {
    on<ItemListInitEvent>(_itemListInitEventHandler);
    // on<ItemListSortEvent>(_itemListSortEventHandler);
    // on<ItemListSearchEvent>(_itemListSearchEventHandler);
  }

  Future<void> _itemListInitEventHandler(
    ItemListInitEvent event,
    Emitter<ItemListState> emit,
  ) async {
    emit(const ItemListLoadingState());

    try {
      List<ItemListModel> result = [];

      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/item_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeItemListModel,
        [port.sendPort, jsonString],
      );
      result.addAll(await port.first);

      emit(ItemListLoadedState(
        itemList: result,
        filteredItemList: result,
        selectedSortOption: ItemListSortOptions.all,
        searchQuery: "",
      ));
    } catch (e) {
      emit(ItemListErrorState(message: e.toString()));
    }
  }

  // Isolate
  static void _deserializeItemListModel(List<dynamic> args) async {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    List<ItemListModel> result = [];

    List<String> classify = [];

    Map<String, dynamic> json = jsonDecode(jsonString)['items'];

    json.forEach((key, value) {
      var item = ItemModel.fromJson(value);

      if (!classify.contains(item.classifyType)) {
        classify.add(item.classifyType);
      }

      result.add(
        ItemListModel(
          itemId: item.itemId,
          iconId: item.iconId,
          classifyType: item.classifyType,
          rarity: item.rarity,
          sortId: item.sortId,
        ),
      );
    });

    print(classify);

    Isolate.exit(sendPort, result);
  }
}
