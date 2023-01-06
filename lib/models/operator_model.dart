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
  // vanguard positions
  static String tactician =
      "공격 범위 내 전술 포인트를 1회 선택해 지원군 소환 가능, 지원군이 저지하는 적을 공격할 때 본인 공격력이 150%까지 상승";
  static String charger = "적 처치시 배치 코스트 +1, 퇴각 시 초기 배치 코스트 반환";
  static String pioneer = "적 2명 저지 가능";
  static String standardBearer = "스킬을 사용하는 동안 저지 수가 0이 된다";
  // sniper positions
  static String marksman = "비행 유닛 우선 공격";
  static String marksman_1star =
      "공중 목표 우선 공격, 배치 인원 수 제약을 받지 않으나, 재배치 시간이 매우 길다";
  static String artilleryman = "적에게 광역 물리 대미지";
  static String deadeye = "공격 범위 안의 가장 방어력이 낮은 적을 우선적으로 공격";
  static String heavyshooter = "고정밀 근거리 사격";
  static String spreadshooter =
      "공격 범위 내 모든 적 공격. 자신의 전방 첫 줄의 적에게 공격력이 150%까지 상승한다";
  static String besieger = "공격 범위 안의 가장 무거운 적을 우선적으로 공격";
  static String flinger =
      "지상에 위치한 작은 범위 내 적에게 2회 물리 대미지를 준다. (2번째 공격은 여진으로써, 대미지가 공격력의 절반으로 감소)";
  // guard positions
  static String dreadnought = "적 1명 저지 가능"; // 드레드노트
  static String dreadnought_1star =
      "적 1명 저지 가능. 배치 인원 수 제약을 받지 않으나, 재배치 시간이 매우 길다"; // 드레드노트
  static String lord = "공격력의 80%로 원거리 공격 가능"; // 로드
  static String centurion = "저지 중인 모든 적 동시 공격"; // 공격수
  static String instructor =
      "비교적 먼 곳의 적도 공격 가능, 저지하지 않은 적 공격 시 공격력이 120%까지 상승"; // 교관
  static String fighter = "적 1명 저지 가능"; // 파이터
  static String artsFighter = "일반 공격으로 적에게 마법 대미지"; // 아츠 파이터
  static String musha = "치료 대상으로 판정되지 않으며, 매 회 공격을 통해 자신의 HP를 70회복한다"; // 무사
  static String swordmaster = "일반 공격이 2회 연속 공격"; // 소드마스터
  static String liberator =
      "평소에는 공격하지 않고 저지 가능 수가 0이며, 스킬 미발동 상태에서 40초간 공격력이 최대 +200%까지 점진적으로 상승, 스킬 종료 후 공격력 리셋"; // 해방자
  static String reaper =
      "아군의 치료를 받을 수 없으며, 공격 시 광역 대미지를 입히고, 적 1명 적중할 때마다 자신의 HP가 50만큼 회복, 최대 효과 수는 저지 가능 수와 동일"; // 리퍼

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
