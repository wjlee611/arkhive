import 'dart:convert';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/models/skill_model.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OperatorSkillContainer extends StatefulWidget {
  const OperatorSkillContainer({
    super.key,
    required this.skills,
  });

  final List<OperatorSkillsModel> skills;

  @override
  State<OperatorSkillContainer> createState() => _OperatorSkillContainerState();
}

class _OperatorSkillContainerState extends State<OperatorSkillContainer>
    with TickerProviderStateMixin {
  late TabController _skillTabController;

  @override
  void initState() {
    super.initState();
    _skillTabController =
        TabController(length: widget.skills.length, vsync: this);
    _skillTabController.addListener(_handleSkillTabSelection);
  }

  @override
  void dispose() {
    _skillTabController.dispose();
    super.dispose();
  }

  void _handleSkillTabSelection() {
    if (_skillTabController.indexIsChanging) {
      setState(() {});
    }
  }

  Future<List<SkillModel>> _futureSkills(
      List<OperatorSkillsModel> skills) async {
    List<SkillModel> result = [];
    const storage = FlutterSecureStorage();

    for (var skill in skills) {
      String? skillString = await storage.read(key: 'skill/${skill.skillId}');
      if (skillString != null) {
        var skillJson = await json.decode(skillString);
        result.add(SkillModel.fromJson(skillJson));
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CommonTitleWidget(text: '스킬'),
        Gaps.v5,
        FutureBuilder(
          future: _futureSkills(widget.skills),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var skill = snapshot.data![_skillTabController.index];
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: Container(
                      height: Sizes.size24,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(Sizes.size10),
                      ),
                      child: TabBar(
                        controller: _skillTabController,
                        isScrollable: true,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size10),
                          color: Colors.yellow.shade800,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          for (int i = 0; i < snapshot.data!.length; i++)
                            SizedBox(
                              width: Sizes.size40,
                              child: Tab(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: Sizes.size2),
                                  child: Text(
                                    '${i + 1} 스킬',
                                    style: const TextStyle(
                                      fontFamily: FontFamily.nanumGothic,
                                      fontWeight: FontWeight.w700,
                                      fontSize: Sizes.size12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Gaps.v5,
                  OperatorSkillInfoWidget(skill: skill),
                ],
              );
            } else {
              return CircularProgressIndicator(
                color: Colors.yellow.shade800,
              );
            }
          },
        ),
      ],
    );
  }
}

class OperatorSkillInfoWidget extends StatefulWidget {
  const OperatorSkillInfoWidget({
    super.key,
    required this.skill,
  });

  final SkillModel skill;

  @override
  State<OperatorSkillInfoWidget> createState() =>
      _OperatorSkillInfoWidgetState();
}

class _OperatorSkillInfoWidgetState extends State<OperatorSkillInfoWidget>
    with TickerProviderStateMixin {
  late TabController _levelTabController;

  @override
  void initState() {
    super.initState();
    _levelTabController =
        TabController(length: widget.skill.levels.length, vsync: this);
    _levelTabController.addListener(_handleSkillTabSelection);
  }

  @override
  void didUpdateWidget(covariant OperatorSkillInfoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.skill.levels.length != widget.skill.levels.length) {
      _levelTabController.removeListener(_handleSkillTabSelection);
      _levelTabController.dispose();

      _levelTabController =
          TabController(length: widget.skill.levels.length, vsync: this);
      _levelTabController.addListener(_handleSkillTabSelection);
    }
  }

  @override
  void dispose() {
    _levelTabController.dispose();
    super.dispose();
  }

  void _handleSkillTabSelection() {
    if (_levelTabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var skill = widget.skill.levels[_levelTabController.index];
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Center(
          child: Container(
            height: Sizes.size24,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(Sizes.size10),
            ),
            child: TabBar(
              controller: _levelTabController,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.size10),
                color: Colors.yellow.shade800,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                for (int i = 0; i < widget.skill.levels.length; i++)
                  SizedBox(
                    width: Sizes.size40,
                    child: Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: Sizes.size2),
                        child: Text(
                          i < 7 ? 'R${i + 1}' : 'R7M${i - 6}',
                          style: const TextStyle(
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Gaps.v5,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonSubTitleWidget(text: skill.name!),
            Gaps.v5,
            FormattedTextWidget(
              text: skill.description!,
              variables: blackboardListToMap(blackboards: skill.blackboard),
              center: false,
            )
          ],
        ),
      ],
    );
  }
}
