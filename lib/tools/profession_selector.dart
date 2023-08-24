String proSelector(String eng) {
  String result = '';
  switch (eng) {
    case 'MEDIC':
      {
        result = '메딕';
        break;
      }
    case 'WARRIOR':
      {
        result = '가드';
        break;
      }
    case 'SPECIAL':
      {
        result = '스페셜리스트';
        break;
      }
    case 'SNIPER':
      {
        result = '스나이퍼';
        break;
      }
    case 'PIONEER':
      {
        result = '뱅가드';
        break;
      }
    case 'TANK':
      {
        result = '디펜더';
        break;
      }
    case 'CASTER':
      {
        result = '캐스터';
        break;
      }
    case 'SUPPORT':
      {
        result = '서포터';
        break;
      }
  }

  return result;
}
