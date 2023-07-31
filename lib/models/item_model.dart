class ItemModel {
  final String itemId, iconId;
  final int sortId;
  final String name;
  final String description;
  final String? obtainApproach;
  final int rarity;
  final String usage;
  final String classifyType, itemType;

  ItemModel.fromJson(Map<String, dynamic> json)
      : itemId = json['itemId'],
        iconId = json['iconId'],
        sortId = json['sortId'],
        name = json['name'],
        description = json['description'] ?? '',
        obtainApproach = json['obtainApproach'],
        rarity = json['rarity'],
        usage = json['usage'] ?? '',
        classifyType = json['classifyType'],
        itemType = json['itemType'];
}

class ItemDropModel {
  final String stageId;
  final String itemId;
  final int times;
  final int quantity;

  ItemDropModel.fromJson(Map<String, dynamic> json)
      : stageId = json['stageId'],
        itemId = json['itemId'],
        times = json['times'],
        quantity = json['quantity'];
}

class Stage2ItemModel {
  Map<String, List<ItemDropModel>> stage;

  Stage2ItemModel() : stage = {};

  void add({
    required String stageId,
    required Map<String, dynamic> json,
  }) {
    if (!stage.containsKey(stageId)) {
      stage[stageId] = [];
    }

    stage[stageId]!.add(ItemDropModel.fromJson(json));
  }
}

class Item2StageModel {
  Map<String, List<ItemDropModel>> item;

  Item2StageModel() : item = {};

  void add({
    required String itemId,
    required Map<String, dynamic> json,
  }) {
    if (!item.containsKey(itemId)) {
      item[itemId] = [];
    }

    item[itemId]!.add(ItemDropModel.fromJson(json));
  }
}
