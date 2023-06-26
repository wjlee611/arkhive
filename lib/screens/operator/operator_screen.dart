import 'package:arkhive/bloc/operator/operator_list/operator_list_bloc.dart';
import 'package:arkhive/bloc/operator/operator_list/operator_list_event.dart';
import 'package:arkhive/bloc/operator/operator_list/operator_list_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/operator/widgets/operator_bottom_appbar_widget.dart';
import 'package:arkhive/screens/operator/widgets/operator_listitem_widget.dart';
import 'package:arkhive/screens/operator/widgets/operator_sliver_appbar_widget.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_no_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorScreen extends StatelessWidget {
  const OperatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OperatorListBloc(),
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: Sizes.size3,
              ),
            ],
          ),
          child: const OperatorBottomAppBar(),
        ),
        body: CustomScrollView(
          slivers: [
            const OperatorSliverAppBar(),
            SliverFillRemaining(
              child: BlocBuilder<OperatorListBloc, OperatorListState>(
                buildWhen: (previous, current) {
                  if (previous is OperatorListLoadedState &&
                      current is OperatorListLoadedState) {
                    return previous.filteredOperatorList !=
                        current.filteredOperatorList;
                  }
                  if (current is OperatorListLoadedState) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is OperatorListInitState) {
                    context
                        .read<OperatorListBloc>()
                        .add(const OperatorListInitEvent());
                  }
                  if (state is OperatorListErrorState) {
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
                  if (state is! OperatorListLoadedState &&
                      state.operatorList?.isEmpty == true) {
                    return const CommonLoadingWidget();
                  }
                  if ((state as OperatorListLoadedState)
                      .filteredOperatorList
                      .isEmpty) {
                    return const CommonNoResultWidget();
                  }
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => GestureDetector(
                            onTap: () => OpenDetailScreen.onOperatorTab(
                              context: context,
                              operatorKey:
                                  state.filteredOperatorList[index].operatorKey,
                            ),
                            child: OperatorListItem(
                              operator_: state.filteredOperatorList[index],
                              index: index,
                            ),
                          ),
                          childCount: (state).filteredOperatorList.length,
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
