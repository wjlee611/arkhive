class OperatorModel {
  final String name, rare, class_, position, trait;
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

  OperatorModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        rare = json['rare'],
        class_ = json['class'],
        position = json['position'],
        trait = json['trait'],
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
