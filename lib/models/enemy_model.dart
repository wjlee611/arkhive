class EnemyModel {
  final String name, code, health, attack, defense, resist;
  final String hp, atk, def, res, weight;
  final String abilities, enemyType, attackType;
  final bool stunImm, silenceImm;

  EnemyModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        code = json['code'],
        health = json['health'],
        attack = json['attack'],
        defense = json['defense'],
        resist = json['resist'],
        hp = json['hp'],
        atk = json['atk'],
        def = json['def'],
        res = json['res'],
        weight = json['weight'],
        abilities = json['abilities'],
        enemyType = json['enemyType'],
        attackType = json['attackType'],
        stunImm = json['stunImm'] == 'true' ? true : false,
        silenceImm = json['silenceImm'] == 'true' ? true : false;
}

class EnemyType {
  static String normal = '일반';
  static String elite = '엘리트';
  static String boss = '보스';
}

class EnemyAtkType {
  static String noAttack = '공격하지 않음';
  static String melee = '근거리';
  static String meleeArts = '근거리 아츠';
  static String ranged = '원거리';
  static String rangedArts = '원거리 아츠';
}
