class OperatorListModel {
  final String operatorKey, name, profession;
  final String rarity; // CN: 0 -> TIER_1
  final String position;
  final List<String> tagList;

  OperatorListModel({
    required this.operatorKey,
    required this.name,
    required this.profession,
    required this.rarity,
    required this.position,
    required this.tagList,
  });
}
