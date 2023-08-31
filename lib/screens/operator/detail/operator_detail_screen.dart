import 'package:arkhive/bloc/operator/operator_data/operator_data_bloc.dart';
import 'package:arkhive/bloc/operator/operator_data/operator_data_event.dart';
import 'package:arkhive/bloc/operator/operator_data/operator_data_state.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_bloc.dart';
import 'package:arkhive/bloc/operator/operator_status/operator_status_event.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/tags_cubit.dart';
import 'package:arkhive/models/favorite_model.dart';
import 'package:arkhive/models/module_model.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/models/skill_model.dart';
import 'package:arkhive/screens/operator/detail/operator_modules/operator_modules_container.dart';
import 'package:arkhive/screens/operator/detail/operator_skills/operator_skills_container.dart';
import 'package:arkhive/screens/operator/detail/operator_stats/operator_stats_container.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_description_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_sliding_panel_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_star_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_tag_widget.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_talents_widget.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:arkhive/tools/profession_selector.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_favorite_widget.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OperatorDetailScreen extends StatelessWidget {
  const OperatorDetailScreen({
    super.key,
    required this.operatorKey,
    required this.name,
  });

  final String operatorKey;
  final String name;

  @override
  Widget build(BuildContext context) {
    PanelController panelController = PanelController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OperatorDataBloc(
            dbRegion: getRegion(context),
          ),
        ),
        BlocProvider(
          create: (context) => OperatorStatusBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const AppFont(
            "이력서",
            color: Colors.white,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: Colors.blueGrey.shade700,
          actions: [
            CommonFavoriteWidget(
              keyId: operatorKey,
              iconId: operatorKey,
              name: name,
              category: FavorCategory.oper,
            ),
          ],
        ),
        body: SlidingUpPanel(
          controller: panelController,
          isDraggable: false,
          minHeight: Sizes.size96,
          maxHeight: Sizes.size96 * 3 + Sizes.size10,
          color: Colors.blueGrey.shade700,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(Sizes.size20),
            bottomRight: Radius.circular(Sizes.size20),
          ),
          slideDirection: SlideDirection.DOWN,
          panelBuilder: (_) => OperatorSlidingPanel(
            operatorKey: operatorKey,
            controller: panelController,
          ),
          backdropEnabled: true,
          body: BlocBuilder<OperatorDataBloc, OperatorDataState>(
            builder: (context, state) {
              if (state is OperatorDataInitState) {
                context
                    .read<OperatorDataBloc>()
                    .add(OperatorDataLoadEvent(operatorKey: operatorKey));
                return Container();
              }
              if (state is OperatorDataLoadingState) {
                return const CommonLoadingWidget();
              }
              if (state is OperatorDataLoadedState) {
                context
                    .read<OperatorStatusBloc>()
                    .add(OperatorStatusInitEvent(operator_: state.operator_));
                return _buildBody(
                  context: context,
                  operator_: state.operator_,
                  skills: state.skills,
                  modules: state.modules,
                );
              }
              if (state is OperatorDataErrorState) {
                return Center(
                  child: AppFont('${state.message} 데이터를 불러오는데 실패했습니다.'),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required OperatorModel operator_,
    required List<SkillModel> skills,
    required List<ModuleModel> modules,
  }) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: Column(
          children: [
            Gaps.v130,
            CommonTitleWidget(
              text: operator_.name!,
              color: Colors.yellow.shade800,
            ),
            Gaps.v5,
            Wrap(
              direction: Axis.horizontal,
              spacing: Sizes.size4,
              runSpacing: Sizes.size4,
              children: [
                if (operator_.rarity != null)
                  OperatorStarWidget(rarity: operator_.rarity!),
                if (operator_.profession != null)
                  OperatorTagWidget(
                    tag: proSelector(operator_.profession!),
                  ),
                if (operator_.subProfessionId != null)
                  OperatorTagWidget(
                    tag: context
                        .read<TagsCubit>()
                        .state
                        .subProfDict![operator_.subProfessionId!]!,
                  ),
              ],
            ),
            Gaps.v32,
            if (operator_.position != null || operator_.tagList.isNotEmpty)
              OperatorTagWrapWidget(
                position: operator_.position,
                tagList: operator_.tagList,
              ),
            if (operator_.phases.isNotEmpty &&
                operator_.phases.first.attributesKeyFrames.isNotEmpty)
              const OperatorStatsContainer(),
            if (operator_.description != null)
              const OperatorDescriptionWidget(),
            if (operator_.talents.isNotEmpty) const OperatorTalentsWidget(),
            if (skills.isNotEmpty) const OperatorSkillsContainer(),
            if (modules.isNotEmpty) const OperatorModulesContainer(),
            Gaps.v130,
          ],
        ),
      ),
    );
  }
}
