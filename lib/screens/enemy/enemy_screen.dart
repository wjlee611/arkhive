import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_event.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/enemy/widgets/enemy_button_widget.dart';
import 'package:arkhive/screens/enemy/widgets/enemy_sliver_appbar_widget.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_no_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyScreen extends StatelessWidget {
  const EnemyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnemyListBloc(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const EnemySliverAppBar(),
            SliverFillRemaining(
              child: BlocBuilder<EnemyListBloc, EnemyListState>(
                buildWhen: (previous, current) {
                  if (previous is EnemyListLoadedState &&
                      current is EnemyListLoadedState) {
                    return previous.filteredEnemyList !=
                        current.filteredEnemyList;
                  }
                  if (current is EnemyListLoadedState) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is EnemyListInitState) {
                    context
                        .read<EnemyListBloc>()
                        .add(const EnemyListInitEvent());
                  }
                  if (state is EnemyListErrorState) {
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
                  if (state is! EnemyListLoadedState &&
                      state.enemyList?.isEmpty == true) {
                    return const CommonLoadingWidget();
                  }
                  if ((state as EnemyListLoadedState)
                      .filteredEnemyList
                      .isEmpty) {
                    return const CommonNoResultWidget();
                  }
                  return CustomScrollView(
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
