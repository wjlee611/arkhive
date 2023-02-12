import 'dart:convert';

import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/models/skill_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestPageScreen extends StatefulWidget {
  const TestPageScreen({super.key});

  @override
  State<TestPageScreen> createState() => _TestPageScreenState();
}

class _TestPageScreenState extends State<TestPageScreen> {
  OperatorModel? skadi;
  List<SkillModel> skadiSkills = [];
  int _potential = 0;
  int _elite = 0;
  double _level = 1;
  double _favor = 0;
  double maxHpDiff = 0;
  double atkFavDiff = 0;
  double _skillLevel = 1;

  Future<void> loadJsonData() async {
    String data =
        await rootBundle.loadString('assets/json/operator/char_263_skadi.json');
    Map<String, dynamic> jsonData = json.decode(data);

    setState(() {
      skadi = OperatorModel.fromJson(jsonData['data']);
    });

    for (var skill in skadi!.skills) {
      data = await rootBundle
          .loadString('assets/json/skill/${skill.skillId}.json');
      jsonData = json.decode(data);
      skadiSkills.add(SkillModel.fromJson(jsonData['data']));
    }
    _onTapElite(0);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  void _onTapPotential(int i) {
    setState(() {
      _potential = i - 1;
    });
  }

  void _onTapElite(int i) {
    setState(() {
      _level = 1;
      _elite = i;
      maxHpDiff = (skadi!.phases[_elite].attributesKeyFrames.last.data.maxHp -
              skadi!.phases[_elite].attributesKeyFrames.first.data.maxHp) /
          (skadi!.phases[_elite].maxLevel - 1);
      atkFavDiff = (skadi!.favorKeyFrames.last.data.atk -
              skadi!.favorKeyFrames.first.data.atk) /
          (skadi!.favorKeyFrames.last.level * 4);
    });
  }

  Widget _talentSelectorWidget({
    required List<OperatorTalentsCandidatesModel> candidates,
    required int elite,
    required int potential,
  }) {
    String title = "", description = "";

    for (var candidate in candidates) {
      if (candidate.unlockCondition.phase == elite) {
        if (candidate.requiredPotentialRank <= potential) {
          title = candidate.name;
          description = candidate.description;
        }
      }
    }

    if (title == "") return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(description),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (skadi != null && skadiSkills.isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(skadi!.name),
                    const SizedBox(height: 10),
                    Text('Pot ${_potential + 1}'),
                    Row(
                      children: [
                        for (int i = 1;
                            i < skadi!.potentialRanks.length + 2;
                            i++)
                          GestureDetector(
                            onTap: () => _onTapPotential(i),
                            child: Text('[pot $i] '),
                          )
                      ],
                    ),
                    for (int i = 0; i < _potential; i++)
                      Text(skadi!.potentialRanks[i].description),
                    const SizedBox(height: 10),
                    Text('Elite $_elite'),
                    Row(
                      children: [
                        for (int i = 0; i < skadi!.phases.length; i++)
                          GestureDetector(
                            onTap: () => _onTapElite(i),
                            child: Text('[elite ${i + 0}] '),
                          )
                      ],
                    ),
                    Text('Level ${_level.toInt()}'),
                    Slider(
                      min: 1,
                      max: skadi!.phases[_elite].maxLevel.toDouble(),
                      value: _level,
                      onChanged: (value) {
                        setState(() {
                          _level = value;
                        });
                      },
                    ),
                    Text(
                        'hp ${(skadi!.phases[_elite].attributesKeyFrames.first.data.maxHp + maxHpDiff * (_level.toInt() - 1)).round()}'),
                    const SizedBox(height: 10),
                    Text('Favor ${_favor.toInt()}'),
                    Slider(
                      min: 0,
                      max: skadi!.favorKeyFrames.last.level.toDouble() * 4,
                      value: _favor,
                      onChanged: (value) {
                        setState(() {
                          _favor = value;
                        });
                      },
                    ),
                    Text(
                        'atk +${(skadi!.favorKeyFrames.first.data.atk + atkFavDiff * _favor.toInt()).round()}'),
                    const SizedBox(height: 10),
                    for (var talent in skadi!.talents)
                      _talentSelectorWidget(
                        candidates: talent.candidates,
                        elite: _elite,
                        potential: _potential,
                      ),
                    for (var skill in skadiSkills) Text(skill.levels[0].name),
                    Text('Skill Level ${_skillLevel.floor()}'),
                    Slider(
                      min: 1,
                      max: skadiSkills.last.levels.length.toDouble(),
                      value: _skillLevel,
                      onChanged: (value) {
                        setState(() {
                          _skillLevel = value;
                        });
                      },
                    ),
                    Text(skadiSkills
                        .last.levels[_skillLevel.floor() - 1].description),
                    Text(
                        "SP ${skadiSkills.last.levels[_skillLevel.toInt() - 1].spData.initSp} > ${skadiSkills.last.levels[_skillLevel.toInt() - 1].spData.spCost}"),
                    Text(
                        'Duration ${skadiSkills.last.levels[_skillLevel.toInt() - 1].duration.toStringAsFixed(0)}s'),
                    for (var board in skadiSkills
                        .last.levels[_skillLevel.toInt() - 1].blackboard)
                      Text("${board.key} val: ${board.value}")
                  ],
                ),
              )
            : const Text('no data'),
      ),
    );
  }
}
