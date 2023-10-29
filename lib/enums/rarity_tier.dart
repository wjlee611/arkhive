enum ERarityTier {
  tier1(1),
  tier2(2),
  tier3(3),
  tier4(4),
  tier5(5),
  tier6(6),
  max(10);

  final int value;

  const ERarityTier(this.value);
}

ERarityTier rarityTierConverter(String rarity) {
  switch (rarity) {
    case 'TIER_1':
    case '0':
      return ERarityTier.tier1;
    case 'TIER_2':
    case '1':
      return ERarityTier.tier2;
    case 'TIER_3':
    case '2':
      return ERarityTier.tier3;
    case 'TIER_4':
    case '3':
      return ERarityTier.tier4;
    case 'TIER_5':
    case '4':
      return ERarityTier.tier5;
    case 'TIER_6':
    case '5':
      return ERarityTier.tier6;
    default:
      return ERarityTier.tier1;
  }
}
