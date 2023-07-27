import 'package:arkhive/bloc/item/item_list/item_list_bloc.dart';
import 'package:arkhive/bloc/item/item_list/item_list_event.dart';
import 'package:arkhive/bloc/item/item_list/item_list_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_no_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemListBloc(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // const EnemySliverAppBar(),
            SliverFillRemaining(
              child: BlocBuilder<ItemListBloc, ItemListState>(
                buildWhen: (previous, current) {
                  if (previous is ItemListLoadedState &&
                      current is ItemListLoadedState) {
                    return previous.filteredItemList !=
                        current.filteredItemList;
                  }
                  if (current is ItemListLoadedState) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is ItemListInitState) {
                    context.read<ItemListBloc>().add(const ItemListInitEvent());
                  }
                  if (state is ItemListErrorState) {
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
                  if (state is! ItemListLoadedState &&
                      state.itemList?.isEmpty == true) {
                    return const CommonLoadingWidget();
                  }
                  if ((state as ItemListLoadedState).filteredItemList.isEmpty) {
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
                              return Text(
                                "${state.filteredItemList[index].iconId} - ${state.filteredItemList[index].classifyType}",
                              );
                            },
                            childCount: state.filteredItemList.length,
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
