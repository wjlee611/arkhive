import 'dart:convert';
import 'dart:isolate';

import 'package:arkhive/bloc/item/item_data/item_data_event.dart';
import 'package:arkhive/bloc/item/item_data/item_data_state.dart';
import 'package:arkhive/models/item_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDataBloc extends Bloc<ItemDataEvent, ItemDataState> {
  ItemDataBloc() : super(const ItemDataInitState()) {
    on<ItemDataLoadEvent>(_itemDataLoadEventHandler);
  }

  Future<void> _itemDataLoadEventHandler(
    ItemDataLoadEvent event,
    Emitter<ItemDataState> emit,
  ) async {
    emit(const ItemDataLoadingState());

    try {
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/item_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeItemModel,
        [port.sendPort, jsonString, event.itemKey],
      );
      ItemModel item = await port.first;
      port.close();

      emit(ItemDataLoadedState(item: item));
    } catch (e) {
      emit(ItemDataErrorState(message: e.toString()));
      return;
    }
  }

  // Isolate
  static void _deserializeItemModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    String itemKey = args[2];

    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    Isolate.exit(sendPort, ItemModel.fromJson(jsonData['items'][itemKey]));
  }
}
