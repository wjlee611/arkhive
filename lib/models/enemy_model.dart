class EnemyModel {
  final String name, code, weight;
  // ignore: library_private_types_in_public_api
  final List<_EnemyStatModel> level;
  final String abilities, enemyType, attackType;
  final bool stunImm, silenceImm;

  EnemyModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        code = json['code'],
        level = [
          for (var levelJson in json['level'])
            _EnemyStatModel.fromJson(levelJson)
        ],
        weight = json['weight'],
        abilities = json['abilities'],
        enemyType = json['enemyType'],
        attackType = json['attackType'],
        stunImm = json['stunImm'] == 'true' ? true : false,
        silenceImm = json['silenceImm'] == 'true' ? true : false;
}

class _EnemyStatModel {
  final String hp, atk, def, res;

  _EnemyStatModel.fromJson(Map<String, dynamic> json)
      : hp = json['hp'],
        atk = json['atk'],
        def = json['def'],
        res = json['res'];
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
