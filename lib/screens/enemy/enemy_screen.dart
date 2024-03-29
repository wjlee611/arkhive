import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_event.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/enemy/widgets/enemy_button_widget.dart';
import 'package:arkhive/screens/enemy/widgets/enemy_sliver_appbar_widget.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_no_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyScreen extends StatelessWidget {
  const EnemyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnemyListBloc(
        dbRegion: getRegion(context),
      ),
      child: Scaffold(
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const EnemySliverAppBar(),
            SliverFillRemaining(
              child: BlocBuilder<EnemyListBloc, EnemyListState>(
                builder: (context, state) {
                  if (state is EnemyListInitState) {
                    context
                        .read<EnemyListBloc>()
                        .add(const EnemyListInitEvent());
                  }
                  if (state is EnemyListErrorState) {
                    return Center(
                      child: AppFont(
                        state.message,
                        fontSize: Sizes.size16,
                      ),
                    );
                  }
                  if (state is! EnemyListLoadedState) {
                    return const CommonLoadingWidget();
                  }
                  if (state.filteredEnemyList.isEmpty) {
                    return const CommonNoResultWidget();
                  }
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(Sizes.size20),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: Sizes.size5,
                            crossAxisSpacing: Sizes.size5,
                            childAspectRatio: 1,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return EnemyButton(
                                enemy: state.filteredEnemyList[index],
                              );
                            },
                            childCount: state.filteredEnemyList.length,
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: Gaps.v130),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
