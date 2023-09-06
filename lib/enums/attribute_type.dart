import 'package:arkhive/constants/app_data.dart';

enum EAttributeType {
  maxHp('maxHp'),
  atk('atk'),
  def('def'),
  magicRes('magicRes'),
  cost('cost'),
  atkSpeed('atkSpeed'),
  respawnTime('respawnTime'),
  noResult(AppData.nullStr);

  final String value;

  const EAttributeType(this.value);
}

EAttributeType attributeTypeConverter(String type) {
  switch (type) {
    case '0':
    case 'MAX_HP':
      return EAttributeType.maxHp;
    case '1':
    case 'ATK':
      return EAttributeType.atk;
    case '2':
    case 'DEF':
      return EAttributeType.def;
    case '3':
    case 'MAGIC_RESISTANCE':
      return EAttributeType.magicRes;
    case '4':
    case 'COST':
      return EAttributeType.cost;
    case '7':
    case 'ATTACK_SPEED':
      return EAttributeType.atkSpeed;
    case '21':
    case 'RESPAWN_TIME':
      return EAttributeType.respawnTime;
    default:
      return EAttributeType.noResult;
  }
}
