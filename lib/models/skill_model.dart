import 'package:arkhive/models/common_models.dart';
import 'package:flutter/material.dart';

class SkillModel {
  final String? skillId;
  final List<SkillLevelsModel> levels;

  SkillModel.fromJson(Map<String, dynamic> json)
      : skillId = json['skillId'],
        levels = [
          if (json['levels'] != null)
            for (var data in json['levels']) SkillLevelsModel.fromJson(data)
        ];
}

class SkillLevelsModel {
  final String? name, rangeId, description;
  final String? skillType;
  // final String? durationType;
  final SkillSPModel spData;
  final double? duration;
  final List<BlackboardModel> blackboard;
  SkillLevelsModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        rangeId = json['rangeId'],
        description = json['description'],
        skillType = json['skillType'].toString(),
        // durationType = json['durationType'].toString(),
        spData = SkillSPModel.fromJson(json['spData'] ?? {}),
        duration = json['duration'],
        blackboard = [
          if (json['blackboard'] != null)
            for (var data in json['blackboard']) BlackboardModel.fromJson(data)
        ];
}

class SkillSPModel {
  final String? spType;
  final int? maxChargeTime, spCost, initSp;
  final double? increment;

  SkillSPModel.fromJson(Map<String, dynamic> json)
      : spType = json['spType'].toString(),
        maxChargeTime = json['maxChargeTime'],
        spCost = json['spCost'],
        initSp = json['initSp'],
        increment = json['increment'];
}

enum SkillType {
  passive('패시브', Colors.grey),
  manual('수동 발동', Colors.grey),
  auto('자동 발동', Colors.grey);

  final String text;
  final Color color;

  const SkillType(this.text, this.color);
}

enum SkillSPType {
  // INCREASE_WITH_TIME 1
  time('자연 회복', Color.fromRGBO(102, 187, 106, 1)),
  // INCREASE_WHEN_ATTACK 2
  attack('공격 회복', Color.fromRGBO(255, 109, 0, 1)),
  // INCREASE_WHEN_TAKEN_DAMAGE 4
  damage('피격 회복', Color.fromRGBO(255, 214, 0, 1));
  // 8 8 - 패시브 표시 금지

  final String text;
  final Color color;

  const SkillSPType(this.text, this.color);
}

enum SkillDurationType {
  // INCREASE_WITH_TIME 1
  time('자연 회복', Color.fromRGBO(102, 187, 106, 1)),
  // INCREASE_WHEN_ATTACK 2
  attack('공격 회복', Color.fromRGBO(255, 109, 0, 1)),
  // INCREASE_WHEN_TAKEN_DAMAGE 4
  damage('피격 회복', Color.fromRGBO(255, 214, 0, 1));
  // 8 8 - 패시브 표시 금지

  final String text;
  final Color color;

  const SkillDurationType(this.text, this.color);
}
