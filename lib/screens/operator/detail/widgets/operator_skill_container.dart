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
                        physics: const NeverScrollableScrollPhysics(),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size10),
                          color: Colors.yellow.shade800,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        splashBorderRadius: BorderRadius.circular(Sizes.size10),
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
                  Gaps.v10,
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
              physics: const BouncingScrollPhysics(),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.size10),
                color: Colors.yellow.shade800,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              splashBorderRadius: BorderRadius.circular(Sizes.size10),
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
        Gaps.v7,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonSubTitleWidget(text: skill.name!),
            Gaps.v5,
            Row(
              children: [
                SkillSpTypeWidget(
                  isSkillType: false,
                  type: skill.spData.spType!,
                ),
                SkillSpTypeWidget(
                  isSkillType: true,
                  type: skill.skillType!.toInt(),
                ),
                if (skill.duration != null && skill.duration! > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size1,
                      horizontal: Sizes.size3,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size2),
                      color: Colors.grey.shade600,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timelapse_rounded,
                          color: Colors.grey.shade300,
                          size: Sizes.size10,
                        ),
                        Gaps.h3,
                        Text(
                          '${skill.duration!.toInt()}초',
                          style: const TextStyle(
                            fontFamily: FontFamily.nanumGothic,
                            fontSize: Sizes.size10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (skill.spData.spCost != null && skill.spData.spCost! > 0)
              Column(
                children: [
                  Gaps.v3,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Sizes.size2),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: Sizes.size1,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size1,
                            horizontal: Sizes.size3,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.size2),
                            color: Colors.blue,
                          ),
                          child: const Text(
                            'SP',
                            style: TextStyle(
                              fontFamily: FontFamily.nanumGothic,
                              fontSize: Sizes.size10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Gaps.h5,
                        Text(
                          skill.spData.initSp!.toInt().toString(),
                          style: const TextStyle(
                            fontFamily: FontFamily.nanumGothic,
                            fontSize: Sizes.size10,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          width: Sizes.size14,
                          height: Sizes.size10,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(),
                          child: Transform.translate(
                            offset: const Offset(-Sizes.size3, -Sizes.size5),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_right_rounded,
                                color: Colors.blue,
                                size: Sizes.size20,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          skill.spData.spCost!.toInt().toString(),
                          style: const TextStyle(
                            fontFamily: FontFamily.nanumGothic,
                            fontSize: Sizes.size10,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                        ),
                        Gaps.h4,
                      ],
                    ),
                  ),
                ],
              ),
            Gaps.v3,
            FormattedTextWidget(
              text: skill.description!,
              variables: boardListAndDurationToMap(
                blackboards: skill.blackboard,
                duration: skill.duration,
              ),
              center: false,
            ),
          ],
        ),
      ],
    );
  }
}

class SkillSpTypeWidget extends StatelessWidget {
  const SkillSpTypeWidget({
    super.key,
    required this.isSkillType,
    required this.type,
  });

  final bool isSkillType;
  final int type;

  @override
  Widget build(BuildContext context) {
    var text = '';
    var color = Colors.transparent;
    if (isSkillType) {
      switch (type) {
        case 0:
          // 패시브
          text = '패시브';
          color = Colors.grey;
          break;
        case 1:
          // 수동 발동
          text = '수동 발동';
          color = Colors.grey;
          break;
        case 2:
          // 자동 발동
          text = '자동 발동';
          color = Colors.grey;
          break;
      }
    } else {
      switch (type) {
        case 1:
          // 자연 회복
          text = '자연 회복';
          color = Colors.green.shade400;
          break;
        case 2:
          // 공격 회복
          text = '공격 회복';
          color = Colors.orangeAccent.shade700;
          break;
        case 4:
          // 피격 회복
          text = '피격 회복';
          color = Colors.yellowAccent.shade700;
          break;
        case 8:
          // 패시브 (표시 금지)
          break;
      }
    }
    return text != ''
        ? Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size1,
              horizontal: Sizes.size3,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size2),
              color: color,
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: FontFamily.nanumGothic,
                fontSize: Sizes.size10,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          )
        : Container();
  }
}
