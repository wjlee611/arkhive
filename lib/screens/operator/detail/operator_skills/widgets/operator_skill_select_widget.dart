import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/skill_model.dart';
import 'package:arkhive/screens/operator/detail/operator_skills/widgets/operator_skill_info_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class OperatorSkillSelectWidget extends StatefulWidget {
  const OperatorSkillSelectWidget({
    super.key,
    required this.skills,
  });

  final List<SkillModel> skills;

  @override
  State<OperatorSkillSelectWidget> createState() =>
      _OperatorSkillSelectWidgetState();
}

class _OperatorSkillSelectWidgetState extends State<OperatorSkillSelectWidget>
    with TickerProviderStateMixin {
  late TabController _skillTabController;

  @override
  void initState() {
    super.initState();
    _skillTabController = TabController(
      length: widget.skills.length,
      vsync: this,
    );
    _skillTabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _skillTabController.removeListener(_handleTabSelection);
    _skillTabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_skillTabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var skill = widget.skills[_skillTabController.index];
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Center(
          child: SizedBox(
            height: Sizes.size32,
            child: TabBar(
              controller: _skillTabController,
              isScrollable: true,
              physics: const NeverScrollableScrollPhysics(),
              indicator: BoxDecoration(
                border: Border.all(
                  color: Colors.yellow.shade800,
                  width: Sizes.size2,
                ),
              ),
              labelColor: Colors.yellow.shade800,
              unselectedLabelColor: Colors.black,
              tabs: [
                for (int i = 0; i < widget.skills.length; i++)
                  SizedBox(
                    width: Sizes.size40,
                    child: Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: Sizes.size2),
                        child: AppFont(
                          '${i + 1} 스킬',
                          fontWeight: FontWeight.w700,
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
  }
}
