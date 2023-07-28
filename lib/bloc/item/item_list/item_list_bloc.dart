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

    Map<String, dynamic> jsonData = jsonDecode(jsonString)['items'];

    for (var itemData in jsonData.entries) {
      var item = ItemModel.fromJson(itemData.value);

      if (item.itemType.contains('LMTGS_COIN')) continue; // 헤드헌팅 데이터 계약
      if (item.itemType.contains('RENAMING')) continue; // ID 정보 갱신 카드
      if (item.itemType == 'RETRO_COIN') continue; // 기록 결정
      if (item.itemType == "AP_SUPPLY" &&
          ![
            // whitelist
            'ap_supply_lt_80',
            'ap_supply_lt_120',
          ].any((id) => item.iconId == id)) continue; // 이성 회복제
      if (item.itemType.contains("VOUCHER") &&
          ![
            // whitelist
            'voucher_skin',
            'voucher_recruitR5_pick2',
            'voucher_recruitR3_1',
            'voucher_recruitR4_1',
            // 아래 데이터는 현재 테이블에 존재하지 않음 (버그인가?)
            // 'voucher_elite_II_5',
            // 'voucher_elite_II_6',
            // 'voucher_levelmax_5',
            // 'voucher_levelmax_6',
          ].any((id) => item.iconId == id)) {
        continue; // 선택권, 허가증
      }
      if (item.itemType.contains("MATERIAL") &&
          item.iconId.contains('tier') &&
          ![
            // whitelist
            'caster',
          ].any((id) => item.iconId.contains(id))) continue; // 증표 (캐스터만 남김)
      if (item.itemType.contains("MATERIAL") &&
          item.iconId.contains("p_char") &&
          ![
            // whitelist
            'amiya',
          ].any((id) => item.iconId.contains(id))) continue; // 증표 (아미야만 남김))
      if (item.classifyType.contains("NONE") &&
          ![
            // whitelist
            'EXP_PLAYER',
            'SOCIAL_PT',
            'AP_GAMEPLAY',
            'AP_BASE',
            'TKT_TRY',
          ].any((id) => item.iconId == id)) continue; // 오퍼 이성 회복 및 기타
      if (item.itemType.contains('TKT_GACHA') &&
          ![
            // whitelist
            'TKT_GACHA',
            'TKT_GACHA_10',
          ].any((id) => item.iconId == id)) continue; // 특별 헤드헌팅

      result.add(
        ItemListModel(
          itemId: item.itemId,
          iconId: item.iconId,
          classifyType: item.classifyType,
          itemType: item.itemType,
          name: item.name,
          rarity: item.rarity,
          sortId: item.sortId,
        ),
      );
    }

    Isolate.exit(sendPort, result);
  }
}
