import 'package:arkhive/bloc/stage/stage_list/stage_list_bloc.dart';
import 'package:arkhive/bloc/stage/stage_list/stage_list_event.dart';
import 'package:arkhive/bloc/stage/stage_list/stage_list_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StageListBloc(),
      child: BlocBuilder<StageListBloc, StageListState>(
        builder: (context, state) {
          if (state is StageListInitState) {
            context.read<StageListBloc>().add(const StageListInitEvent());
          }
          if (state is StageListErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.nanumGothic,
                ),
              ),
            );
          }
          if (state is StageListLoadingState) {
            return const CommonLoadingWidget();
          }
          if (state is StageListLoadedState) {
            return DefaultTabController(
              length: state.categories.length,
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
                          child: Text(
                            category.category,
                            style: const TextStyle(
                              fontFamily: FontFamily.nanumGothic,
                              fontWeight: FontWeight.w700,
                              fontSize: Sizes.size14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (var category in state.categories)
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gaps.v32,
                              for (var act in category.activityMap.values)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${act.title} - ${act.actIds}'),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (var zone in act.zones)
                                          Text(
                                            zone.title,
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                      ],
                                    ),
                                    Gaps.v10,
                                  ],
                                ),
                              // StagesContainer(stages: stages),
                              Gaps.v130,
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
