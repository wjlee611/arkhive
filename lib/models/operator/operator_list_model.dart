class OperatorListModel {
  final String operatorKey, name, profession;
  final String rarity; // global: 0 -> cn: TIER_1

  OperatorListModel({
    required this.operatorKey,
    required this.name,
    required this.profession,
    required this.rarity,
  });
}
