import 'dart:convert';

import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/models/module_model.dart';
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
  ModuleModel? skadiModule2;
  List<ModuleMissionModel> moduleMissions = [];
  ModuleDataModel? skadiModule2Data;

  int _potential = 0;
  int _elite = 0;
  int _modulePhase = 0;
  double _level = 1;
  double _favor = 0;
  double maxHpDiff = 0;
  double atkFavDiff = 0;
  double _skillLevel = 1;

  Future<void> loadJsonData() async {
    String data =
        await rootBundle.loadString('assets/json/operator/char_263_skadi.json');
    Map<String, dynamic> jsonData = json.decode(data);
    skadi = OperatorModel.fromJson(jsonData['data']);

    for (var skill in skadi!.skills) {
      data = await rootBundle
          .loadString('assets/json/skill/${skill.skillId}.json');
      jsonData = json.decode(data);
      skadiSkills.add(SkillModel.fromJson(jsonData['data']));
    }
    _onTapElite(0);

    data = await rootBundle.loadString('assets/json/module_table.json');
    jsonData = json.decode(data);
    skadiModule2 =
        ModuleModel.fromJson(jsonData['equipDict']['uniequip_002_skadi']);
    for (var mission in skadiModule2!.missionList) {
      moduleMissions
          .add(ModuleMissionModel.fromJson(jsonData['missionList'][mission]));
    }

    data = await rootBundle.loadString('assets/json/module_data_table.json');
    jsonData = json.decode(data);
    skadiModule2Data = ModuleDataModel.fromJson(jsonData['uniequip_002_skadi']);

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

  void _onTapModulePhase(int i) {
    setState(() {
      _modulePhase = i;
    });
  }

  T? _reqPotentalRankSelector<T extends PotentialRank>({
    required List<T> candidates,
    required int currPot,
    int currElite = 2,
    int currLevel = 60,
  }) {
    T? result;

    for (var candidate in candidates) {
      if (candidate.unlockCondition.phase <= currElite &&
          candidate.unlockCondition.level <= currLevel) {
        if (candidate.requiredPotentialRank <= currPot) {
          result = candidate;
        }
      }
    }

    return result;
  }

  Map<String, double> _blackboardListToMap(
      {required List<BlackboardModel> blackboards}) {
    Map<String, double> result = {
      for (var data in blackboards) data.key: data.value
    };

    return result;
  }

  String _skillLevelSelector(int level) {
    if (level > 7) {
      return "Level 7 Mastery ${level - 7}";
    }
    return "Level $level";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (skadi != null &&
                skadiModule2 != null &&
                skadiModule2Data != null &&
                skadiSkills.isNotEmpty)
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(skadi!.name),
                      Text("${skadi!.rarity + 1} star"),
                      Text(skadi!.profession),
                      Text(skadi!.subProfessionId),
                      Text(skadi!.position),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var tag in skadi!.tagList) Text(tag),
                        ],
                      ),
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
                        if (_reqPotentalRankSelector<
                                OperatorTalentsCandidatesModel>(
                              candidates: talent.candidates,
                              currPot: _potential,
                              currElite: _elite,
                              currLevel: _level.toInt(),
                            ) !=
                            null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_reqPotentalRankSelector<
                                      OperatorTalentsCandidatesModel>(
                                candidates: talent.candidates,
                                currPot: _potential,
                                currElite: _elite,
                                currLevel: _level.toInt(),
                              )!
                                  .name),
                              FormattedTextWidget(
                                text: _reqPotentalRankSelector<
                                        OperatorTalentsCandidatesModel>(
                                  candidates: talent.candidates,
                                  currPot: _potential,
                                  currElite: _elite,
                                  currLevel: _level.toInt(),
                                )!
                                    .description,
                                variables: _blackboardListToMap(
                                    blackboards: _reqPotentalRankSelector<
                                            OperatorTalentsCandidatesModel>(
                                  candidates: talent.candidates,
                                  currPot: _potential,
                                  currElite: _elite,
                                  currLevel: _level.toInt(),
                                )!
                                        .blackboard),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                      for (var skill in skadiSkills) Text(skill.levels[0].name),
                      Text('Skill ${_skillLevelSelector(_skillLevel.floor())}'),
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
                      FormattedTextWidget(
                        text: skadiSkills
                            .last.levels[_skillLevel.floor() - 1].description,
                        variables: _blackboardListToMap(
                            blackboards: skadiSkills.last
                                .levels[_skillLevel.toInt() - 1].blackboard),
                      ),
                      Text(
                          "SP ${skadiSkills.last.levels[_skillLevel.toInt() - 1].spData.initSp} > ${skadiSkills.last.levels[_skillLevel.toInt() - 1].spData.spCost}"),
                      Text(
                          'Duration ${skadiSkills.last.levels[_skillLevel.toInt() - 1].duration.toStringAsFixed(0)}s'),
                      const SizedBox(height: 10),
                      const Text('module 2'),
                      Text(skadiModule2!.uniEquipName),
                      Text(skadiModule2!.typeIcon),
                      for (var mission in moduleMissions) Text(mission.desc),
                      for (var item in skadiModule2!.itemCost["1"]!)
                        Text('${item.id} - ${item.count}'),
                      const SizedBox(height: 10),
                      Text('Phase ${_modulePhase + 1}'),
                      Row(
                        children: [
                          for (int i = 0;
                              i < skadiModule2Data!.phases.length;
                              i++)
                            GestureDetector(
                              onTap: () => _onTapModulePhase(i),
                              child: Text('[phase ${i + 1}] '),
                            )
                        ],
                      ),
                      for (var part
                          in skadiModule2Data!.phases[_modulePhase].parts)
                        if (part.target == "TRAIT")
                          if (_reqPotentalRankSelector<
                                  ModuleTraitDataBundleModel>(
                                candidates: part.overrideTraitDataBundle,
                                currPot: _potential,
                              ) !=
                              null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormattedTextWidget(
                                  text: _reqPotentalRankSelector<
                                          ModuleTraitDataBundleModel>(
                                    candidates: part.overrideTraitDataBundle,
                                    currPot: _potential,
                                  )!
                                      .additionalDescription,
                                  variables: _blackboardListToMap(
                                      blackboards: _reqPotentalRankSelector<
                                              ModuleTraitDataBundleModel>(
                                    candidates: part.overrideTraitDataBundle,
                                    currPot: _potential,
                                  )!
                                          .blackboard),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                      for (var part
                          in skadiModule2Data!.phases[_modulePhase].parts)
                        if (part.target == "TALENT")
                          if (_reqPotentalRankSelector<
                                  ModuleTalentDataBundleModel>(
                                candidates: part.addOrOverrideTalentDataBundle,
                                currPot: _potential,
                              ) !=
                              null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_reqPotentalRankSelector<
                                        ModuleTalentDataBundleModel>(
                                  candidates:
                                      part.addOrOverrideTalentDataBundle,
                                  currPot: _potential,
                                )!
                                    .name),
                                FormattedTextWidget(
                                  text: _reqPotentalRankSelector<
                                          ModuleTalentDataBundleModel>(
                                    candidates:
                                        part.addOrOverrideTalentDataBundle,
                                    currPot: _potential,
                                  )!
                                      .upgradeDescription,
                                  variables: _blackboardListToMap(
                                      blackboards: _reqPotentalRankSelector<
                                              ModuleTalentDataBundleModel>(
                                    candidates:
                                        part.addOrOverrideTalentDataBundle,
                                    currPot: _potential,
                                  )!
                                          .blackboard),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                      for (var attr in skadiModule2Data!
                          .phases[_modulePhase].attributeBlackboard)
                        Text('${attr.key} +${attr.value.toInt()}'),
                    ],
                  ),
                ),
              )
            : const Text('no data'),
      ),
    );
  }
}

class FormattedTextWidget extends StatelessWidget {
  final String text;
  final Map<String, dynamic> variables;

  const FormattedTextWidget({
    super.key,
    required this.text,
    this.variables = const {},
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    RegExp separator = RegExp(r"<@.*?>.*?</>");

    List<String> parts = [];
    int lastIndex = 0;
    for (Match match in separator.allMatches(text)) {
      if (lastIndex != match.start) {
        parts.add(text.substring(lastIndex, match.start));
      }
      parts.add(match.group(0)!);
      lastIndex = match.end;
    }
    if (lastIndex != text.length) {
      parts.add(text.substring(lastIndex));
    }

    for (String part in parts) {
      if (part.startsWith('<@')) {
        String tag = part.substring(0, part.indexOf('>') + 1);
        String value =
            part.substring(part.indexOf('>') + 1, part.indexOf('</>'));
        switch (tag) {
          case '<@ba.talpu>':
            textSpans.add(
              TextSpan(
                text: value,
                style: const TextStyle(color: Colors.blue),
              ),
            );
            break;
          case '<@ba.vup>':
          case '<@ba.vdown>':
            String varValue = "";
            if (value.contains('0%')) {
              String variable =
                  value.substring(value.indexOf('{') + 1, value.indexOf(':'));
              // String format =
              //     value.substring(value.indexOf(':') + 1, value.indexOf('}'));
              if (tag == "<@ba.vup>") {
                varValue = '+';
              } else {
                varValue = '-';
              }
              // varValue +=
              //     '${((variables[variable] * 100).toStringAsFixed(1) + format.replaceAll('0%', '%')).replaceAll('.0', '')}';
              varValue +=
                  '${((variables[variable] * 100).toStringAsFixed(1) + '%').replaceAll('.0', '')}';
            } else {
              String variable =
                  value.substring(value.indexOf('{') + 1, value.indexOf('}'));
              if (tag == "<@ba.vup>") {
                varValue = '+';
              } else {
                varValue = '-';
              }
              varValue += variables[variable].toString().replaceAll('.0', '');
            }
            textSpans.add(
              TextSpan(
                text: varValue,
                style: TextStyle(
                  color: tag == "<@ba.vup>" ? Colors.blue : Colors.red,
                ),
              ),
            );
            break;
        }
      } else {
        textSpans.add(TextSpan(text: part));
      }
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: textSpans,
      ),
    );
  }
}
