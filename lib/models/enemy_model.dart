class EnemyModel {
  final String name, code;
  // ignore: library_private_types_in_public_api
  final List<_EnemyStatModel> level;
  final String enemyType, attackType;

  EnemyModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        code = json['code'],
        level = [
          for (var levelJson in json['level'])
            _EnemyStatModel.fromJson(levelJson)
        ],
        enemyType = json['enemyType'],
        attackType = json['attackType'];
}

class _EnemyStatModel {
  final String hp, atk, def, res, weight, abilities;
  final bool stunImm, silenceImm;

  _EnemyStatModel.fromJson(Map<String, dynamic> json)
      : hp = json['hp'],
        atk = json['atk'],
        def = json['def'],
        res = json['res'],
        weight = json['weight'],
        abilities = json['abilities'],
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

// levels enemy list
/**
 * B1
 * B2
 * O1
 * O2
 * 01
 * A1
 * A2
 * A3
 * A4
 * 02
 * 03
 * 04
 * 05
 * 08
 * 09
 * 10
 * B8
 * C0
 * D1
 * D2
 * D4
 * S1
 * S3
 * S5
 * SC
 * 14
 * 15
 * Y1
 * FTT
 * DH15
 * NL11
 * NL14
 * NL17
 * NL20
 * LE17
 */