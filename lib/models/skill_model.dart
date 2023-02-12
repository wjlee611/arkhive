import 'package:arkhive/models/common_models.dart';

class SkillModel {
  final String skillId;
  final List<SkillLevelsModel> levels;

  SkillModel.fromJson(Map<String, dynamic> json)
      : skillId = json['skillId'],
        levels = [
          if (json['levels'] != null)
            for (var data in json['levels']) SkillLevelsModel.fromJson(data)
        ];
}

class SkillLevelsModel {
  final String name, description;
  final int skillType, durationType;
  final SkillSPModel spData;
  final double duration;
  final List<BlackboardModel> blackboard;
  SkillLevelsModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        skillType = json['skillType'],
        durationType = json['durationType'],
        spData = SkillSPModel.fromJson(json['spData']),
        duration = json['duration'],
        blackboard = [
          if (json['blackboard'] != null)
            for (var data in json['blackboard']) BlackboardModel.fromJson(data)
        ];
}

class SkillSPModel {
  final int spType, maxChargeTime, spCost, initSp;
  final double increment;

  SkillSPModel.fromJson(Map<String, dynamic> json)
      : spType = json['spType'],
        maxChargeTime = json['maxChargeTime'],
        spCost = json['spCost'],
        initSp = json['initSp'],
        increment = json['increment'];
}
