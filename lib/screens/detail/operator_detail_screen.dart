import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OperatorDetailScreen extends StatefulWidget {
  final OperatorModel operator_;

  const OperatorDetailScreen({
    super.key,
    required this.operator_,
  });

  @override
  State<OperatorDetailScreen> createState() => _OperatorDetailScreenState();
}

class _OperatorDetailScreenState extends State<OperatorDetailScreen> {
  String _getPostionInfo(String position) {
    if (position == "전술가") return OperatorModel.tactician;
    if (position == "돌격수") return OperatorModel.charger;
    if (position == "척후병") return OperatorModel.pioneer;
    if (position == "기수") return OperatorModel.standardBearer;

    if (position == "명사수") return OperatorModel.marksman;
    if (position == "명사수*") return OperatorModel.marksman_1star;
    if (position == "포격사수") return OperatorModel.artilleryman;
    if (position == "저격수") return OperatorModel.deadeye;
    if (position == "헤비슈터") return OperatorModel.heavyshooter;
    if (position == "산탄사수") return OperatorModel.spreadshooter;
    if (position == "공성사수") return OperatorModel.besieger;
    if (position == "투척수") return OperatorModel.flinger;

    if (position == "드레드노트") return OperatorModel.dreadnought;
    if (position == "드레드노트*") return OperatorModel.dreadnought_1star;
    if (position == "로드") return OperatorModel.lord;
    if (position == "공격수") return OperatorModel.centurion;
    if (position == "교관") return OperatorModel.instructor;
    if (position == "파이터") return OperatorModel.fighter;
    if (position == "아츠 파이터") return OperatorModel.artsFighter;
    if (position == "무사") return OperatorModel.musha;
    if (position == "소드마스터") return OperatorModel.swordmaster;
    if (position == "해방자") return OperatorModel.liberator;
    if (position == "리퍼") return OperatorModel.reaper;

    return "not found";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "이력서",
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: () {
              //TODO: 즐겨찾기 추가/삭제 알고리즘 추가
            },
            icon:
                Icon(Icons.star_border_outlined, color: Colors.yellow.shade700),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey.shade700,
            child: Container(
              margin: const EdgeInsets.only(
                top: 50,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.vertical(
                  top: Radius.circular(
                    50,
                  ),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < int.parse(widget.operator_.rare); i++)
                        SizedBox(
                          width: 18,
                          child: Transform.rotate(
                            angle: 15 * math.pi / 180,
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow.shade700,
                              size: 26,
                              shadows: const [
                                Shadow(
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 2,
                              spreadRadius: 1,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: Text(
                          widget.operator_.name,
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: 20,
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.operator_.class_ == OperatorModel.vanguard
                            ? "assets/images/class_vanguard.png"
                            : widget.operator_.class_ == OperatorModel.sniper
                                ? "assets/images/class_sniper.png"
                                : widget.operator_.class_ == OperatorModel.guard
                                    ? "assets/images/class_guard.png"
                                    : widget.operator_.class_ ==
                                            OperatorModel.caster
                                        ? "assets/images/class_caster.png"
                                        : widget.operator_.class_ ==
                                                OperatorModel.defender
                                            ? "assets/images/class_defender.png"
                                            : widget.operator_.class_ ==
                                                    OperatorModel.medic
                                                ? "assets/images/class_medic.png"
                                                : widget.operator_.class_ ==
                                                        OperatorModel.specialist
                                                    ? "assets/images/class_specialist.png"
                                                    : "assets/images/class_supporter.png",
                        width: 40,
                        height: 40,
                        color: Colors.blueGrey.shade700,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.operator_.position.replaceFirst('*', ''),
                        style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontSize: 20,
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.shade100,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.blueGrey.shade600,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.accessibility_new_rounded,
                                color: Colors.yellow.shade700,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "특성",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: FontFamily.nanumGothic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            _getPostionInfo(widget.operator_.position),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Talent
                  const SizedBox(
                    height: 20,
                  ),
                  TalentCard(widget: widget),

                  // SKILLS
                  SizedBox(
                    height: widget.operator_.skill.isNotEmpty ? 20 : 0,
                  ),
                  widget.operator_.skill.isNotEmpty
                      ? SkillCard(widget: widget)
                      : const SizedBox(),

                  // Modules
                  SizedBox(
                    height: widget.operator_.module.isNotEmpty ? 20 : 0,
                  ),
                  widget.operator_.module.isNotEmpty
                      ? ModuleCard(widget: widget)
                      : const SizedBox(),

                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          ImageWithStars(widget: widget),
        ],
      ),
    );
  }
}

class ModuleCard extends StatefulWidget {
  const ModuleCard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final OperatorDetailScreen widget;

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  int _selectedModule = 0;
  int _selectedStage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade100,
            blurRadius: 5,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.ballot_outlined,
                        color: Colors.yellow.shade700,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "모듈",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0;
                        i < widget.widget.operator_.module.length;
                        i++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_selectedModule != i) {
                              _selectedStage = 0;
                            }
                            _selectedModule = i;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          margin: EdgeInsets.only(
                            right:
                                widget.widget.operator_.module.length - 1 == i
                                    ? 0
                                    : 5,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedModule == i
                                ? Colors.white
                                : Colors.blueGrey.shade500,
                            borderRadius:
                                const BorderRadiusDirectional.vertical(
                              top: Radius.circular(
                                5,
                              ),
                            ),
                          ),
                          child: Text(
                            widget.widget.operator_.module[i].code
                                .split('-')
                                .last,
                            style: TextStyle(
                              color: _selectedModule == i
                                  ? Colors.blueGrey.shade600
                                  : Colors.white,
                              fontSize: 16,
                              fontFamily: FontFamily.nanumGothic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade600,
                    borderRadius: const BorderRadiusDirectional.horizontal(
                      end: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    widget.widget.operator_.module[_selectedModule].name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 2, 10, 2),
                  decoration: BoxDecoration(
                    color: widget.widget.operator_.module[_selectedModule].code
                                .split('-')
                                .last ==
                            "X"
                        ? Colors.orange.shade900
                        : Colors.blue.shade800,
                    borderRadius: const BorderRadiusDirectional.horizontal(
                      end: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    widget.widget.operator_.module[_selectedModule].code,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade600,
                            borderRadius:
                                const BorderRadiusDirectional.horizontal(
                              end: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  "Stage",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: FontFamily.nanumGothic,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              for (int i = 0;
                                  i <
                                      widget
                                          .widget
                                          .operator_
                                          .module[_selectedModule]
                                          .effect
                                          .length;
                                  i++)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedStage = i;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 7,
                                    ),
                                    margin: const EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedStage == i
                                          ? Colors.white
                                          : Colors.blueGrey.shade500,
                                      borderRadius:
                                          const BorderRadiusDirectional
                                              .horizontal(
                                        end: Radius.circular(
                                          5,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "${i + 1}",
                                      style: TextStyle(
                                        color: _selectedStage == i
                                            ? Colors.blueGrey.shade600
                                            : Colors.white,
                                        fontSize: 16,
                                        fontFamily: FontFamily.nanumGothic,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: widget.widget.operator_
                                            .module[_selectedModule].code
                                            .split('-')
                                            .last ==
                                        "X"
                                    ? Colors.orange.shade900
                                    : Colors.blue.shade800,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                "Stat",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: FontFamily.nanumGothic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            for (var stat in widget
                                .widget
                                .operator_
                                .module[_selectedModule]
                                .effect[_selectedStage]
                                .stat
                                .split(', '))
                              Text(
                                stat,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                            const SizedBox(
                              height: 7,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: widget.widget.operator_
                                            .module[_selectedModule].code
                                            .split('-')
                                            .last ==
                                        "X"
                                    ? Colors.orange.shade900
                                    : Colors.blue.shade800,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                widget.widget.operator_.module[_selectedModule]
                                    .effect[0].talent.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: FontFamily.nanumGothic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              widget.widget.operator_.module[_selectedModule]
                                  .effect[0].talent.info,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.nanumGothic,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            _selectedStage != 0
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: widget.widget.operator_
                                                  .module[_selectedModule].code
                                                  .split('-')
                                                  .last ==
                                              "X"
                                          ? Colors.orange.shade900
                                          : Colors.blue.shade800,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      widget
                                          .widget
                                          .operator_
                                          .module[_selectedModule]
                                          .effect[_selectedStage]
                                          .talent
                                          .name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: FontFamily.nanumGothic,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: _selectedStage != 0 ? 3 : 0,
                            ),
                            _selectedStage != 0
                                ? Text(
                                    widget
                                        .widget
                                        .operator_
                                        .module[_selectedModule]
                                        .effect[_selectedStage]
                                        .talent
                                        .info,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: FontFamily.nanumGothic,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  const SkillCard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final OperatorDetailScreen widget;

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  int _selectedSkill = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade100,
            blurRadius: 5,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sports_gymnastics_rounded,
                        color: Colors.yellow.shade700,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "스킬",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0;
                        i < widget.widget.operator_.skill.length;
                        i++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSkill = i;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          margin: EdgeInsets.only(
                            right: widget.widget.operator_.skill.length - 1 == i
                                ? 0
                                : 5,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedSkill == i
                                ? Colors.white
                                : Colors.blueGrey.shade500,
                            borderRadius:
                                const BorderRadiusDirectional.vertical(
                              top: Radius.circular(
                                5,
                              ),
                            ),
                          ),
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: _selectedSkill == i
                                  ? Colors.blueGrey.shade600
                                  : Colors.white,
                              fontSize: 16,
                              fontFamily: FontFamily.nanumGothic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade600,
                    borderRadius: const BorderRadiusDirectional.horizontal(
                      end: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    widget.widget.operator_.skill[_selectedSkill].name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (var type in widget
                        .widget.operator_.skill[_selectedSkill].type
                        .split('/'))
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 1,
                        ),
                        margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        decoration: BoxDecoration(
                          color: type == '자연 회복'
                              ? Colors.green
                              : type == '공격 회복'
                                  ? Colors.deepOrange
                                  : type == "피격 회복"
                                      ? Colors.amber
                                      : Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          type,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: FontFamily.nanumGothic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                            vertical: 1,
                          ),
                          margin: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'SP',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: FontFamily.nanumGothic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        widget.widget.operator_.skill[_selectedSkill].sp
                                    .split('/')
                                    .length ==
                                2
                            ? Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.widget.operator_
                                        .skill[_selectedSkill].sp
                                        .split('/')[0],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: FontFamily.nanumGothic,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_right,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                  Text(
                                    widget.widget.operator_
                                        .skill[_selectedSkill].sp
                                        .split('/')[1],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: FontFamily.nanumGothic,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              )
                            : const Padding(
                                padding: EdgeInsets.only(
                                  left: 5,
                                ),
                                child: Text(
                                  "즉시 시전",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontFamily.nanumGothic,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Row(
                      children: [
                        for (var dur in widget
                            .widget.operator_.skill[_selectedSkill].duration
                            .split('/'))
                          dur == '시간'
                              ? Icon(
                                  Icons.timelapse_rounded,
                                  color: Colors.grey.shade700,
                                  size: 18,
                                )
                              : dur == '탄창'
                                  ? Icon(
                                      Icons.stacked_bar_chart_rounded,
                                      color: Colors.grey.shade700,
                                      size: 18,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        dur == '0' ? "즉시 발동" : dur,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: FontFamily.nanumGothic,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text(
                    widget.widget.operator_.skill[_selectedSkill].info,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.nanumGothic,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TalentCard extends StatelessWidget {
  const TalentCard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final OperatorDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade100,
            blurRadius: 5,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.yellow.shade700,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "재능",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var talent in widget.operator_.talent)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueGrey.shade600,
                        ),
                        child: Text(
                          talent.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        talent.info,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: FontFamily.nanumGothic,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageWithStars extends StatelessWidget {
  const ImageWithStars({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final OperatorDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: widget.operator_.imageName,
          child: Transform.scale(
            scale: 0.7,
            child: Transform.rotate(
              angle: 45 * math.pi / 180,
              child: Container(
                width: 100,
                height: 100,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  border: Border.all(
                    width: 3,
                    color: Colors.blueGrey.shade600,
                    strokeAlign: StrokeAlign.outside,
                  ),
                ),
                child: Transform.scale(
                  scale: 1.4,
                  child: Transform.rotate(
                    angle: -45 * math.pi / 180,
                    child: Image.asset(
                      'assets/images/operators/${widget.operator_.imageName}.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
