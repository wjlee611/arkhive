class OperatorModel {
  final String name, rare, class_, position, imageName;
  final List<_TalentModel> talent;
  final List<_SkillModel> skill;
  final List<_ModuleModel> module;

  static String vanguard = '뱅가드';
  static String sniper = '스나이퍼';
  static String guard = '가드';
  static String caster = '캐스터';
  static String defender = '디펜더';
  static String medic = '메딕';
  static String specialist = '스페셜리스트';
  static String supporter = '서포터';

  static String tactician =
      "공격 범위 내 전술 포인트를 1회 선택해 지원군 소환 가능, 지원군이 저지하는 적을 공격할 때 본인 공격력이 150%까지 상승";
  static String charger = "적 처치시 배치 코스트 +1, 퇴각 시 초기 배치 코스트 반환";
  static String pioneer = "적 2명 저지 가능";
  static String standardBearer = "스킬을 사용하는 동안 저지 수가 0이 된다";

  OperatorModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        rare = json['rare'],
        class_ = json['class'],
        position = json['position'],
        imageName = json["image_name"],
        talent = [
          for (var talJson in json['talent']) _TalentModel.fromJson(talJson)
        ],
        skill = [
          for (var skillJson in json['skill']) _SkillModel.fronJson(skillJson)
        ],
        module = [
          for (var moduleJson in json['module'])
            _ModuleModel.fromJson(moduleJson)
        ];
}

class _TalentModel {
  final String name, info;

  _TalentModel.fromJson(Map<String, dynamic> json)
      : name = json['talent_name'],
        info = json['talent_info'];
}

class _SkillModel {
  final String name, sp, duration, type, info;

  _SkillModel.fronJson(Map<String, dynamic> json)
      : name = json['skill_name'],
        sp = json['sp'],
        duration = json['duration'],
        type = json['type'],
        info = json['info'];
}

class _ModuleModel {
  final String name, code;
  final List<_ModuleEffectModel> effect;

  _ModuleModel.fromJson(Map<String, dynamic> json)
      : name = json['module_name'],
        code = json['module_code'],
        effect = [
          for (var effJson in json['effect'])
            _ModuleEffectModel.fromJson(effJson)
        ];
}

class _ModuleEffectModel {
  final String stat;
  final _TalentModel talent;

  _ModuleEffectModel.fromJson(Map<String, dynamic> json)
      : stat = json['stat'],
        talent = _TalentModel.fromJson(json['talent']);
}
