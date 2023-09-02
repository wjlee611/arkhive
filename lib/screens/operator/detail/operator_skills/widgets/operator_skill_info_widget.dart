import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/operator/skill_model.dart';
import 'package:arkhive/screens/operator/detail/operator_skills/widgets/operator_skill_sptype_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_range_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';

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
    _levelTabController = TabController(
      length: widget.skill.levels.length,
      vsync: this,
    );
    _levelTabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _levelTabController.removeListener(_handleTabSelection);
    _levelTabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant OperatorSkillInfoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.skill.levels.length != widget.skill.levels.length) {
      _levelTabController.removeListener(_handleTabSelection);
      _levelTabController.dispose();

      _levelTabController = TabController(
        length: widget.skill.levels.length,
        vsync: this,
      );
      _levelTabController.addListener(_handleTabSelection);
    }
  }

  void _handleTabSelection() {
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
          child: SizedBox(
            height: Sizes.size32,
            child: TabBar(
              controller: _levelTabController,
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.yellow.shade800,
                    width: Sizes.size3,
                  ),
                ),
              ),
              labelColor: Colors.yellow.shade800,
              unselectedLabelColor:
                  Theme.of(context).textTheme.bodySmall!.color,
              tabs: [
                for (int i = 0; i < widget.skill.levels.length; i++)
                  SizedBox(
                    width: Sizes.size40,
                    child: Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: Sizes.size2),
                        child: AppFont(
                          i < 7 ? 'R${i + 1}' : 'R7M${i - 6}',
                          forceColorNull: true,
                          fontWeight: FontWeight.w700,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                          type: skill.skillType!,
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
                                AppFont(
                                  '${skill.duration!.toInt()}초',
                                  color: Colors.white,
                                  fontSize: Sizes.size10,
                                  fontWeight: FontWeight.w700,
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
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(Sizes.size2),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: Sizes.size1,
                                  color: Theme.of(context).shadowColor,
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
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size2),
                                    color: Colors.blue,
                                  ),
                                  child: const AppFont(
                                    'SP',
                                    color: Colors.white,
                                    fontSize: Sizes.size10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Gaps.h5,
                                AppFont(
                                  skill.spData.initSp!.toInt().toString(),
                                  color: Colors.blue,
                                  fontSize: Sizes.size10,
                                  fontWeight: FontWeight.w700,
                                ),
                                Container(
                                  width: Sizes.size14,
                                  height: Sizes.size10,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(),
                                  child: Transform.translate(
                                    offset: const Offset(
                                        -Sizes.size3, -Sizes.size5),
                                    child: const Center(
                                      child: Icon(
                                        Icons.arrow_right_rounded,
                                        color: Colors.blue,
                                        size: Sizes.size20,
                                      ),
                                    ),
                                  ),
                                ),
                                AppFont(
                                  skill.spData.spCost!.toInt().toString(),
                                  color: Colors.blue,
                                  fontSize: Sizes.size10,
                                  fontWeight: FontWeight.w700,
                                ),
                                Gaps.h4,
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (skill.rangeId != null)
                  CommonRangeWidget(rangeId: skill.rangeId),
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
