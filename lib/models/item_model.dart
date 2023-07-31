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
