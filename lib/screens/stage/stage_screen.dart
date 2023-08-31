import 'package:arkhive/bloc/stage/stage_list/stage_list_bloc.dart';
import 'package:arkhive/bloc/stage/stage_list/stage_list_event.dart';
import 'package:arkhive/bloc/stage/stage_list/stage_list_state.dart';
import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_bloc.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/stage/widgets/stage_act_container.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StageListBloc(
            dbRegion: getRegion(context),
          ),
        ),
        BlocProvider(
          create: (context) => StageListItemBloc(
            dbRegion: getRegion(context),
          ),
        ),
      ],
      child: BlocBuilder<StageListBloc, StageListState>(
        builder: (context, state) {
          if (state is StageListInitState) {
            context.read<StageListBloc>().add(const StageListInitEvent());
            return const CommonLoadingWidget();
          }
          if (state is StageListErrorState) {
            return Center(
              child: AppFont(
                state.message,
                fontSize: Sizes.size16,
              ),
            );
          }
          if (state is StageListLoadingState) {
            return const CommonLoadingWidget();
          }
          return DefaultTabController(
            length: (state as StageListLoadedState).categories.length,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 0,
                backgroundColor: Colors.blueGrey.shade700,
                bottom: TabBar(
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: Sizes.size3,
                      color: Colors.yellow.shade800,
                    ),
                    insets:
                        const EdgeInsets.symmetric(horizontal: Sizes.size14),
                  ),
                  tabs: [
                    for (var category in state.categories)
                      Tab(
                        child: AppFont(
                          category.category,
                          color: Colors.white,
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (var category in state.categories)
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.all(Sizes.size20),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => StageActContainer(
                                act: category.activities[index],
                              ),
                              childCount: category.activities.length,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Gaps.v130,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
